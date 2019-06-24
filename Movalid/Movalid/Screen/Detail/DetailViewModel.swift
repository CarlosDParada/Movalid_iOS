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
    
    
    let isSuccessVideo = BehaviorRelay<VideoSearch?>(value: nil)
    
    override init() {
        CommunicationManager.shared.initialization()
    }
    
    func getVideoContent(by type: String , stringKey: String){
        if !Connectivity.isConnectedToInternet() {
            DataLocal.shared.geners = CoreDataHandler.getAllGeners()
            self.getPopularMovies(by: Content.movie)
        }else{
            requestVideoContent(bytype: type, idKey: stringKey)
        }
    }
    
    func requestVideoContent(bytype: String , idKey: String){
        self.isLoading.accept(true)
        
        WebServiceManager().getVideoContent(by: bytype , idString: idKey , onCompletion: { (videoSearch) in
            self.isLoading.accept(false)
            self.isSuccessVideo.accept(videoSearch)
        }) { (error) in
            self.isLoading.accept(false)
            self.isErrorData.accept(error )
        }
    }
    
}
