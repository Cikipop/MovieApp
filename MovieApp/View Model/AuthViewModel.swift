//
//  AuthViewModel.swift
//  MovieApp
//
//  Created by BURAK AKAR on 10.11.2022.
//

import Foundation
import FirebaseAuth
import UIKit


struct AuthViewModel {
    
    let user = Auth.auth().currentUser
    
    // Register ViewModel
    func signUp(email: String, password: String, errorLabel: UILabel, completion:@escaping (Bool) -> ()) {
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let e = error {
                errorLabel.text = e.localizedDescription }
            else { completion(true) }
        }
    }
    
    // Login ViewModel
    func signIn(email: String, password: String, errorLabel: UILabel, completion:@escaping (Bool) -> ()) {
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let e = error {
                errorLabel.text = e.localizedDescription }
            else { completion(true) }
        }
    }
    
    // ResetPassword ViewModel
    func resetPressed() {
        
        Auth.auth().sendPasswordReset(withEmail: self.user?.email ?? "") { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Email sent")}
        }
    }
    
    // DeleteUser ViewModel
    func deletePressed(completion:@escaping (Bool) -> ()) {
        
        self.user?.delete { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                
                print("Account deleted")
                completion(true)
            }
        }
    }
    
    // SignOut ViewModel
    func signOut(completion: (_ success: Bool) -> Void) {
        
        do {
            try Auth.auth().signOut()
            
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        completion(true)
    }
}
