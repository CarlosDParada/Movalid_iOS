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

    internal func request( url: String, completion: @escaping ( _ data: Data?, _ error: ErrorModel?) -> Void) {
        let request = URLRequest(url: URL(string: url)!)
        //.validate(statusCode: 200..<300).validate(contentType: ["application/json"])
        CommunicationManager.shared.manager.request(request).validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case .success:
                    if let data = response.data {
                        completion(data, nil)
                    }
                case .failure(let error):
                     let httpStatusCode = response.response?.statusCode
                     completion(nil, ErrorHandle.errorGeneric(by: error, status: httpStatusCode ?? 0))
                    print("Error: " + error.localizedDescription)
                    
                }
        }
    }
    
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
    
    func getGeners(onCompletion:@escaping(GenersGlobal)->Void,
                   onError:@escaping(ErrorModel)->Void){
        request(url: Services.geners) { (data, error) in
            let obj = WebServiceManager().turnToObject(data: data!, type: GenersGlobal.self)
            if(obj != nil){
                onCompletion(obj!)
            }else{
                onError(error!)
            }
        }
    }
    func getPopularMovies(page: Int , onCompletion:@escaping(ResultSearch)->Void,
                                 onError:@escaping(ErrorModel)->Void){
        let requestString = Services.popular + Variable.page + "\(page)"
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
    
    func getTopRatedMovies(page: Int , onCompletion:@escaping(ResultSearch)->Void,
                           onError:@escaping(ErrorModel)->Void){
        let requestString = Services.topRated + Variable.page + "\(page)"
        request(url: requestString) { (data, error) in
            let obj = WebServiceManager().turnToObject(data: data!, type: ResultSearch.self)
            if(obj != nil){
                onCompletion(obj!)
            }else{
                onError(error!)
            }
        }
    }
    func getUpCommingMovies(page: Int , onCompletion:@escaping(ResultSearch)->Void,
                                   onError:@escaping(ErrorModel)->Void){
        let requestString = Services.upcoming + Variable.page + "\(page)"
        request(url: requestString) { (data, error) in
            let obj = WebServiceManager().turnToObject(data: data!, type: ResultSearch.self)
            if(obj != nil){
                onCompletion(obj!)
            }else{
                onError(error!)
            }
        }
    }
}
