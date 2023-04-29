//
//  HomeScreenManager.swift
//  MovieApp
//
//  Created by BURAK AKAR on 23.03.2023.
//

import Foundation

class HomeScreenManager {
    
    static let shared = HomeScreenManager()
    
    func getNowPlayingMovies(complete: @escaping((Movie?, String?)->())) {
        let url = "\(NetworkHelper.shared.baseURL)now_playing\(NetworkHelper.shared.apiKey)"
        print(url)
        
        NetworkManager.shared.request(type: Movie.self, url: url, method: .get) { response in
            
            switch response {
                
            case .success(let items):
                complete(items, nil)
            case .failure(let error):
                complete(nil, error.rawValue)
            }
        }
    }
    
    func getTopRatedMovies(complete: @escaping((Movie?, String?)->())) {
        let url = "\(NetworkHelper.shared.baseURL)top_rated\(NetworkHelper.shared.apiKey)"
        
        NetworkManager.shared.request(type: Movie.self, url: url, method: .get) { response in
            
            switch response {
                
            case .success(let items):
                complete(items, nil)
            case .failure(let error):
                complete(nil, error.rawValue)
            }
        }
    }
    
    func getUpcomingMovies(complete: @escaping((Movie?, String?)->())) {
        let url = "\(NetworkHelper.shared.baseURL)upcoming\(NetworkHelper.shared.apiKey)"
        
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
