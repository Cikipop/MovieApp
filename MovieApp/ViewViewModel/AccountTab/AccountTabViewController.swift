//
//  AccountTabViewController.swift
//  MovieApp
//
//  Created by BURAK AKAR on 14.09.2022.
//

import Foundation
import UIKit
import Firebase


class AccountTabViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    let user = AccountView()
    let currentUser = Auth.auth().currentUser
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userInfo()
    }
    
    func userInfo() {
        
        nameLabel.text = currentUser?.displayName?.capitalized
        mailLabel.text = currentUser?.email
        dateLabel.text = currentUser?.metadata.creationDate?.formatted(date: .long, time: .omitted)
    }
    
    //MARK: - LogOut User 
    
    @IBAction func logOutPressed(_ sender: UIButton) {
        
        user.signOut { (success) -> Void in
            if success {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }

    //MARK: - Reset Password
    @IBAction func resetPressed(_ sender: UIButton) {
        
        let actionSheet = UIAlertController(title: "Reset Password?", message: "You will receive an email to reset your password", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Reset", style: .destructive, handler: {
            action in self.user.resetPressed()
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            print("action cancelled")
            
        }))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    //MARK: - Delete Account
    @IBAction func deletePressed(_ sender: UIButton) {
        
        let actionSheet = UIAlertController(title: "Delete Account?", message: "This action deletes your account permanently", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {
            action in
            
            self.user.deletePressed { (success) -> Void in
                if success {
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
        }
    ))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            print("action cancelled")
            
        }))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    deinit {
        print("account screen released")
    }
    
}


