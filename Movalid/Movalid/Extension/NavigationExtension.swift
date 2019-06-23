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
    
    static func searchViewController() -> UINavigationController{
        let navigationController = UINavigationController(rootViewController: ViewControllerExtension.searchViewController())
        return navigationController
    }
    static func detailViewController() -> UINavigationController{
        let navigationController = UINavigationController(rootViewController: ViewControllerExtension.detailViewController())
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
    static func searchViewController() -> SearchViewController{
        let storyboard = UIStoryboard.init(name: "SearchStoryboard" , bundle: nil)
        let homeVC : SearchViewController = storyboard.instantiateViewController(withIdentifier: "search") as?
            SearchViewController ?? SearchViewController.init()
        return homeVC
    }
    static func detailViewController() -> DetailViewController{
        let storyboard = UIStoryboard.init(name: "DetailStoryboard" , bundle: nil)
        let homeVC : DetailViewController = storyboard.instantiateViewController(withIdentifier: "detail") as?
            DetailViewController ?? DetailViewController.init()
        return homeVC
    }
}
