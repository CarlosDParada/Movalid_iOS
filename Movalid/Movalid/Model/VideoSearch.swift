//
//  VideoSearch.swift
//  Movalid
//
//  Created by Carlos Parada on 6/23/19.
//  Copyright © 2019 Carlos Parada. All rights reserved.
//

import UIKit

class VideoSearch: Codable {
    var id: Int?
    var results: [Videos]?
}

class Videos: Codable {
    var id: String?
    var key: String?
    var name: String?
    var site: String?
    var type: String?
}
