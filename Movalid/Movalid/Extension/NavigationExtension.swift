//
//  NavigationExtension.swift
//  Movalid
//
//  Created by Carlos Parada on 6/22/19.
//  Copyright © 2019 Carlos Parada. All rights reserved.
//

import UIKit

class NavigationExtension: NSObject {
    
    static func homeViewController() -> UINavigationController{
        let navigationController = UINavigationController(rootViewController: ViewControllerExtension.homeViewController())
        return navigationController
    }
    
}

class ViewControllerExtension: NSObject {
    
    static func homeViewController() -> HomeViewController{
        let storyboard = UIStoryboard.init(name: "HomeStoryboard" , bundle: nil)
        let homeVC : HomeViewController = storyboard.instantiateViewController(withIdentifier: "home") as?
            HomeViewController ?? HomeViewController.init()
        return homeVC
    }
}
