//
//  AuthViewModel.swift
//  MovieApp
//
//  Created by BURAK AKAR on 10.11.2022.
//

import Foundation
import FirebaseAuth
import UIKit


public final class AuthViewModel {
    
    public let user = Auth.auth().currentUser
    
    public init() { }
    
    // MARK: Register Method
    func signUp(
        email: String,
        password: String,
        completion: @escaping (_ success: Bool, _ error: String?) -> ()
    ) {
        Auth.auth().createUser(
            withEmail: email,
            password: password
        ) { result, error in
            if let error = error {
                completion(false, error.localizedDescription)
            } else {
                completion(true, nil)
            }
        }
    }
    
    // MARK: Login Method
    func signIn(
        email: String,
        password: String,
        completion: @escaping (_ success: Bool, _ error: String?) -> ()
    ) {
        
        Auth.auth().signIn(
            withEmail: email,
            password: password
        ) { authResult, error in
            if let error = error {
                completion(false, error.localizedDescription)
            } else {
                completion(true, nil)
            }
        }
    }
    
    // MARK: ResetPassword Method
    func resetPressed(
        completion: ((_ success: Bool, _ error: String?) -> ())? = nil
    ) {
        guard let user = user,
            let mail = user.email else { return }
        
        Auth.auth().sendPasswordReset(withEmail: mail) { error in
            if let error = error {
                completion?(false, error.localizedDescription)
            } else {
                completion?(true, nil)
            }
        }
    }
    
    // MARK: DeleteUser Method
    func deletePressed(
        completion: @escaping (_ success: Bool, _ error: String?) -> ()
    ) {
        guard let user = user else { return }
        user.delete { error in
            if let error = error {
                completion(false, error.localizedDescription)
            } else {
                completion(true, nil)
            }
        }
    }
    
    // MARK: SignOut Method
    func signOut(
        completion: @escaping (_ success: Bool, _ error: String?) -> ()
    ) {
        do {
            try Auth.auth().signOut()
            
        } catch let signOutError as NSError {
            completion(false, signOutError.localizedDescription)
        }
        completion(true, nil)
    }
}
