//
//  HandleData.swift
//  Movalid
//
//  Created by Carlos Parada on 6/22/19.
//  Copyright © 2019 Carlos Parada. All rights reserved.
//

import Foundation

class HandlerData {
    static func updateTypeContent(by code:Int){
        let configu = Configuration.shared
        switch code {
        case IntContent.tv:
            configu.type = Content.tv
            configu.inType = IntContent.tv
            break
        default:
            configu.type = Content.movie
            configu.inType = IntContent.movie
        }
    }
    
    static func updateCategoryContent(by code:Int){
        let configu = Configuration.shared
        switch code {
        case IntCategory.topRated:
            configu.category = Category.topRated
            configu.intCategory = IntCategory.topRated
            break
        case IntCategory.upcoming:
            configu.category = Category.upcoming
            configu.intCategory = IntCategory.upcoming
            break
        default:
            configu.category = Category.popular
            configu.intCategory = IntCategory.popular
        }
    }
    
    
    static func getContentBySituation () -> [Film]{
        let configu = Configuration.shared
        
        switch configu.type {
        case "tv":
            return getSerieSimple()
        default:
            return getMovieSimple()
        }
    }
    
    static func getSerieSimple() -> [Film] {
        let configu = Configuration.shared
        switch configu.intCategory{
        case 1:
            return DataLocal.shared.serieTop!
        case 2:
            return DataLocal.shared.serieUpcoming!
        default:
            return DataLocal.shared.seriePopular!
        }
    }
    
    static func getMovieSimple() -> [Film] {
        let configu = Configuration.shared
        switch configu.intCategory{
        case 1:
            if(DataLocal.shared.movieTop!.count > 0){
                return DataLocal.shared.movieTop!
            }else{
                return[]
            }
        case 2:
            return DataLocal.shared.movieUpcoming!
        default:
            return DataLocal.shared.moviePopular!
        }
    }
    
    
    static func getContentBySituation (indexPath: IndexPath) -> Film{
        let configu = Configuration.shared
        
        switch configu.type {
        case "tv":
            return getSerieSimple(indexPath: indexPath)
        default:
            return getMovieSimple(indexPath: indexPath)
        }
    }
    
    static func getSerieSimple(indexPath : IndexPath) -> Film {
        let configu = Configuration.shared
        switch  configu.intCategory{
        case 1:
            return DataLocal.shared.serieTop![indexPath.row]
        case 2:
            return DataLocal.shared.serieUpcoming![indexPath.row]
        default:
            return DataLocal.shared.seriePopular![indexPath.row]
        }
    }
    
    static func getMovieSimple(indexPath : IndexPath) -> Film {
        let configu = Configuration.shared
        switch  configu.intCategory{
        case 1:
            return DataLocal.shared.movieTop![indexPath.row]
        case 2:
            return DataLocal.shared.movieUpcoming![indexPath.row]
        default:
            return DataLocal.shared.moviePopular![indexPath.row]
        }
    }
    
    static func getGenerById(by idGen: Int) -> String{
        let array = DataLocal.shared.geners
        if let gener = array!.first(where: {$0.id == idGen}) {
            return gener.name
        } else {
            return "Unkown"
        }
    }
    
    static func getTypeContentString(by key:Int) -> String{
        switch key {
        case IntContent.tv:
            return Content.tv
        default:
            return Content.movie
        }
    }
    
    static func getCategoryString(by key:Int) -> String{
        switch key {
        case IntCategory.topRated:
            return Category.topRated
        case IntCategory.upcoming:
            return Category.upcoming
        default:
            return Category.popular
        }
    }
    
}
