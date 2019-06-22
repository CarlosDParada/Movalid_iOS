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
    let manager = SessionManager.default
   
}

class WebServiceManager {

    internal func request( url: String, completion: @escaping ( _ data: Data?, _ error: Error?) -> Void) {
        let request = URLRequest(url: URL(string: url)!)
        //.validate(statusCode: 200..<300).validate(contentType: ["application/json"])
        CommunicationManager.shared.manager.request(request)
            .responseData { response in
                switch response.result {
                case .success:
                    if let data = response.data {
                        completion(data, response.error)
                    }
                case .failure(let e):
                    completion(nil, response.error)
                    print("Error: " + e.localizedDescription)
                    
                }
        }
    }
    
    internal func requestData( url: String, completion: @escaping ( _ response: DataResponse<Data>) -> Void) {
        let request = URLRequest(url: URL(string: url)!)
        CommunicationManager.shared.manager.request(request)
            .responseData { response in
                switch response.result {
                case .success:
                    if let data = response.data {
                        completion(response)
                    }
                case .failure(let e):
                    print("Error: " + e.localizedDescription)
                    
                }
        }
    }
    
    func getGeners(onCompletion:@escaping(GenersGlobal)->Void,
                   onError:@escaping(Error)->Void){
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
                                 onError:@escaping(Error)->Void){
        let requestString = Services.popular + Variable.page + "\(page)"
        requestData(url: requestString) { (response) in
            
            let decoder = JSONDecoder()
            let obj: Result<ResultSearch> = decoder.decodeResponse(from: response)
            print(obj)
//            let json: String = NSString(data: data!, encoding: String.Encoding.utf8.rawValue) as! String
//            let obj : Result <ResultSearch> = WebServiceManager().turnToObject(data: data!, type: ResultSearch.self)
            //            let obj = WebServiceManager().turnToObject2(jsonString: json, type: ResultSearch.self)
//            if(obj != nil){
//                onCompletion(obj!)
//            }else{
//                onError(error!)
//            }
        }
    }
    
    func getTopRatedMovies(page: Int , onCompletion:@escaping(ResultSearch)->Void,
                           onError:@escaping(Error)->Void){
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
                                   onError:@escaping(Error)->Void){
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
