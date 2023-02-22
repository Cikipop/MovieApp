//
//  LoginViewController.swift
//  MovieApp
//
//  Created by BURAK AKAR on 4.09.2022.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    private let authViewModel = AuthViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        guard let email = emailText.text,
              let password = passwordText.text else { return }
        
        authViewModel.signIn(
            email: email,
            password: password
        ) { [weak self] success, error in
            if success {
                self?.performSegue(withIdentifier: "LoginSegue", sender: self)
            } else if let error = error {
                self?.showAlertDialog(with: error)
            }
        }
    }
}

