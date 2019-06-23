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
        switch code {
        case IntContent.tv:
            Configuration.shared.type = Content.tv
            Configuration.shared.inType = IntContent.tv
            break
        default:
            Configuration.shared.type = Content.movie
            Configuration.shared.inType = IntContent.movie
        }
    }
    
    static func updateCategoryContent(by code:Int){
        switch code {
        case IntCategory.topRated:
            Configuration.shared.category = Category.topRated
            Configuration.shared.intCategory = IntCategory.topRated
            break
        case IntCategory.upcoming:
            Configuration.shared.category = Category.upcoming
            Configuration.shared.intCategory = IntCategory.upcoming
            break
        default:
            Configuration.shared.category = Category.popular
            Configuration.shared.intCategory = IntCategory.popular
        }
    }

    
    static func getContentBySituation () -> [Film]{
        
        switch Configuration.shared.type {
        case "tv":
            return getSerieSimple()
        default:
            return getMovieSimple()
        }
    }
    
    static func getSerieSimple() -> [Film] {
        switch Configuration.shared.intCategory{
        case 1:
            return DataLocal.shared.serieTop!
        case 2:
            return DataLocal.shared.serieUpcoming!
        default:
            return DataLocal.shared.seriePopular!
        }
    }
    
    static func getMovieSimple() -> [Film] {
        switch Configuration.shared.intCategory{
        case 1:
            return DataLocal.shared.movieTop!
        case 2:
            return DataLocal.shared.movieUpcoming!
        default:
            return DataLocal.shared.moviePopular!
        }
    }
    
    
     static func getContentBySituation (indexPath: IndexPath) -> Film{
        
        switch Configuration.shared.type {
        case "tv":
            return getSerieSimple(indexPath: indexPath)
        default:
            return getMovieSimple(indexPath: indexPath)
        }
    }
    
     static func getSerieSimple(indexPath : IndexPath) -> Film {
        switch  Configuration.shared.intCategory{
        case 1:
            return DataLocal.shared.serieTop![indexPath.row]
        case 2:
            return DataLocal.shared.serieUpcoming![indexPath.row]
        default:
            return DataLocal.shared.seriePopular![indexPath.row]
        }
    }
    
     static func getMovieSimple(indexPath : IndexPath) -> Film {
        switch  Configuration.shared.intCategory{
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
    
}
