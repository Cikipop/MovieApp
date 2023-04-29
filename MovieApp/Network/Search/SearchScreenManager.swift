//
//  SearchScreenManager.swift
//  MovieApp
//
//  Created by BURAK AKAR on 5.04.2023.
//

import Foundation

class SearchManager {
    
    static let shared = SearchManager()
    
    func getSearchedMovies(complete: @escaping((Movie?, String?)->())) {
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
