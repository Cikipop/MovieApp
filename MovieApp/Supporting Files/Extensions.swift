//
//  Extensions.swift
//  MovieApp
//
//  Created by BURAK AKAR on 2.11.2022.
//

import Foundation
import UIKit

extension String {
    func isValidEmail() -> Bool {
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        return emailPred.evaluate(with: self)
    }
    
    func isValidPassword() -> Bool {
        
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", "^(?=.*\\d).{8,16}$")
        return passwordTest.evaluate(with: self)
        
    }
    
}

extension UIViewController {
    public func showAlertDialog(with message: String) {
        let alert = UIAlertController(
            title: "OOPS!",
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(.init(title: "OK", style: .default))
        present(alert, animated: true)
    }
}


//    public var movieId: Int
//
//    public init(movieId: Int) {
//        self.movieId = movieId
//
//    }
//
