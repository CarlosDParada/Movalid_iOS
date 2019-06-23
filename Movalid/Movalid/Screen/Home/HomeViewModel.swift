//
//  HomeViewModel.swift
//  Movalid
//
//  Created by Carlos Parada on 6/22/19.
//  Copyright © 2019 Carlos Parada. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel: BaseViewModel {
    
    override init() {
        CommunicationManager.shared.initialization()
    }
    
    func getFindMovies(by type:String,  category:String) {
        if !Connectivity.isConnectedToInternet() {
            let saveing = self.saveValuesForCategory(by: type, category: category)
            if(saveing.count > 0){
                self.isSuccessData.accept(true)
            }else{
                self.isErrorData.accept(ErrorHandle.errorGeneric(by: NSLocalizedString("alert.no.internet", comment: "Check connection"), status: ErrorConnection.requestTimeOut))
            }
        }else{
            requestFindMovies(by:type ,category: category)
        }
    }
    
    func requestFindMovies(by type:String , category:String){
        self.isLoading.accept(true)
        if (category == Category.topRated) {
            getTopRatedMovies(by: type)
        }else if(category == Category.upcoming) {
            getUpCommingMovies(by: type)
        }else{
            getPopularMovies(by: type)
        }
    }
    
    func saveValuesForCategory(by type:String , category:String) -> [Film]{
        
        if (type == Content.tv) {
            switch category {
            case Category.topRated:
                DataLocal.shared.serieTop = CoreDataHandler.getAllMovalid(by: category ,type: type)
                return DataLocal.shared.serieTop ?? []
            case Category.upcoming:
                DataLocal.shared.serieUpcoming = CoreDataHandler.getAllMovalid(by: category ,type: type)
                return DataLocal.shared.serieUpcoming ?? []
            default:
                DataLocal.shared.seriePopular = CoreDataHandler.getAllMovalid(by: category ,type: type)
                return DataLocal.shared.seriePopular ?? []
            }
        }else{
            switch category {
            case Category.topRated:
                DataLocal.shared.movieTop = CoreDataHandler.getAllMovalid(by: category ,type: type)
                return DataLocal.shared.movieTop ?? []
            case Category.upcoming:
                DataLocal.shared.movieUpcoming = CoreDataHandler.getAllMovalid(by: category ,type: type)
                return DataLocal.shared.movieUpcoming ?? []
            default:
                DataLocal.shared.moviePopular = CoreDataHandler.getAllMovalid(by: category ,type: type)
                return DataLocal.shared.moviePopular ?? []
            }
            
        }
        
        
    }
}
