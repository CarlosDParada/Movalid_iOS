//
//  BaseViewController.swift
//  Movalid
//
//  Created by Carlos Parada on 6/22/19.
//  Copyright © 2019 Carlos Parada. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    /* Nav Buttons */
    var btnSearch : UIButton!
    var btnImgLogo : UIButton!
    /* Loading View */
    var loadingView : UIView!
    var aiView : UIActivityIndicatorView!
    var labelLoading : UILabel!
    var textLoading : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*Loading*/
        self.buildLoadingView()
        /*Buttons Nav*/
        buildNavButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isTranslucent = false
       
        navigationController?.navigationBar.barTintColor = UIColor.backgroundColor
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.font:               UIFont.mainFontRegular(ofSize:  25),
             NSAttributedString.Key.foregroundColor:    UIColor.lightBlue]
        
        /* Current */
        let currentWindows = UIApplication.shared.keyWindow
        currentWindows?.addSubview(self.loadingView)
        self.loadingView.isHidden = true
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.removeLoadingView()
    }
    func setupTitleNavigation(by title:String){
        self.title = title
    }
    
    func buildLoadingView(){
        self.loadingView = UIView.init(frame: CGRect.init(x: self.view.frame.origin.x,
                                                          y: self.view.frame.origin.y,
                                                          width: UIScreen.main.bounds.size.width,
                                                          height: UIScreen.main.bounds.size.height))
        self.loadingView.backgroundColor = UIColor.gray
        self.loadingView.alpha = 0.85
        self.aiView = UIActivityIndicatorView.init(style: .whiteLarge)
        self.aiView.center = CGPoint.init(x: self.loadingView.center.x, y: self.loadingView.center.y)
        self.labelLoading = UILabel.init(frame: CGRect.init(x: 0,
                                                            y:( UIScreen.main.bounds.size.height / 2 ) + 40,
                                                            width: UIScreen.main.bounds.size.width,
                                                            height: 20))
        self.labelLoading.textAlignment = .center
        self.labelLoading.text = self.textLoading
        self.labelLoading.textColor = UIColor.white
        self.labelLoading.numberOfLines = 0
        self.labelLoading.font = UIFont.mainFontRegular(ofSize: 13)
        self.loadingView.addSubview(self.labelLoading)
        self.loadingView.addSubview(self.aiView)
    }
    
    //MARK: -  🤔 Loadinv View
    func removeLoadingView() {
        self.loadingView.isHidden = true
        self.aiView.stopAnimating()
    }
    func showLoadignView(){
        self.textLoading = ""
        self.labelLoading.text = ""
        if (self.loadingView != nil) {
            self.loadingView.isHidden = false
            self.labelLoading.isHidden = false
            self.aiView.startAnimating()
        }else{
            self.buildLoadingView()
            self.loadingView.isHidden = false
            self.labelLoading.isHidden = false
            self.aiView.startAnimating()
        }
    }
    
    func buildNavButtons() {
        /* Find */
        self.btnSearch = UIButton.init(type: .custom)
        let frameMN = CGRect.init(x: 0, y: 0, width: 40, height: 40)
        self.btnSearch.frame = frameMN
        self.btnSearch.setImage(UIImage.navSearchIcon(), for: .normal)
        self.btnSearch.addTarget(self, action: #selector(self.searchPressed), for: .touchUpInside)
        let itemSalir = UIBarButtonItem.init(customView: self.btnSearch)
        self.navigationItem.setRightBarButton(itemSalir, animated: true)
    }
    
    //MARK: - searchPressed
    @objc func searchPressed (){
        let goTOVC : UINavigationController = NavigationExtension.searchViewController()
        self.present(goTOVC, animated: true) { }
    }
}
