//
//  Configuration.swift
//  Movalid
//
//  Created by Carlos Parada on 6/21/19.
//  Copyright © 2019 Carlos Parada. All rights reserved.
//

import Foundation
class Configuration {
    static let shared:Configuration = Configuration()
    var type : String?
    var inType : Int?
    var category : String?
    var intCategory : Int?
    var lenguage : String?
    
    func initByParamer(by intType : Int , intCategory: Int , lenguage : String) {
        self.inType = intType
        self.intCategory = intCategory
        self.lenguage = lenguage
        self.type = HandlerData.getCategoryString(by: intCategory)
        self.category = HandlerData.getCategoryString(by: intCategory)
    }
}
