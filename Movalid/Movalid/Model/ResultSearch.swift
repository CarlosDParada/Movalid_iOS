//
//  Result.swift
//  Movalid
//
//  Created by Carlos Parada on 6/21/19.
//  Copyright © 2019 Carlos Parada. All rights reserved.
//

import UIKit

class ResultSearch: Codable {
    var page: Int?
    var results: [Film]?
    var total_pages: Int?
    var total_results: Int?
}
