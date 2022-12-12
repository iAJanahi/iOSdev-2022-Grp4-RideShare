//
//  LoginViewController.swift
//  RYDE
//
//  Created by iOSdev on 04/12/2022.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
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
            print("Current user \(Auth.auth().currentUser?.uid)")
            //UserDefaults.standard.set(Auth.auth().currentUser?.uid, forKey: "user_uid_key")
            
            let uid = Auth.auth().currentUser?.uid
            let ref = Database.database(url: FBReference.databaseRef).reference()
            // Seperating the Drivers from the Passengers to different home pages based on ID
            ref.child("users").child("drivers").observeSingleEvent(of: .value) { (snapsphot) in
                if let value = snapsphot.value as? NSDictionary {
                    if value.contains(where: { $0.key as! String == uid }) {
                        print("This is a driver!")
                        self.performSegue(withIdentifier: "DriverHome", sender: sender)
                    }
                }
            }
            
            ref.child("users").child("passengers").observeSingleEvent(of: .value) { (snapsphot) in
                if let value = snapsphot.value as? NSDictionary {
                    if value.contains(where: { $0.key as! String == uid }) {
                        print("This is a passenger!")
                        self.performSegue(withIdentifier: "Home", sender: sender)
                    }
                }
            }
        })
    }
    
//    @IBAction func checkUserTest(_ sender: Any) {
//        var DorP = DriverOrPassenger(uid: "NUJt5pMhsvUZIkOlbwgWUTiArIo1")
//        print(DorP)
//        if DorP == "D" {
//            print("Go to Driver Page")
//        }
//        else if DorP == "P" {
//            print("Go to Passenger Page")
//        }
//        else {
//            print("User Not Found!")
//        }
//    }
    
//    func DriverOrPassenger(uid: String) -> String  {
//        // Seperating home pages based on user Type. Driver and passenger
//        let ref = Database.database(url: FBReference.databaseRef).reference()
//
//        ref.child("users").child("drivers").observeSingleEvent(of: .value) { (snapsphot) in
//            if let value = snapsphot.value as? NSDictionary {
//                if value.contains(where: { $0.key as! String == uid }) {
//                    print("This is a driver!")
//
//                    completion("D")
//                }
//            }
//        }
//
//        ref.child("users").child("passengers").observeSingleEvent(of: .value) { (snapsphot) in
//            if let value = snapsphot.value as? NSDictionary {
//                if value.contains(where: { $0.key as! String == uid }) {
//                    print("This is a passenger!")
//
//                    return "P"
//                }
//            }
//        }
//
//
//    }
    

        
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
