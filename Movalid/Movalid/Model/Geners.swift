//
//  GenersGlobal.swift
//  Movalid
//
//  Created by Carlos Parada on 6/21/19.
//  Copyright © 2019 Carlos Parada. All rights reserved.
//

import UIKit
struct GenersGlobal : Codable {
    var genres : [StandarModel]?    
}
struct StandarModel: Codable {
    var id: Int! = 0
    var name: String! = ""
    
    init(id :Int , name: String) {
        self.id = id
        self.name = name
    }
}
