//
//  SearchViewModel.swift
//  Movalid
//
//  Created by Carlos Parada on 6/22/19.
//  Copyright © 2019 Carlos Parada. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class SearchViewModel: NSObject {
    //MARK: - RxSwift
    let disposebag = DisposeBag()
    
    // MARK: - BehaviorRelay
    let isSuccessData = BehaviorRelay<[Film]>(value: [])
    let isErrorData = BehaviorRelay<ErrorModel>(value: ErrorHandle.errorGeneric())
    let isLoading = BehaviorRelay<Bool>(value: false)
    let films: BehaviorRelay<[Film]> = BehaviorRelay(value: [])
    
    override init() {
        CommunicationManager.shared.initialization()
    }
    func getSearchMovies(by type: String, category:String, key: String) {
        if !Connectivity.isConnectedToInternet() {
            if(type == Content.tv){
                DataLocal.shared.serieSearch = CoreDataHandler.getAllMovalid(by: category ,type: type)
                if(DataLocal.shared.serieSearch!.count > 0){
                    self.isSuccessData.accept(DataLocal.shared.serieSearch!)
                }else{
                    self.isErrorData.accept(ErrorHandle.errorGeneric(by: NSLocalizedString("alert.no.internet", comment: "Check connection"), status: ErrorConnection.requestTimeOut))
                }
            }else{
                DataLocal.shared.movieSearch = CoreDataHandler.getAllMovalid(by: category ,type: type)
                if(DataLocal.shared.movieSearch!.count > 0){
                    self.isSuccessData.accept(DataLocal.shared.movieSearch!)
                }else{
                    self.isErrorData.accept(ErrorHandle.errorGeneric(by: NSLocalizedString("alert.no.internet", comment: "Check connection"), status: ErrorConnection.requestTimeOut))
                }
            }
        }else{
            requestSearchMovies(by: type , category:category, key: key)
        }
    }
    
    func requestSearchMovies(by type:String , category:String, key: String){
        self.isLoading.accept(true)        
        WebServiceManager().getSearchMovies(by:type, category: category, keyString: key, page: 1, onCompletion: { (searchFilms) in
            
            // Save
            if ( searchFilms.results!.count > 0 ){
                for filmSng in searchFilms.results! {
                    CoreDataHandler.saveFilm(singleFilm: filmSng, category: category, type:type)
                }
                if(type == Content.tv){
                    DataLocal.shared.serieSearch = searchFilms.results!
                }else{
                    DataLocal.shared.movieSearch = searchFilms.results!
                }
                self.isSuccessData.accept(searchFilms.results!)
            }else{
                self.isErrorData.accept(ErrorHandle.errorGeneric(by: NSLocalizedString("alert.no.internet", comment: "Check connection"), status: ErrorConnection.requestTimeOut))
            }
            
        }) { (error) in
            self.isErrorData.accept(error )
        }
    }
}
