//
//  Constants.swift
//  Movalid
//
//  Created by Carlos Parada on 6/21/19.
//  Copyright © 2019 Carlos Parada. All rights reserved.
//

import Foundation

struct WebService {
    static let urlBase    = "https://api.themoviedb.org/3"
    static let urlImage    = "https://image.tmdb.org/t/p/w600_and_h900_bestv2"
    /*
     https:2//image.tmdb.org/t/p/w600_and_h900_bestv2/3iYQTLGoy7QnjcUYRJy4YrAgGvp.jpg
     */
}
struct EndPoint {
    static let geners = "/genre/"+Variable.type+"/list?"
    /*
     https:2//api.themoviedb.org/3/genre/movie/list?api_key=898f39b7b0f0d6bd7acaf0f39472b264&language=es-CO
     */
    
    static let movieSearch = "/search/"+Variable.type+"?"
    /*
     https:2//api.themoviedb.org/3/search/movie?api_key=898f39b7b0f0d6bd7acaf0f39472b264&language=es-CO&query=Iron
     */
    
    static let movieDetail = "/"+Variable.type+"/"
    /*
     https:3//api.themoviedb.org/3/movie/1726?api_key=898f39b7b0f0d6bd7acaf0f39472b264&language=en-US
     */
    
    static let popular = "/"+Variable.type+"/popular?"
    /*
     https:2//api.themoviedb.org/3/movie/popular?api_key=898f39b7b0f0d6bd7acaf0f39472b264&language=en-US&page=1
     */
    
    static let topRated = "/"+Variable.type+"/top_rated?"
    /*
     https:2//api.themoviedb.org/3/movie/top_rated?api_key=898f39b7b0f0d6bd7acaf0f39472b264&language=en-US&page=1
     */
    
    static let upcoming = "/"+Variable.type+"/upcoming?"
    /*
     https:2//api.themoviedb.org/3/movie/upcoming?api_key=898f39b7b0f0d6bd7acaf0f39472b264&language=en-US&page=1
     */

}

struct Variable {
    static let type = Configuration.shared.type
    static let apiKey = "api_key="
    static let lenguage = "&language="
    static let page = "&page="
    static let query = "&query="
}

struct Lenguage {
    static let eng = "en-US"
    static let spa = "es-CO"
}

struct Category {
    static let topRated = "topRated"
    static let upcoming = "upcoming"
    static let popular = "popular"
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
