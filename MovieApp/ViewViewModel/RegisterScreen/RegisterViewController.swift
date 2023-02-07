//
//  RegisterViewController.swift
//  MovieApp
//
//  Created by BURAK AKAR on 4.09.2022.
//

import UIKit
import FirebaseAuth
import Foundation


class RegisterViewController: UIViewController {
    
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var confirmPasstext: UITextField!
    let user = RegisterModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        
        if let email = emailText.text , let password = passwordText.text , let name = nameText.text , let confirmPassword = confirmPasstext.text {
            
            if email == "" || password == "" || name == "" || confirmPassword == "" {
                presentAlert(message: "Please fill all information")
            } else if email != "" && password != "" && name != "" && confirmPassword != "" && isValidEmail(email) == false {
                
                presentAlert(message: "Please enter a valid email")
            } else if email != "" && password != "" && name != "" && confirmPassword != "" && isValidPassword(password) == false {
                presentAlert(message:  " Password must be minimum 8 characters")
                
            }
            else if email != "" && password != "" && name != "" && confirmPassword != "" && password != confirmPassword
            { presentAlert(message: "Passwords are mismatch")
                
            }
            else {
                
                
                // Register ViewModel here
                user.signUp(email: emailText.text ?? "", password: passwordText.text ?? "") { [weak self] (success, Error) -> Void in
                    if success {
                        
                        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                        changeRequest?.displayName = name
                        changeRequest?.commitChanges {[weak self] (error) in
                            self?.performSegue(withIdentifier: "RegisterSegue", sender: self)
                        }
                        
                    } else {
                        self?.presentAlert(message: Error?.localizedDescription ?? "")
                        
                    }
                }
            }
        }
    }
    
    deinit {
        print("register screen released")
    }
}


extension RegisterViewController {
    
    func presentAlert(message : String) {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { action in
            print("You've pressed OK Button")
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        return emailPred.evaluate(with: email)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", "^(?=.*\\d).{8,16}$")
        return passwordTest.evaluate(with: password)
        
    }
}

