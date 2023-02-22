//
//  MovieDataModel.swift
//  MovieApp
//
//  Created by BURAK AKAR on 1.10.2022.
//

import Foundation

public struct Movie: Codable {
    var results: [AllMovies]?
}

public struct AllMovies: Codable {
    var original_title: String?
    var overview: String?
    var poster_path: String??
    var vote_average: Float?
    var release_date: String?
    var id: Int?
}

public struct MovieDetails: Codable {
    var status: String?
    var runtime: Int?
    var genres: [AllGenres]?
    var original_title: String?
    var overview: String?
    var poster_path: String?
    var vote_average: Float?
    var release_date: String?
    var id: Int?
}

public struct AllGenres: Codable {
    var name: String?
}
    
public struct Character: Codable {
    var cast: [AllCast]?
}
    
public struct AllCast: Codable {
    var name: String?
    var character: String?
    var profile_path: String?
}
    

