//
//  RegisterViewController.swift
//  MovieApp
//
//  Created by BURAK AKAR on 4.09.2022.
//

import UIKit
import Firebase
import Foundation


class RegisterViewController: UIViewController {
    
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var confirmPasstext: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    let validation = String()
    let user = AuthViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        
        if let email = emailText.text , let password = passwordText.text , let name = nameText.text , let confirmPassword = confirmPasstext.text, let displayName = nameText.text {
            
            if email == "" || password == "" || name == "" || confirmPassword == "" {
                errorLabel.text = "Please fill all information"
            } else if email != "" && password != "" && name != "" && confirmPassword != "" && !validation.isValidEmail(email) {
                
                errorLabel.text = "Please enter a valid email"
            } else if email != "" && password != "" && name != "" && confirmPassword != "" && !validation.isValidPassword(password) {
                errorLabel.text = " Password must be minimum 8 characters" }
            else if email != "" && password != "" && name != "" && confirmPassword != "" && password != confirmPassword { errorLabel.text = "Passwords are mismatch"} else {
                
                
                // Register ViewModel here
                user.signUp(email: emailText.text ?? "", password: passwordText.text ?? "", errorLabel: errorLabel) { (success) -> Void in
                    if success {
                        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                        changeRequest?.displayName = displayName
                        changeRequest?.commitChanges { error in
                            self.performSegue(withIdentifier: "RegisterSegue", sender: self)
                        }
                        
                    } else {
                        
                    }
                }
            }
        }
    }
}

