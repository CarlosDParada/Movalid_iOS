//
//  Result.swift
//  Movalid
//
//  Created by Carlos Parada on 6/21/19.
//  Copyright © 2019 Carlos Parada. All rights reserved.
//

import UIKit

class Result: Codable {
    var page: Int = 0
    var results: [Film]?
    var total_pages: Int = 0
    var total_results: Int = 0
    var status_code: String?
}

