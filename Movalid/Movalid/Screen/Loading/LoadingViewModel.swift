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

class LoadingViewModel: NSObject {
    //MARK: - RxSwift
    let disposebag = DisposeBag()
    
    // MARK: - BehaviorRelay
    let isSuccessData = BehaviorRelay<Bool>(value: false)
    let isErrorData = BehaviorRelay<ErrorModel>(value: ErrorHandle.errorGeneric())
    let isLoading = BehaviorRelay<Bool>(value: false)
    
    override init() {
        print("Loading View Model")
        CommunicationManager.shared.initialization()
    }
    func getInitialData(){
        if !Connectivity.isConnectedToInternet() {
           DataLocal.shared.geners = CoreDataHandler.getAllGeners()
            self.getPopularMovies()
        }else{
            requestInitialData()
        }
    }
    
    func requestInitialData(){
        self.isLoading.accept(true)
        WebServiceManager().getGeners(onCompletion: {
            geners in
            if (geners.genres!.count > 0){
                for gener in geners.genres! {
                    
                    CoreDataHandler.deleteGeners()
                    CoreDataHandler.saveGeners(singleGen:gener)
                    for genr in CoreDataHandler.getAllGeners() {
                        print("\(genr.id ?? 0) - \(genr.name ?? "unkonw")")
                    }
                }
                // Save
                DataLocal.shared.geners = geners.genres!
                self.getPopularMovies()
            }
        }) { (error) in
            self.isErrorData.accept(error)
        }
    }
    
    
    func getPopularMovies() {
        if !Connectivity.isConnectedToInternet() {
            DataLocal.shared.moviePopular = CoreDataHandler.getAllMovalid(by: Category.popular)
            self.isSuccessData.accept(true)
        }else{
            requestPopularMovies()
        }
    }
    
    func requestPopularMovies(){
        self.isLoading.accept(true)
        WebServiceManager().getPopularMovies(page: 1, onCompletion: {
            (filmsPopular) in
            for filmSng in filmsPopular.results! {
                CoreDataHandler.deleteMovalid(by: Category.popular)
                CoreDataHandler.saveFilm(singleFilm: filmSng, category: Category.popular)
                for film in CoreDataHandler.getAllMovalid(by: Category.popular) {
                    print("\(film.id ?? 0) - \(film.title ?? "unkonw")")
                }
            }
            // Save
            DataLocal.shared.moviePopular = filmsPopular.results!
            self.isSuccessData.accept(true)
        }) { (error) in
            self.isErrorData.accept(error )
        }
    }
}
