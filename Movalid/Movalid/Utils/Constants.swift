//
//  Constants.swift
//  Movalid
//
//  Created by Carlos Parada on 6/21/19.
//  Copyright © 2019 Carlos Parada. All rights reserved.
//

import Foundation


struct WebService {
    let configu = Configuration.shared
    
    static let urlBase    = "https://api.themoviedb.org/3"//3
    static let urlImage    = "https://image.tmdb.org/t/p/w600_and_h900_bestv2/"
    /*
     https:2//image.tmdb.org/t/p/w600_and_h900_bestv2/3iYQTLGoy7QnjcUYRJy4YrAgGvp.jpg
     */
}
class EndPoint {
    func geners(by typeString:String) -> String {
       return "/genre/"+typeString+"/list?"
    }
    /*
     https:2//api.themoviedb.org/3/genre/movie/list?api_key=898f39b7b0f0d6bd7acaf0f39472b264&language=es-CO
     */
    func movieSearch(by typeString:String) -> String {
        return "/search/"+typeString+"?"
    }
    /*
     https:2//api.themoviedb.org/3/search/movie?api_key=898f39b7b0f0d6bd7acaf0f39472b264&language=es-CO&query=Iron
     */
    func movieDetail(by typeString:String) -> String {
        return "/"+typeString+"/"
    }
    /*
     https:3//api.themoviedb.org/3/movie/1726?api_key=898f39b7b0f0d6bd7acaf0f39472b264&language=en-US
     */
    func popular(by typeString:String) -> String {
        return "/"+typeString+"/popular?"
    }
    //https:2//api.themoviedb.org/3/movie/popular?api_key=898f39b7b0f0d6bd7acaf0f39472b264&language=en-US&page=1
    
    func video(by typeString:String) -> String {
        return "/"+typeString+"/videos?"
    }
    //https://api.themoviedb.org/3/movie/320288/videos?api_key=898f39b7b0f0d6bd7acaf0f39472b264&language=en-US
    
    func topRated(by typeString:String) -> String {
        return "/"+typeString+"/top_rated?"
    }
    /*
     https:2//api.themoviedb.org/3/movie/top_rated?api_key=898f39b7b0f0d6bd7acaf0f39472b264&language=en-US&page=1
     */
    func upcoming(by typeString:String) -> String {
        return "/"+typeString+"/upcoming?"
    }
    /*
     https:2//api.themoviedb.org/3/movie/upcoming?api_key=898f39b7b0f0d6bd7acaf0f39472b264&language=en-US&page=1
     */
    
}

class Variable {
     let apiKey = "api_key="
     let lenguage = "&language="
     let page = "&page="
     let query = "&query="
    
    func typeR() -> String {
         let  type = Configuration.shared
        return type.type ?? Content.movie
    }
}

struct Lenguage {
    static let eng = "en-US"
    static let spa = "es-CO"
}

struct Content {
    static let movie = "movie"
    static let tv = "tv"
}
struct IntContent {
    static let movie = 0
    static let tv = 1
}

struct Category {
    static let topRated = "topRated"
    static let upcoming = "upcoming"
    static let popular = "popular"
}

struct IntCategory {
    static let topRated = 1
    static let upcoming = 2
    static let popular = 0
}

struct ErrorConnection {
    static let none   = 0
    static let requestTimeOut   = -1001
    static let localNoInternet  = -1005
    static let noInternet       = -1009
    static let requestError     = -1011
    static let connectionAbort     = 53
    
}

struct ProjectKeys {
    static let token    = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4OThmMzliN2IwZjBkNmJkN2FjYWYwZjM5NDcyYjI2NCIsInN1YiI6IjVkMGQ2ZTE2MGUwYTI2M2RkZGNkNWExNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.EQC3Lq1UlQV6oUbGDhxducTP-E1IqQKjMc1rSbeAC1Y"
    static let apiKey    = "898f39b7b0f0d6bd7acaf0f39472b264"
    
}

struct MovalidSParams {
    static let errorGeneric             = "errorGeneric"
}


