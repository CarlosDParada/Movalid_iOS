//
//  Film.swift
//  Movalid
//
//  Created by Carlos Parada on 6/21/19.
//  Copyright © 2019 Carlos Parada. All rights reserved.
//

import Foundation

class Film: Codable {
    var vote_count: Int = 0
    var id: Int = 0
    var video: Bool = false
    var vote_average : Int = 0
    var title: String = ""
    var popularity: Int = 0
    var poster_path : String = ""
    var original_language : String = ""
    var original_title : String = ""
    var genre_ids : [Int] = [0,0]
    var backdrop_path : String = ""
    var overview : String = ""
    var release_date : String = ""
}
