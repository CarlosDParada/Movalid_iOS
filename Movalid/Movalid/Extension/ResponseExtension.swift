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
    func turnToObject<T : Decodable>(data : Data, type: T.Type) -> T? where T: Decodable {
        let decoder = JSONDecoder()
        do {
            let allData = try? decoder.decode(T.self, from: data)
            return allData
        } catch {
            print(error)
        }
        return nil
    }

}

extension JSONDecoder {
    func decodeResponse<T: Decodable>(from response: DataResponse<Data>) -> Result<T> {
        guard response.error == nil else {
            print(response.error!)
            return .failure(response.error!)
        }
        
        guard let responseData = response.data else {
            print("didn't get any data from API")
            return .failure(response.error!)
        }
        
        do {
            let item = try decode(T.self, from: responseData)
            return .success(item)
        } catch {
            print("error trying to decode response")
            print(error)
            return .failure(error)
        }
    }
}
