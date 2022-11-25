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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Auth.auth().currentUser != nil {
            performSegue(withIdentifier: "LoggedIn", sender: self)
        }
    }
}









