//
//  MoviesTabViewModel.swift
//  MovieApp
//
//  Created by cansin on 29.11.2022.
//

import Foundation

public final class MoviesTabViewModel {
    var movieId: Int?
    public init(id: Int? = nil) {
        self.movieId = id
    }
    
    public func fetchMovies(with endpoint: String, completion: @escaping ([AllMovies]?) -> Void) {
        guard let url = URL(string: endpoint) else { return }
        
        URLSession.shared.dataTask(
            with: url,
            completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                print("something went wrong")
                return
            }
            
            do {
                let result = try JSONDecoder().decode(Movie.self, from: data)
                completion(result.results)
            } catch {
                print(String(describing: error))
                completion(nil)
            }
        }).resume()
    }
}
