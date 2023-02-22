//
//  SearchViewModel.swift
//  MovieApp
//
//  Created by cansin on 2.12.2022.
//

import Foundation

public final class SearchViewModel {
    
    public var isSearched: Bool = false
    public var upcomingMovies = [AllMovies]()
    public var searchedMovies = [AllMovies]()
    
    public init() { }
    
    public func fetchMovies(
        with searchText: String? = nil,
        completion: (([AllMovies]?) -> Void)? = nil
    ) {
        if let searchText = searchText {
            isSearched = true
            let url = "\(Constants.baseSearchUrl)\(Constants.apiKey)&language=en-US&query=\(searchText)&page=1&include_adult=false"
            let formattedUrlString = url.replacingOccurrences(of: " ", with: "%20")
            
            guard let finalUrl = URL(string: formattedUrlString) else { return }
            
            URLSession.shared.dataTask(
                with: finalUrl,
                completionHandler: { [weak self] data, response, error in
                guard let data = data, error == nil else {
                    print("something went wrong")
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(Movie.self, from: data)
                    self?.searchedMovies = result.results ?? []
                    completion?(result.results)
                } catch {
                    print(String(describing: error))
                    completion?(nil)
                }
            }).resume()
        } else {
            isSearched = false
            guard let url = URL(string: Constants.upcomingMoviesUrl) else { return }
            
            URLSession.shared.dataTask(
                with: url,
                completionHandler: { [weak self] data, response, error in
                guard let data = data, error == nil else {
                    print("something went wrong")
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(Movie.self, from: data)
                    self?.upcomingMovies = result.results ?? []
                    completion?(result.results)
                } catch {
                    print(String(describing: error))
                    completion?(nil)
                }
            }).resume()
        }
        
    }
}
