//
//  EditProfilePassengerTableViewController.swift
//  RYDE
//
//  Created by iOSdev on 13/12/2022.
//

import UIKit
import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import Firebase


class EditProfilePassengerTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var users: Users?
    var userType = String()
    
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateProfile()
    }
    override func viewDidAppear(_ animated: Bool) {
        populateProfile()
    }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let destination = segue.destination as? ProfileViewController
            let ref = Database.database(url: "https://ryde-33483-default-rtdb.europe-west1.firebasedatabase.app").reference()
            destination?.fullName.text = firstNameField.text
            destination?.fullName.text = lastNameField.text

            let uid = Auth.auth().currentUser?.uid
       
            print(uid!)
            
            if !firstNameField.text!.isEmpty && !phoneNumberField.text!.isEmpty && !passwordField.text!.isEmpty && !lastNameField.text!.isEmpty {
                print("working")
                ref.child("users").child(userType).child(uid!).updateChildValues(["First Name": self.firstNameField.text!, "Last Name": self.lastNameField.text! , "Phone Number": self.phoneNumberField.text! , "Password": self.passwordField.text! ])
            }
            
       
        }
    
    func populateProfile() {
        
        let ref = Database.database(url: "https://ryde-33483-default-rtdb.europe-west1.firebasedatabase.app/").reference()
        let uid = Auth.auth().currentUser?.uid

        guard uid != nil else {
            print("Error Fetching User ID")
            return
        }

        ref.child("users").observeSingleEvent(of: .value, with: { snapshot in if let result = snapshot.children.allObjects as? [DataSnapshot] {
                        
            for child in result.enumerated() {
                
                if child.element.hasChild(uid!) {
                    
                    self.userType = child.element.key
                    
                    let value = child.element.childSnapshot(forPath: uid!).value as? NSDictionary
                    
                    self.firstNameField.text = value?["First Name"] as? String
                    self.lastNameField.text = value? ["Last Name"] as? String
                    self.phoneNumberField.text = value? ["Phone Number"] as? String
                    self.passwordField.text = value? ["Password"] as? String
                    
                    
                }
            }
        }
            
        })
    }
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


