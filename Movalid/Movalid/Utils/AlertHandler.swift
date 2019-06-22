//
//  AlertHandler.swift
//  Movalid
//
//  Created by Carlos Parada on 6/22/19.
//  Copyright © 2019 Carlos Parada. All rights reserved.
//

import UIKit

extension UIAlertController {

    func showSimpleCancelAlert() -> UIAlertController{
        let alert = UIAlertController(title: nil, message: MessageString.upps, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: MessageString.cancel, style: .cancel, handler: nil))
//                self.present(alert, animated: true)
        return alert
    }
    
    open class func actionShowOneAction(by title:String?, message:String?, button:String , action : @escaping (UIAlertAction) -> Void) -> UIAlertController {
        let alertVS : UIAlertController = UIAlertController.init(title: title,
                                                                 message: message,
                                                                 preferredStyle: .alert)
        let actionOne : UIAlertAction = UIAlertAction.init(title: button, style: .default, handler: action)
        alertVS.addAction(actionOne)
        return alertVS
    }
}
