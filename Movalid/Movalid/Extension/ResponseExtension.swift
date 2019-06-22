//
//  ResponseExtension.swift
//  Movalid
//
//  Created by Carlos Parada on 6/21/19.
//  Copyright © 2019 Carlos Parada. All rights reserved.
//
import UIKit
import Alamofire

extension WebServiceManager {
    func turnToObject<T>(data : Data, type: T.Type) -> T? where T: Decodable {
//    func turnToObject<T>(json : String, type: T.Type) -> T? where T: Decodable {
        do {
            guard let allData = try? JSONDecoder().decode(type, from: data) else {
//             guard let allData = try? JSONSerialization.data(withJSONObject: json , options: .prettyPrinted) else {
                return nil
            }
            return allData
        } 
    }
}
