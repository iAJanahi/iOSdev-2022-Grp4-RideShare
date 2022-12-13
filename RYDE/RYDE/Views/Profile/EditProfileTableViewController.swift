//
//  EditProfileTableViewController.swift
//  RYDE
//
//  Created by iOSdev on 07/12/2022.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase


class EditProfileTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var users: Users?
    var userType = String()
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var editPhoneNum: UITextField!
    
    @IBOutlet var profilePicture: UIImageView!
    @IBOutlet weak var editPass: UITextField!
    
    
    private let storage = Storage.storage().reference()
    private let uid = Auth.auth().currentUser?.uid
    
    @IBAction func editProfileButton(_ sender: Any) {
     let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        guard let imageData = image.pngData() else { return }
        
        storage.child("images/\(uid!)_image").putData(imageData, metadata: nil, completion: { _, error in guard error == nil else {
            print("Failed to upload")
            return
        }
            self.storage.child("images/\(self.uid!)_image").downloadURL(completion: { url, error in guard let url = url, error == nil else {
                return
            }
                let urlString = url.absoluteString
                
                DispatchQueue.main.async {
                    self.profilePicture.image = image
                }
                
                print("IMAGE URL \(urlString)")
                UserDefaults.standard.set(urlString, forKey: "url")
                
                
                
                
            })
        })
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }

//    func uploadPhoto () {
//        guard profilePicture != nil else {
//            return
//        }
//        let storageRef = Storage.storage().reference()
//        let imageDate = profilePicture!.jpegData(compressionQuality: 0.8)
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateProfile()
        
        profilePicture.contentMode = .scaleAspectFit
        //getInformation()
        
        guard let urlString = UserDefaults.standard.value(forKey: "url") as? String, let url = URL(string: urlString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in guard let data = data, error == nil else {
            return
        }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.profilePicture.image = image
            }
        })
        task.resume()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        populateProfile()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? ProfileViewController
        let ref = Database.database(url: "https://ryde-33483-default-rtdb.europe-west1.firebasedatabase.app").reference()
        destination?.fullName.text = nameField.text
        destination?.fullName.text = lastNameField.text

        let uid = Auth.auth().currentUser?.uid
   
        
        if !nameField.text!.isEmpty && !editPhoneNum.text!.isEmpty && !editPass.text!.isEmpty && !lastNameField.text!.isEmpty {
            print("working")
            ref.child("users").child(userType).child(uid!).updateChildValues(["First Name": self.nameField.text!, "Last Name": self.lastNameField.text! , "Phone Number": self.editPhoneNum.text! , "Password": self.editPass.text! ])
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
                    
                    self.nameField.text = value?["First Name"] as? String
                    self.lastNameField.text = value? ["Last Name"] as? String
                    self.editPhoneNum.text = value? ["Phone Number"] as? String
                    self.editPass.text = value? ["Password"] as? String

                    

                }
            }
        }
            
        })
    }
//    @IBAction func didTapButton() {
//        let picker = UIImagePickerController()
//        picker.sourceType = .photoLibrary
//        picker.delegate = self
//        picker.allowsEditing = true
//        present(picker, animated: true)
//    }
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
//        picker.dismiss(animated: true, completion: nil)
//        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
//            return
//        }
//        guard let imageData = image.pngData() else {
//            return
//        }
//
//    }
//
//
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        picker.dismiss(animated: true, completion: nil)
//
//
//
//
//
//
//
//}
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


}
