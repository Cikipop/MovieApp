//
//  NetworkHelper.swift
//  MovieApp
//
//  Created by BURAK AKAR on 23.03.2023.
//

import Foundation

enum HTTPMethods: String {
    case get = "GET"
    case post = "Post"
}

enum ErrorTypes: String, Error {
    case invalidData = "Invalid data"
    case invalidUrl = "Invalid url"
    case generalError = "An error occured"
}

class NetworkHelper {
    
    static let shared = NetworkHelper()
    
    let baseURL = "https://api.themoviedb.org/3/movie/"
    let apiKey = "?api_key=219aa94d2495086f565841d1aeb06b66"
    let baseSearchUrl = "https://api.themoviedb.org/3/search/movie"
    
    
//   let nowplayingMoviesUrl = "\(baseURL)now_playing\(apiKey)"
//    let upcomingMoviesUrl = "\(baseURL)upcoming\(apiKey)"
//    let topRatedMoviesUrl = "\(baseURL)top_rated\(apiKey)"
    
}
