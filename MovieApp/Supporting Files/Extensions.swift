//
//  Extensions.swift
//  MovieApp
//
//  Created by BURAK AKAR on 2.11.2022.
//

import Foundation


extension String {
    func isValidEmail(_ email: String) -> Bool {
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        return emailPred.evaluate(with: email)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", "^(?=.*\\d).{8,16}$")
        return passwordTest.evaluate(with: password)
        
    }
    
}




