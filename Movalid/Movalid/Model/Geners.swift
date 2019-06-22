//
//  Geners.swift
//  Movalid
//
//  Created by Carlos Parada on 6/21/19.
//  Copyright © 2019 Carlos Parada. All rights reserved.
//

import UIKit
struct Geners : Codable {
    var genres : [StandarModel]?
    
}
struct StandarModel: Codable {
    var id: Int?
    var name: String?
}
