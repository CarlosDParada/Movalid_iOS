//
//  ViewController.swift
//  Movalid
//
//  Created by Carlos Parada on 6/21/19.
//  Copyright © 2019 Carlos Parada. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let serviceManager : WebServiceManager = WebServiceManager()
        serviceManager.getGeners(onCompletion: { geners in
            for gener in geners.genres! {
                CoreDataHandler.saveGeners(singleGen:gener)
                for genr in CoreDataHandler.getAllGeners() {
                    print("\(genr.id) - \(genr.name)")
                }
                
            }
        }) { (Error) in
            //
        }
    }


}

