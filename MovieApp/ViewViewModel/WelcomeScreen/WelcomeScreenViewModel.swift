//
//  WelcomeScreenViewModel.swift
//  MovieApp
//
//  Created by BURAK AKAR on 16.12.2022.
//

import Foundation
import FirebaseAuth

class WelcomeScreen {
    
    func userAlreadyLoggedIn(completion:@escaping (Bool) -> ()) {
        
        if Auth.auth().currentUser != nil {
            
            completion(true)
            
        } else { completion(false) }
    }
}


