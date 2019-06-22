//
//  TextString.swift
//  Movalid
//
//  Created by Carlos Parada on 6/22/19.
//  Copyright © 2019 Carlos Parada. All rights reserved.
//

import Foundation

struct MessageString {
    static let accept =  NSLocalizedString("alert.msg.accept", comment: "")
    static let cancel = NSLocalizedString("alert.msg.cancel", comment: "")
    static let tryAgain = NSLocalizedString("alert.msg.reintentar", comment: "")
    static let wait = NSLocalizedString("alert.msg.loading", comment: "")
    static let upps = NSLocalizedString("msg.error.service.general", comment: "")
    static let perfect = NSLocalizedString("alert.msg.perfect", comment: "")
    static let versionLoading = AppConfiguration.getAppVersion()+"("+AppConfiguration.getAppBuild()+")"
    
    
    /* Text Alert Loadign */
    static func setupTextAlertLoading(by error:ErrorModel) -> String{
        switch error.codeError{
        case ErrorConnection.requestTimeOut ,ErrorConnection.connectionAbort :
            return NSLocalizedString("alert.no.internet", comment: "Check connection")
        default:
            return MessageString.upps
        }
    }
}

