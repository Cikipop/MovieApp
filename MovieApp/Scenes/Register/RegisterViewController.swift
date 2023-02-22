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
    
    private let authViewModel = AuthViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func isValid(_ textfield: UITextField) -> Bool {
        guard let text = textfield.text else {
            showAlertDialog(with: "Please fill required fields")
            return false
        }
        
        if textfield == emailText {
            guard text.isValidEmail() else {
                showAlertDialog(with: "Please enter a valid email")
                return false
            }
        } else if textfield == passwordText {
            guard text.isValidPassword() else {
                showAlertDialog(with: "Your password must be at least 8 digits")
                return false
            }
        }
        return true
    }
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        
        guard isValid(emailText),
                isValid(passwordText),
              let email = emailText.text,
              let pass = passwordText.text,
              let confirm = confirmPasstext.text,
              pass == confirm else {
            showAlertDialog(with: "jahjkdh")
            return
        }
        
        authViewModel.signUp(
            email: email,
            password: pass
        ) { [weak self] success, error in
            if success {
                guard let user = self?.authViewModel.user else { return }
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.displayName = self?.nameText.text ?? ""
                changeRequest.commitChanges { error in
                    self?.performSegue(withIdentifier: "RegisterSegue", sender: self)
                }
            } else {
                self?.showAlertDialog(with: "An error has occured, please try again.")
            }
        }
    }
}
