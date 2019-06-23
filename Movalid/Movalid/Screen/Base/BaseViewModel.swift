//
//  BaseViewModel.swift
//  Movalid
//
//  Created by Carlos Parada on 6/23/19.
//  Copyright © 2019 Carlos Parada. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BaseViewModel: NSObject {
    //MARK: - RxSwift
    let disposebag = DisposeBag()
    
    // MARK: - BehaviorRelay
    let isSuccessData = BehaviorRelay<Bool>(value: false)
    let isErrorData = BehaviorRelay<ErrorModel>(value: ErrorHandle.errorGeneric())
    let isLoading = BehaviorRelay<Bool>(value: false)
    
    override init() {
        CommunicationManager.shared.initialization()
    }
    
    func requestInitialData(){
        self.isLoading.accept(true)
        WebServiceManager().getGeners(by: Content.movie, onCompletion: {
            geners in
            if (geners.genres!.count > 0){
                CoreDataHandler.deleteGeners()
                for gener in geners.genres! {
                    CoreDataHandler.saveGeners(singleGen:gener)
                }
                // Save
                DataLocal.shared.geners = geners.genres!
                self.getPopularMovies(by: Content.movie)
            }
        }) { (error) in
            self.isErrorData.accept(error)
        }
    }
    
    /*
     * Get Popular Movies
     */
    func getPopularMovies(by type:String) {
        if !Connectivity.isConnectedToInternet() {
            // Save
            if(type == Content.tv){
               DataLocal.shared.seriePopular = CoreDataHandler.getAllMovalid(by: Category.popular ,type: type)
            }else{
               DataLocal.shared.moviePopular = CoreDataHandler.getAllMovalid(by: Category.popular ,type: type)
            }
            if(DataLocal.shared.moviePopular!.count > 0){
                self.isSuccessData.accept(true)
            }else{
                self.isErrorData.accept(ErrorHandle.errorGeneric(by: NSLocalizedString("alert.no.internet", comment: "Check connection"), status: ErrorConnection.requestTimeOut))
            }
        }else{
            requestPopularMovies(by: type)
        }
    }
    
    func requestPopularMovies(by type:String) {
        self.isLoading.accept(true)
        WebServiceManager().getPopularMovies(by: type,  page: 1, onCompletion: {
            (filmsPopular) in
            CoreDataHandler.deleteMovalid(by: Category.popular)
            for filmSng in filmsPopular.results! {
                CoreDataHandler.saveFilm(singleFilm: filmSng, category: Category.popular , type:type)
            }
            // Save
            if(type == Content.tv){
                DataLocal.shared.seriePopular = filmsPopular.results!
            }else{
                DataLocal.shared.moviePopular = filmsPopular.results!
            }
            self.isSuccessData.accept(true)
        }) { (error) in
            self.isErrorData.accept(error )
        }
    }
    
    /* Get Top Movies */
    func getTopRatedMovies(by type:String) {
        if !Connectivity.isConnectedToInternet() {
            if(type == Content.tv){
                DataLocal.shared.serieTop = CoreDataHandler.getAllMovalid(by: Category.topRated ,type: type)
            }else{
                DataLocal.shared.movieTop = CoreDataHandler.getAllMovalid(by: Category.topRated ,type: type)
            }
            if(DataLocal.shared.movieTop!.count > 0){
                self.isSuccessData.accept(true)
            }else{
                self.isErrorData.accept(ErrorHandle.errorGeneric(by: NSLocalizedString("alert.no.internet", comment: "Check connection"), status: ErrorConnection.requestTimeOut))
            }
        }else{
            requestTopMovies(by: type)
        }
    }
    
    
    func requestTopMovies(by type:String){
        self.isLoading.accept(true)
        WebServiceManager().getTopRatedMovies(by:type,page: 1, onCompletion: {
            (filmsTops) in
            CoreDataHandler.deleteMovalid(by: Category.topRated)
            for filmSng in filmsTops.results! {
                CoreDataHandler.saveFilm(singleFilm: filmSng, category: Category.topRated, type:type)
            }
            // Save
            if(type == Content.tv){
                DataLocal.shared.serieTop = filmsTops.results!
            }else{
                DataLocal.shared.movieTop = filmsTops.results!
            }
            self.isSuccessData.accept(true)
        }) { (error) in
            self.isErrorData.accept(error )
        }
    }
    
    /* Get UpComming Movies */
    func getUpCommingMovies(by type:String){
        if !Connectivity.isConnectedToInternet() {
            if(type == Content.tv){
                DataLocal.shared.serieUpcoming = CoreDataHandler.getAllMovalid(by: Category.upcoming ,type: type)
            }else{
                DataLocal.shared.movieUpcoming = CoreDataHandler.getAllMovalid(by: Category.upcoming ,type: type)
            }
            if(DataLocal.shared.movieTop!.count > 0){
                self.isSuccessData.accept(true)
            }else{
                self.isErrorData.accept(ErrorHandle.errorGeneric(by: NSLocalizedString("alert.no.internet", comment: "Check connection"), status: ErrorConnection.requestTimeOut))
            }
        }else{
            requestUpComming(by: type)
        }
    }
    
    func requestUpComming(by type:String){
        self.isLoading.accept(true)
        WebServiceManager().getUpCommingMovies(by:type, page: 1, onCompletion: {
            (filmsTops) in
            CoreDataHandler.deleteMovalid(by: Category.upcoming)
            for filmSng in filmsTops.results! {
                CoreDataHandler.saveFilm(singleFilm: filmSng, category: Category.upcoming, type:type)
            }
            // Save
            if(type == Content.tv){
                DataLocal.shared.serieUpcoming = filmsTops.results!
            }else{
                DataLocal.shared.movieUpcoming = filmsTops.results!
            }
            self.isSuccessData.accept(true)
        }) { (error) in
            self.isErrorData.accept(error )
        }
    }
}

