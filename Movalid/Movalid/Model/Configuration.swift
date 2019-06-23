//
//  Configuration.swift
//  Movalid
//
//  Created by Carlos Parada on 6/21/19.
//  Copyright © 2019 Carlos Parada. All rights reserved.
//

import Foundation
class Configuration {
    static var shared = Configuration()
    
    var type : String = Content.movie
    var inType : Int = IntContent.movie
    
    var category : String = Category.popular
    var intCategory : Int = IntCategory.popular
    
    var lenguage : String = Lenguage.eng
    
}
