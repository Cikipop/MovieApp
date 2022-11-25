//
//  Constants.swift
//  MovieApp
//
//  Created by BURAK AKAR on 29.09.2022.
//

import Foundation


struct Constants {

static let baseUrl = "https://api.themoviedb.org/3/movie/"
static let apiKey = "?api_key=219aa94d2495086f565841d1aeb06b66"
static let nowplayingMoviesUrl = "\(baseUrl)now_playing\(apiKey)"
static let upcomingMoviesUrl = "\(baseUrl)upcoming\(apiKey)"
static let topRatedMoviesUrl = "\(baseUrl)top_rated\(apiKey)"
static let baseSearchUrl = "https://api.themoviedb.org/3/search/movie"

}

