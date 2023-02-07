//
//  DetailScreenViewModel.swift
//  MovieApp
//
//  Created by BURAK AKAR on 16.12.2022.
//

import Foundation

class MovieDetailScreen {
    
    func ParseMovieDetail(api: String, comp : @escaping (MovieDetails)->()) {
        guard let url = URL(string: api) else { return }
        
        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                print("something went wrong")
                return
            }
            
            do {
                let result = try JSONDecoder().decode(MovieDetails.self, from: data)
                comp(result.self)
            } catch {
                print(String(describing: error))
            }
        }).resume()
    }
    
    func ParseMovies(api: String, comp : @escaping ([AllMovies])->()) {
        
        guard let url = URL(string: api) else { return }
        
        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                print("something went wrong")
                return
            }
            
            do {
                let result = try JSONDecoder().decode(Movie.self, from: data)
                comp(result.results)
            } catch {
                print(String(describing: error))
            }
        }).resume()
    }
    
    func ParseCreditsDetail(api: String, comp : @escaping ([AllCast])->()) {
        guard let url = URL(string: api) else { return }
        
        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                print("something went wrong")
                return
            }
            
            do {
                let result = try JSONDecoder().decode(Character.self, from: data)
                comp(result.cast)
            } catch {
                print(String(describing: error))
            }
        }).resume()
    }
}
