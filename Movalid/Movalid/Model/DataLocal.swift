//
//  Data.swift
//  Movalid
//
//  Created by Carlos Parada on 6/21/19.
//  Copyright © 2019 Carlos Parada. All rights reserved.
//

import Foundation

class DataLocal {
    static var shared = DataLocal()
    var movieTop : [Film]?
    var moviePopular : [Film]?
    var movieUpcoming : [Film]?
    var serieTop : [Film]?
    var seriePopular : [Film]?
    var serieUpcoming : [Film]?
    var geners : [StandarModel]?
    var serieSearch : [Film]?
    var movieSearch : [Film]?
}
