//
//  LoadingViewModel.swift
//  Movalid
//
//  Created by Carlos Parada on 6/22/19.
//  Copyright © 2019 Carlos Parada. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoadingViewModel: BaseViewModel {
    
    override init() {
        CommunicationManager.shared.initialization()
    }
    func getInitialData(){
        if !Connectivity.isConnectedToInternet() {
           DataLocal.shared.geners = CoreDataHandler.getAllGeners()
            self.getPopularMovies(by: Content.movie)
        }else{
            requestInitialData()
        }
    }
    
}
