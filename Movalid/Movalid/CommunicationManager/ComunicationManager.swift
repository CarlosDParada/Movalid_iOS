//
//  ComunicationManager.swift
//  Movalid
//
//  Created by Carlos Parada on 6/21/19.
//  Copyright © 2019 Carlos Parada. All rights reserved.
//

import Foundation
import Alamofire


class CommunicationManager {
    static let shared = CommunicationManager()
    var manager = SessionManager.default
    func initialization() {
        self.manager = SessionManager.default
    }
}

class WebServiceManager {
    
    /// General request
    ///
    /// - Parameters:
    ///   - url: string with url
    ///   - completion: escaping of success
    ///   - onError: escaping of error
    internal func request( url: String, completion: @escaping ( _ data: Data?)->Void,
                           onError:@escaping(ErrorModel) -> Void) {
        let request = URLRequest(url: URL(string: url)!)
        //.validate(statusCode: 200..<300).validate(contentType: ["application/json"])
        CommunicationManager.shared.manager.request(request).validate(statusCode: 200..<300)
            .validate { request, response, data in
                // Custom evaluation closure now includes data (allows you to parse data to dig out error messages if necessary)
                return .success
            }.responseData { response in
                switch response.result {
                case .success:
                    if let data = response.data {
                        completion(data)
                    }
                case .failure(let error):
                    let httpStatusCode = response.response?.statusCode
                    onError(ErrorHandle.errorGeneric(by: error, status: httpStatusCode ?? 0))
                    print("Error: " + error.localizedDescription)
                    
                }
        }
    }
    
    /// Request for especific URL and escaping
    ///
    /// - Parameters:
    ///   - url: string with url/endpoint
    ///   - completion: Data escaping of success
    internal func requestData( url: String, completion: @escaping ( _ response: DataResponse<Data>) -> Void) {
        let request = URLRequest(url: URL(string: url)!)
        CommunicationManager.shared.manager
            .request(request).validate(statusCode: 200..<300).validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    if response.data != nil {
                        completion(response)
                    }
                case .failure(let e):
                    print("Error: " + e.localizedDescription)
                    
                }
        }
    }
    
    /// Return Geners in ThemovieDB
    ///
    /// - Parameters:
    ///   - type: movie/tv
    ///   - completion: escaping of success
    ///   - onError: escaping of error
    func getGeners(by type:String, onCompletion:@escaping(GenersGlobal)->Void,
                   onError:@escaping(ErrorModel)->Void){
        
        request(url: Services().geners(by: type), completion: { (data) in
            let obj = WebServiceManager().turnToObject(data: data!, type: GenersGlobal.self)
            if(obj != nil){
                onCompletion(obj!)
            }
        }) { (error) in
            onError(error)
        }
    }
    /// Return Popular movie/serie in ThemovieDB
    ///
    /// - Parameters:
    ///   - type: movie/serie
    ///   - page: for pagination
    ///   - onCompletion: escaping of success
    ///   - onError: escaping of error
    func getPopularMovies(by type:String, page: Int , onCompletion:@escaping(ResultSearch)->Void,
                          onError:@escaping(ErrorModel)->Void){
        let requestString = Services().popular(by: type) + Variable().page + "\(page)"
        requestData(url: requestString) { (response) in
            
            let decoder = JSONDecoder()
            let obj: Result<ResultSearch> = decoder.decodeResponse(from: response)
            print(obj)
            if(obj.isSuccess){
                obj.flatMap({ popularMoviesObjet in
                    onCompletion(popularMoviesObjet)
                })
            }else{
                onError(ErrorHandle.errorGeneric(by: obj.error!, status: -1))
            }
        }
    }
    
    /// Return Top Rated movie/serie in ThemovieDB
    ///
    /// - Parameters:
    ///   - type: movie/serie
    ///   - page: for pagination
    ///   - onCompletion: escaping of success
    ///   - onError: escaping of error
    func getTopRatedMovies(by type:String, page: Int , onCompletion:@escaping(ResultSearch)->Void,
                           onError:@escaping(ErrorModel)->Void){
        let requestString = Services().topRated(by: type) + Variable().page + "\(page)"
        request(url: requestString, completion: { (data) in
            let obj = WebServiceManager().turnToObject(data: data!, type: ResultSearch.self)
            if(obj != nil){
                onCompletion(obj!)
            }
        }) { (error) in
            onError(error)
        }
    }
    /// Return UpComming movie/serie in ThemovieDB
    ///
    /// - Parameters:
    ///   - type: movie/serie
    ///   - page: for pagination
    ///   - onCompletion: escaping of success
    ///   - onError: escaping of error
    func getUpCommingMovies(by type:String,page: Int , onCompletion:@escaping(ResultSearch)->Void,
                            onError:@escaping(ErrorModel)->Void){
        let requestString = Services().upcoming(by: type) + Variable().page + "\(page)"
        request(url: requestString, completion: { (data) in
            let obj = WebServiceManager().turnToObject(data: data!, type: ResultSearch.self)
            if(obj != nil){
                onCompletion(obj!)
            }
        }) { (error) in
            onError(error)
        }
    }
    
    /*      Search Movies
     */
    /// Search movie/serie in ThemovieDB by parameters
    ///
    /// - Parameters:
    ///   - type: movie/serie
    ///   - category: if exist top/popular/upcomming
    ///   - keyString: string for search
    ///   - page: for pagination
    ///   - onCompletion: escaping of success
    ///   - onError: escaping of error
    
    func getSearchMovies(by type:String, category:String, keyString:String, page: Int , onCompletion:@escaping(ResultSearch)->Void,
                          onError:@escaping(ErrorModel)->Void){
        let requestString = Services().searching(by: type) + Variable().page + "\(page)" + Variable().query + "\(keyString)"
        requestData(url: requestString) { (response) in
            
            let decoder = JSONDecoder()
            let obj: Result<ResultSearch> = decoder.decodeResponse(from: response)
            print(obj)
            if(obj.isSuccess){
                obj.flatMap({ searchMoviesObjet in
                    onCompletion(searchMoviesObjet)
                })
            }else{
                onError(ErrorHandle.errorGeneric(by: obj.error!, status: -1))
            }
        }
    }
    
    /* GetVideo */
    /// REturn object with Video key for Youtube
    ///
    /// - Parameters:
    ///   - type: tv/moive
    ///   - idString: id of ty/movie
    ///   - onCompletion: escaping of success with object VideoSearch
    ///   - onError: escaping of error
    func getVideoContent(by type:String , idString:String , onCompletion:@escaping(VideoSearch)->Void,
                          onError:@escaping(ErrorModel)->Void){
        let requestString = Services().getVideo(by: type , idString: idString)
        requestData(url: requestString) { (response) in
            
            let decoder = JSONDecoder()
            let obj: Result<VideoSearch> = decoder.decodeResponse(from: response)
            print(obj)
            if(obj.isSuccess){
                obj.flatMap({ popularMoviesObjet in
                    
                    onCompletion(popularMoviesObjet)
                })
            }else{
                onError(ErrorHandle.errorGeneric(by: obj.error!, status: -1))
            }
        }
    }
}
