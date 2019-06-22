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
    
    func getGeners(){
        manager.request(Services.geners).response { response in
            debugPrint(response)
        }
    }
    func getPopularMovies(page : Int)  {
        let requestString = Services.popular + Variable.page + "\(page)"
        manager.request(requestString).response { response in
            debugPrint(response)
        }
    }
    func getTopRatedMovies(page : Int)  {
        let requestString = Services.topRated + Variable.page + "\(page)"
        manager.request(requestString).response { response in
            debugPrint(response)
        }
    }
    func getUpCommingMovies(page : Int)  {
        let requestString = Services.upcoming + Variable.page + "\(page)"
        manager.request(requestString).response { response in
            debugPrint(response)
        }
    }
    
}
