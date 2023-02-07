//
//  LoginViewController.swift
//  MovieApp
//
//  Created by BURAK AKAR on 4.09.2022.
//

import UIKit
import Firebase


class LoginViewController: UIViewController {
    
     let user = LoginModel()
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        
        user.signIn(email: emailText.text ?? "", password: passwordText.text ?? "") {[weak self] (success, Error) -> Void in
            if success {
                self?.performSegue(withIdentifier: "LoginSegue", sender: self)
                
            } else {
                self?.presentAlert(message: Error?.localizedDescription ?? "")
                
            }
        }
    }
    
    deinit {
        print("login screen released")
    }
}


extension LoginViewController {
    
    func presentAlert(message : String) {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { action in
            print("You've pressed OK Button")
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

