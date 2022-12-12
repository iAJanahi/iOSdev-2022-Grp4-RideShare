//
//  LoginViewController.swift
//  RYDE
//
//  Created by iOSdev on 04/12/2022.
//

import UIKit
import FirebaseAuth
import SwiftUI

class LoginViewController: UIViewController {
    @State var invalidAttempts = 0
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    

 
        
    @IBAction func loginButton(_ sender: UIButton) {
        guard let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty else {
            
            print("Missing Field data")
            let alert = UIAlertController(title: "Missing field data", message: "please fill in the required fields", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            
            self.present(alert, animated: true)
            
            return
            
        }
//        if passwordField.text?.isEmpty == false || password != passwordField {
//            performSegue(withIdentifier: "Profile", sender: sender)
//        } else {
//            let rightTransform = CGAffineTransform(translationX: 40, y: 65)
//            self.passwordField.transform = rightTransform
//            UIView.animate(withDuration: 5, animations: {
//                self.emailField.transform = CGAffineTransform.identity
//            })
//        }
        
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: {[weak self] result, error in guard let self = self else {return}
            guard error == nil else {
                print("Invalid Credentials!")
                let alert = UIAlertController(title: "Invalid Credentials",message: "Invalid Credentials, please try again!",preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                self.present(alert, animated: true)
                return
            }
            print("Current user \(Auth.auth().currentUser)")
            UserDefaults.standard.set(Auth.auth().currentUser?.uid, forKey: "user_uid_key")
    
            self.performSegue(withIdentifier: "Home", sender: sender)
            
        })
    }
    

        
        // Do any additional setup after loading the view.

    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
