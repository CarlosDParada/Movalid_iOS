//
//  ErrorExtension.swift
//  Movalid
//
//  Created by Carlos Parada on 6/22/19.
//  Copyright © 2019 Carlos Parada. All rights reserved.
//

import UIKit
import Alamofire

struct ErrorModel {
    var serviceName: String?
    var message: String?
    var codeError: Int?
}

extension ErrorModel {
    mutating func initWith(code: Int , message : String , serviceName: String){
        self.serviceName = serviceName
        self.codeError = code
        self.message = message
    }
}

class ErrorHandle {
    static func errorGeneric() -> ErrorModel{
        return ErrorModel.init(serviceName:  MovalidSParams.errorGeneric,
                               message:MessageString.upps ,
                               codeError: 0)
        
    }
    
    static func errorGeneric(by error: Error , status : Int) -> ErrorModel{
        return ErrorModel.init(serviceName:  MovalidSParams.errorGeneric,
                               message:error.localizedDescription ,
                               codeError: status)
        
    }
    
    static func errorResponseToObject(from response: DataResponse<Data> , errorData: Error?) throws -> ErrorModel{
        if errorData != nil {
            let errorObj : ErrorModel = ErrorModel.init(serviceName: MovalidSParams.errorGeneric,
                                                        message: errorData?.localizedDescription,
                                                        codeError: response.response?.statusCode)
            return errorObj
        }else{
            return ErrorModel.init(serviceName: MovalidSParams.errorGeneric,
                                   message: MessageString.upps ,
                                   codeError: response.response?.statusCode)
        }
    }
}
