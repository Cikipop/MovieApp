//
//  LoginViewController.swift
//  MovieApp
//
//  Created by BURAK AKAR on 4.09.2022.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    
    
    let user = AuthViewModel()
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        
        
        
        user.signIn(email: emailText.text ?? "", password: passwordText.text ?? "", errorLabel: errorLabel) { (success) -> Void in
            if success {
                self.performSegue(withIdentifier: "LoginSegue", sender: self)
            } else {
                
            }
        }
    }
}

