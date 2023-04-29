//
//  MovieDetailScreenManager.swift
//  MovieApp
//
//  Created by BURAK AKAR on 7.04.2023.
//

import Foundation

class MovieDetailScreeManager {
    
    
   
    
//
     static let shared = MovieDetailScreeManager()

   
    
    func getMovieDetails(movieId: Int, complete: @escaping((MovieDetails?, String?)->())) {
        
       
        let url = "\(NetworkHelper.shared.baseURL)\(movieId)\(NetworkHelper.shared.apiKey)"
      
       
    
        
        
        NetworkManager.shared.request(type: MovieDetails.self, url: url, method: .get) { response in
            
            switch response {
                
            case .success(let items):
                complete(items, nil)
            case .failure(let error):
                complete(nil, error.rawValue)
            }
        }
    }
    
    func getMovieCast(movieId: Int,complete: @escaping((Character?, String?)->())) {
        let url = "\(NetworkHelper.shared.baseURL)\(movieId)\("/credits")\(NetworkHelper.shared.apiKey)"
      
        
        NetworkManager.shared.request(type: Character.self, url: url, method: .get) { response in
            
            switch response {
                
            case .success(let items):
                complete(items, nil)
            case .failure(let error):
                complete(nil, error.rawValue)
            }
        }
    }
    func getSimilarMovies(movieId: Int,complete: @escaping((Movie?, String?)->())) {
        let url = "\(NetworkHelper.shared.baseURL)\(movieId)\("/similar")\(NetworkHelper.shared.apiKey)"
        
     
        
        NetworkManager.shared.request(type: Movie.self, url: url, method: .get) { response in
            
            switch response {
                
            case .success(let items):
                complete(items, nil)
            case .failure(let error):
                complete(nil, error.rawValue)
            }
        }
    }
}
