//
//  MovieDataModel.swift
//  MovieApp
//
//  Created by BURAK AKAR on 1.10.2022.
//

import Foundation


struct Movie: Codable {
    var results: [AllMovies]
}

struct AllMovies: Codable {
    var original_title: String
    var overview: String
    var poster_path: String?
    var vote_average: Float
    var release_date: String
    var id: Int
}

struct MovieDetails: Codable {
    
    var status: String
    var runtime: Int
    var genres: [AllGenres]
    var original_title: String
    var overview: String
    var poster_path: String?
    var vote_average: Float
    var release_date: String
    var id: Int
    
}

struct AllGenres: Codable {
    var name: String
}
    
struct Character: Codable {
    var cast: [AllCast]
    }
    
struct AllCast: Codable {
        
    var name: String
    var character: String
    var profile_path: String?
    }
    




//struct MovieApiResponse {
//    let page: Int
//    let numberOfResults: Int
//    let numberOfPages: Int
//    let movies: [Movie]
//}
//
//extension MovieApiResponse: Decodable {
//
//    private enum MovieApiResponseCodingKeys: String, CodingKey {
//        case page
//        case numberOfResults = "total_results"
//        case numberOfPages = "total_pages"
//        case movies = "results"
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: MovieApiResponseCodingKeys.self)
//
//        page = try container.decode(Int.self, forKey: .page)
//        numberOfResults = try container.decode(Int.self, forKey: .numberOfResults)
//        numberOfPages = try container.decode(Int.self, forKey: .numberOfPages)
//        movies = try container.decode([Movie].self, forKey: .movies)
//
//    }
//}
//
//
//struct Movie {
//    let id: Int
//    let posterPath: String
//    let backdrop: String
//    let title: String
//    let releaseDate: String
//    let rating: Double
//    let overview: String
//}
//
//extension Movie: Decodable {
//
//    enum MovieCodingKeys: String, CodingKey {
//        case id
//        case posterPath = "poster_path"
//        case backdrop = "backdrop_path"
//        case title
//        case releaseDate = "release_date"
//        case rating = "vote_average"
//        case overview
//    }
//
//
//    init(from decoder: Decoder) throws {
//        let movieContainer = try decoder.container(keyedBy: MovieCodingKeys.self)
//
//        id = try movieContainer.decode(Int.self, forKey: .id)
//        posterPath = try movieContainer.decode(String.self, forKey: .posterPath)
//        backdrop = try movieContainer.decode(String.self, forKey: .backdrop)
//        title = try movieContainer.decode(String.self, forKey: .title)
//        releaseDate = try movieContainer.decode(String.self, forKey: .releaseDate)
//        rating = try movieContainer.decode(Double.self, forKey: .rating)
//        overview = try movieContainer.decode(String.self, forKey: .overview)
//    }
//}
