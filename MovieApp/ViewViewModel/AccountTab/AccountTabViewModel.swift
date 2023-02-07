//
//  AccountTabViewModel.swift
//  MovieApp
//
//  Created by BURAK AKAR on 16.12.2022.
//

import Foundation
import FirebaseAuth

class AccountView {
    
    let user = Auth.auth().currentUser
    
    // ResetPassword 
    func resetPressed() {
        
        Auth.auth().sendPasswordReset(withEmail: self.user?.email ?? "") { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Email sent")}
        }
    }
    
    // DeleteUser
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
    
    // SignOut
    func signOut(completion: (_ success: Bool) -> Void) {
        
        do {
            try Auth.auth().signOut()
            
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        completion(true)
    }
}

