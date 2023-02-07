//
//  File.swift
//  MovieApp
//
//  Created by BURAK AKAR on 16.12.2022.
//

import Foundation
import FirebaseAuth


class LoginModel {
    
    func signIn(email: String, password: String, completion:@escaping (Bool, Error?) -> ()) {
        
        Auth.auth().signIn(withEmail: email, password: password) {result, error in
           
            if let error = error {
                
                completion(false, error)
                
            } else { completion(true, nil) }
        }
    }
}
