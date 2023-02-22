//
//  MovieDetailViewModel.swift
//  MovieApp
//
//  Created by cansin on 25.11.2022.
//

import Foundation

public final class MovieDetailViewModel {
    
    public var movieId: Int
    
    public init(movieId: Int) {
        self.movieId = movieId
    }
    
    public func getMovieDetail(completion: @escaping (MovieDetails?) -> Void) {
        let urlString = "\(Constants.baseUrl)\(movieId)\(Constants.apiKey)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(
            with: url,
            completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                print("something went wrong")
                return
            }
            
            do {
                let result = try JSONDecoder().decode(MovieDetails.self, from: data)
                completion(result.self)
            } catch {
                print(String(describing: error))
                completion(nil)
            }
        }).resume()
    }
    
    public func getCredits(completion: @escaping ([AllCast]?) -> Void) {
        let urlString = "\(Constants.baseUrl)\(movieId)/credits\(Constants.apiKey)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                print("something went wrong")
                return
            }
            
            do {
                let result = try JSONDecoder().decode(Character.self, from: data)
                completion(result.cast)
            } catch {
                print(String(describing: error))
                completion(nil)
            }
        }).resume()
    }
    
    public func getSimilarMovies(completion: @escaping ([AllMovies]?) -> Void) {
        let urlString = "\(Constants.baseUrl)\(movieId)/similar\(Constants.apiKey)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
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
