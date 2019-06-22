//
//  LoadingViewController.swift
//  Movalid
//
//  Created by Carlos Parada on 6/22/19.
//  Copyright © 2019 Carlos Parada. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoadingViewController: UIViewController {
    
    @IBOutlet weak var lblVersion: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var activityIndicatorLoading: UIActivityIndicatorView!
    
    /* Rx Swift */
    let viewModel = LoadingViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblVersion.text = MessageString.wait
        lblMessage.text = MessageString.versionLoading
        createCallbacks()
        self.viewModel.getInitialData()
    }
    //MARK: - RxSwift
    func createCallbacks (){
        /* Error Response */
        viewModel.isErrorData.asObservable()
            .bind{ errorModel in
                if (errorModel.codeError != ErrorConnection.none ){
                    let messageAlert = MessageString.setupTextAlertLoading(by: errorModel)
                    let alertError : UIAlertController  =
                        UIAlertController.actionShowOneAction(by: "", message: messageAlert, button: MessageString.tryAgain) {_ in
                            self.viewModel.getInitialData()
                    }
                    self.present(alertError, animated: true, completion: nil)
                }else{
                    print("Success in \(errorModel.serviceName ?? "Empty")")
                }
            }.disposed(by: disposeBag)
        
        viewModel.isSuccessData.asObservable()
            .bind{state in
                if (state){
                    self.lblVersion.text = MessageString.perfect
                    self.showInitialScreen()
                }
            }.disposed(by: disposeBag)
        
        viewModel.isLoading.asObservable().bind { value in
            if value {
                self.activityIndicatorLoading.isHidden = false
                self.activityIndicatorLoading.startAnimating()
            }else{
                self.activityIndicatorLoading.stopAnimating()
                self.activityIndicatorLoading.isHidden = true
            }
            }.disposed(by: disposeBag)
    }
    
    
    func showInitialScreen() {
        let goTOVC : UINavigationController = NavigationExtension.homeViewController()
        self.present(goTOVC, animated: true) {
                        self.removeFromParent()
        }
    }
}
