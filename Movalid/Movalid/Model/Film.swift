//
//  Film.swift
//  Movalid
//
//  Created by Carlos Parada on 6/21/19.
//  Copyright © 2019 Carlos Parada. All rights reserved.
//

import Foundation

class Film: Codable {
    var vote_count: Int?
    var id: Int?
    var video: Bool?
    var title: String?
    var poster_path : String?
    var original_language : String?
    var original_title : String?
    var genre_ids : [Int]?
    var backdrop_path : String?
    var overview : String?
    var release_date : String?
    var category : String?
    var type : String?
    
    init(by movalid : Movalid , category : String) {
        self.vote_count = Int(movalid.vote_count)
        self.id = Int(movalid.id)
        self.video = movalid.video
        self.title = movalid.title ?? ""
        self.poster_path = movalid.poster_path ?? ""
        self.original_language = movalid.original_language ?? ""
        self.original_title = movalid.original_title ?? ""
        self.genre_ids = movalid.genre_ids as! [Int]
        self.backdrop_path = movalid.backdrop_path ?? ""
        self.overview = movalid.overview ?? ""
        self.release_date = movalid.release_date ?? ""
        self.category = category
        self.type = Configuration.shared.type
    }
}
