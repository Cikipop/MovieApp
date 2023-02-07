//
//  RegisterScreenViewModel.swift
//  MovieApp
//
//  Created by BURAK AKAR on 16.12.2022.
//

import Foundation
import FirebaseAuth

class RegisterModel {
    
    func signUp(email: String, password: String, completion:@escaping (Bool, Error?) -> ()) {
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                
                completion(false, error)
                
            } else { completion(true, nil) }
        }
    }
}

