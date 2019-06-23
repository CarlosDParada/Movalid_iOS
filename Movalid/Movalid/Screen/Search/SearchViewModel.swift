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
    
    override init() {
        print("Loading View Model")
        CommunicationManager.shared.initialization()
    }
    func getSearchMovies(by category:String, key: String) {
        if !Connectivity.isConnectedToInternet() {
            DataLocal.shared.search =
                CoreDataHandler.getAllMovalid(by: category, string: key)
            if(DataLocal.shared.moviePopular!.count > 0){
                self.isSuccessData.accept(DataLocal.shared.search!)
            }else{
                self.isErrorData.accept(ErrorHandle.errorGeneric(by: NSLocalizedString("alert.no.internet", comment: "Check connection"), status: ErrorConnection.requestTimeOut))
            }
        }else{
            requestSearchMovies(by:category, key: key)
        }
    }
    
    func requestSearchMovies(by category:String, key: String){
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
