//
//  Services.swift
//  Movalid
//
//  Created by Carlos Parada on 6/21/19.
//  Copyright © 2019 Carlos Parada. All rights reserved.
//

import Foundation

struct Services {
    static let geners =
        WebService.urlBase + EndPoint.geners + Keys.apiKey + Keys.location
    
    static let popular = WebService.urlBase + EndPoint.popular + Keys.apiKey + Keys.location
    
     static let topRated = WebService.urlBase + EndPoint.topRated + Keys.apiKey + Keys.location
    
    static let upcoming = WebService.urlBase + EndPoint.upcoming + Keys.apiKey + Keys.location
}

struct Keys {
    static let apiKey = Variable.apiKey + ProjectKeys.apiKey
    static let location = Variable.lenguage +  Configuration.shared.lenguage
}
