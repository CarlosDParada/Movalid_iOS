//
//  Services.swift
//  Movalid
//
//  Created by Carlos Parada on 6/21/19.
//  Copyright © 2019 Carlos Parada. All rights reserved.
//

import Foundation

class Services{
    func geners(by type:String) -> String{
        return WebService.urlBase + EndPoint().geners(by: type) + Keys.apiKey + Keys.location
    }
    func popular(by type:String) -> String{
        return WebService.urlBase + EndPoint().popular(by: type) + Keys.apiKey + Keys.location
    }
    func topRated(by type:String) -> String{
        return WebService.urlBase + EndPoint().topRated(by: type) + Keys.apiKey + Keys.location
    }
    func upcoming(by type:String) -> String{
        return WebService.urlBase + EndPoint().upcoming(by: type) + Keys.apiKey + Keys.location
    }
    func searching(by type:String) -> String{
        return WebService.urlBase + EndPoint().movieSearch(by: type) + Keys.apiKey + Keys.location
    }
}

struct Keys {
    static let apiKey = Variable().apiKey + ProjectKeys.apiKey
    static let location = Variable().lenguage +  "en-US" 
}
