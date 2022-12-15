//
//  ProfileViewController.swift
//  RYDE
//
//  Created by iOSdev on 04/12/2022.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ProfileViewController: UIViewController {

    
    
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
    
    var userType = ["Drivers", "Passengers"]
    
    
    @IBAction func signoutButton(_ sender: UIButton) {
        do {
            try FirebaseAuth.Auth.auth().signOut()
            UserDefaults.standard.removeObject(forKey: "user_uid_key")
            
            self.navigationController?.popToRootViewController(animated: true)
//            self.performSegue(withIdentifier: "goToLogin", sender: nil)
        } catch {
            print("Error Signing out")
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateLabels()
        self.navigationItem.setHidesBackButton(true, animated: true)

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        populateLabels()
    }
    
    func populateLabels() {
        let ref = Database.database(url: "https://ryde-33483-default-rtdb.europe-west1.firebasedatabase.app/").reference()
        let uid = Auth.auth().currentUser?.uid
        
        guard uid != nil else {
            print("Error Fetching User ID")
            return
        }
        
        print(uid!)
        ref.child("users").observeSingleEvent(of: .value, with: { snapshot in if let result = snapshot.children.allObjects as? [DataSnapshot] {
                        
            for child in result.enumerated() {
                
                if child.element.hasChild(uid!) {
                    
                    let value = child.element.childSnapshot(forPath: uid!).value as? NSDictionary
                    
                    let fName = value?["First Name"] as? String
                    let lName = value?["Last Name"] as? String
                    let fullName = "\(fName!) \(lName!)"
                    self.fullName.text = fullName
                    self.emailLabel.text = value? ["Email"] as? String
                    
                    
                }
            }
        }
            
        })
            
    }
    
 
    @IBAction func unwindToProfileDriver(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind", let sourceViewController = segue.source as? EditProfileTableViewController else {return}
        
        fullName.text = sourceViewController.nameField.text
    
    }
    
    @IBAction func unwindToProfilePass(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind", let sourceViewController = segue.source as? EditProfileTableViewController else {return}
        
        fullName.text = sourceViewController.nameField.text
    
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
