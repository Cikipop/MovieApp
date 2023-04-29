//
//  MoviesTabViewModel.swift
//  MovieApp
//
//  Created by cansin on 29.11.2022.
//

import Foundation

public final class MoviesTabViewModel {
    
    public var upcomingMovies = [AllMovies]()
    public var nowPlayingMovies = [AllMovies]()
    public var topRatedMovies = [AllMovies]()
    

    
    func getNowPlayingMovies(complete: @escaping((String?)->())) {
        
        HomeScreenManager.shared.getNowPlayingMovies { items, errorMessage in
            
            if let items = items {
                self.nowPlayingMovies = items.results ?? []
            }
            complete(errorMessage)
        }
    }
    
    func getTopRatedMovies(complete: @escaping((String?)->())) {
        
        HomeScreenManager.shared.getTopRatedMovies { items, errorMessage in
            
            if let items = items {
                self.topRatedMovies = items.results ?? []
            }
            complete(errorMessage)
        }
    }
    
    func getUpcomingMovies(complete: @escaping((String?)->())) {
        
        HomeScreenManager.shared.getUpcomingMovies { items, errorMessage in
            
            if let items = items {
                self.upcomingMovies = items.results ?? []
            }
            complete(errorMessage)
        }
    }
    
    
//    public func fetchMovies(with endpoint: String, completion: @escaping ([AllMovies]?) -> Void) {
//        guard let url = URL(string: endpoint) else { return }
//
//        URLSession.shared.dataTask(
//            with: url,
//            completionHandler: { data, response, error in
//            guard let data = data, error == nil else {
//                print("something went wrong")
//                return
//            }
//
//            do {
//                let result = try JSONDecoder().decode(Movie.self, from: data)
//                completion(result.results)
//            } catch {
//                print(String(describing: error))
//                completion(nil)
//            }
//        }).resume()
//    }
}
