//
//  SingUpPassengersTableViewController.swift
//  RYDE
//
//  Created by iOSdev on 08/12/2022.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SingUpPassengersTableViewController: UITableViewController {
    var url: String = "https://ryde-33483-default-rtdb.europe-west1.firebasedatabase.app"
    
    @IBOutlet weak var nameField1: UITextField!
    @IBOutlet weak var nameField2: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var dobLabel1: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var email1: UITextField!
    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var confirmPass: UITextField!
    @IBOutlet weak var cityTxt: UITextField!
    @IBOutlet weak var uniField: UITextField!
    @IBOutlet weak var regButton: UIButton!
    
    let checkInDatePickerCellIndexPath1 = IndexPath(row: 7, section: 0)
    let checkInDateLabelCellIndexPath1 = IndexPath(row: 6, section: 0)
    
    var isCheckInDatePickerVisible1: Bool = false {
        didSet {
            datePicker.isHidden = !isCheckInDatePickerVisible1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func tableView(_ tableView: UITableView,
       heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case checkInDatePickerCellIndexPath1 where
           isCheckInDatePickerVisible1 == false:
            return 0
        default:
            return UITableView.automaticDimension
        }
    }
    override func tableView(_ tableView: UITableView,
       estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case checkInDatePickerCellIndexPath1:
            return 190
        default:
            return UITableView.automaticDimension
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath == checkInDateLabelCellIndexPath1 {
            isCheckInDatePickerVisible1.toggle()
        } else {
            return
        }
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    @IBAction func register1(_ sender: UIButton) {
        guard let nameF = nameField1.text,!nameF.isEmpty,
              let nameL = nameField2.text, !nameL.isEmpty,
              let phone1 = phoneField.text,!phone1.isEmpty,
              let emaiil = email1.text, !emaiil.isEmpty,
              let pass1 = pass.text,!pass1.isEmpty,
              let confirmPass1 = confirmPass.text, !confirmPass1.isEmpty,
              let city = cityTxt.text,!city.isEmpty,
              let uni = uniField.text, !uni.isEmpty,
              !validationOfTextFields1()
               
        else {
            let alert = UIAlertController(title: "Missing field data", message: "please fill in the required fields", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            self.present(alert, animated: true)
                        return
        }
        
        FirebaseAuth.Auth.auth().createUser(withEmail: emaiil, password: pass1 ,completion: {[weak self] result, error in guard let self = self
            else {return}
            guard error == nil else {
                print(error ?? "")
                let alert = UIAlertController(title: "Error", message: "Signup Failed", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                self.present(alert, animated: true)
                            return
            }
            let ref = Database.database(url: "https://ryde-33483-default-rtdb.europe-west1.firebasedatabase.app").reference()
            let uid = Auth.auth().currentUser?.uid
            ref.child("users").child("passengers").child(uid!).setValue([ "First Name" : self.nameField1.text, "Last Name" : self.nameField2.text, "Phone Number" : self.phoneField.text, "Email" : self.email1.text, "Password" : self.pass.text, "Confirm Password" : self.confirmPass.text , "City" : self.cityTxt.text , "University" : self.uniField.text  ])
            
            let alert = UIAlertController(title: "Success", message: "Account Successfully created", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
                self.navigationController?.popToRootViewController(animated: true)
        }))
            self.present(alert, animated: true)
        })
        
        func validationOfTextFields1() -> Bool {
            
            if pass.text != confirmPass.text {
                let alertController = UIAlertController(title: "Error", message: "Password don't Match", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
                return true
            }
            else {
                return false
            }
        }
        
    
    

    
    // MARK: - Table view data source

   

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
    
}
