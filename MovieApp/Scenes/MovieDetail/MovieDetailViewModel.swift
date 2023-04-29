//
//  MovieDetailViewModel.swift
//  MovieApp
//
//  Created by cansin on 25.11.2022.
//

import Foundation

public final class MovieDetailViewModel {
    
   
    static let shared = MovieDetailViewModel()
    var detailedMovieInfo = MovieDetails()
    var similarMovies = [AllMovies]()
    var credits = [AllCast]()
   
//    var movieIdaa = Int()
    
    public var movieId = Int()
//
//        public init(movieId: Int) {
//            self.movieId = movieId
//
//        }

   
    
    
    func getMovieDetails(complete: @escaping((String?)->())) {
        
        MovieDetailScreeManager.shared.getMovieDetails(movieId: movieId ) { items, errorMessage in
            print("hellooooo \(self.movieId)")
            if let items = items {
                self.detailedMovieInfo = items
               
            }
            complete(errorMessage)
        }
    }
    
    func getMovieCast(complete: @escaping((String?)->())) {
        
        MovieDetailScreeManager.shared.getMovieCast(movieId: movieId ) { items, errorMessage in
            
            if let items = items {
                self.credits = items.cast ?? []
            }
            complete(errorMessage)
         
        }
    }
    
    func getSimilarMovies(complete: @escaping((String?)->())) {
        
        MovieDetailScreeManager.shared.getSimilarMovies(movieId: movieId ) { items, errorMessage in
            
            if let items = items {
                self.similarMovies = items.results ?? []
            }
            complete(errorMessage)
        }
       
    }
    
}
    


//extension MovieDetailViewModel: MovieIdDelegate {
//    func passMovieId(id: Int) {
//        movieId = id
//    }
    
    
    
    

    


    


