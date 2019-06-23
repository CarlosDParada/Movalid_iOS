//
//  DetailViewModel.swift
//  Movalid
//
//  Created by Carlos Parada on 6/23/19.
//  Copyright © 2019 Carlos Parada. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class DetailViewModel: BaseViewModel {
    
    override init() {
        CommunicationManager.shared.initialization()
    }
    
    func getVideoContent(_ idString: String){
        if !Connectivity.isConnectedToInternet() {
            DataLocal.shared.geners = CoreDataHandler.getAllGeners()
            self.getPopularMovies(by: Content.movie)
        }else{
            requestVideoContent(idString)
        }
    }
    
    func requestVideoContent(_ idString: String){
        self.isLoading.accept(true)
        
        WebServiceManager().getVideoContent(by: idString , onCompletion: { (videoSearch) in
            
        }) { (error) in
            self.isErrorData.accept(error )
        }
    }
    
}
