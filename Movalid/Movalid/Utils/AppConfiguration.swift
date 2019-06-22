//
//  AppConfiguration.swift
//  Movalid
//
//  Created by Carlos Parada on 6/22/19.
//  Copyright © 2019 Carlos Parada. All rights reserved.
//

import UIKit

class AppConfiguration {
    static func getAppVersion() -> String {
        let version = self.getDictionary()?["CFBundleShortVersionString"] as? String ?? ""
        return version
    }
    
    static func getDictionary() -> [String : Any]? {
        let dictionary = Bundle.main.infoDictionary
        return dictionary
    }
    
    static func getAppBuild() -> String {
        let version = self.getDictionary()?["CFBundleVersion"] as? String ?? "000"
        return version
    }
}
