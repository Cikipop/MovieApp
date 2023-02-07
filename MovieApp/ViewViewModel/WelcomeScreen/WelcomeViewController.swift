//
//  ViewController.swift
//  MovieApp
//
//  Created by BURAK AKAR on 4.09.2022.
//

import UIKit
import Firebase
import Kingfisher

class WelcomeViewController: UIViewController {
    
 let user = WelcomeScreen()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        user.userAlreadyLoggedIn() { [weak self] (success) -> Void in
            if success {
                self?.performSegue(withIdentifier: "LoggedIn", sender: self)
            } else {
                print("do nothing")
            }
        }
    }
    
    deinit {
        print("welcome screen released")
    }
    
}









