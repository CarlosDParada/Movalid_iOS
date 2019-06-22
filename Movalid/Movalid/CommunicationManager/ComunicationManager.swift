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
            .responseJSON { response in
                switch response.result {
                case .success:
                    if let data = response.data {
                        completion(data, nil)
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
        request(url: requestString) { (data, error) in
            let obj = WebServiceManager().turnToObject(data: data!, type: ResultSearch.self)
            if(obj != nil){
                onCompletion(obj!)
            }else{
                onError(error!)
            }
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
