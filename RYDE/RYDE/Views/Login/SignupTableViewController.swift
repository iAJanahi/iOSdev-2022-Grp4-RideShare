//
//  SignupTableViewController.swift
//  RYDE
//
//  Created by iOSdev on 04/12/2022.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SignupTableViewController: UITableViewController {
    var url: String = "https://ryde-33483-default-rtdb.europe-west1.firebasedatabase.app"
    @IBOutlet var firsNameField: UITextField!
    @IBOutlet var lastNameField: UITextField!
    @IBOutlet var cprField: UITextField!
    @IBOutlet var phoneField: UITextField!
    @IBOutlet var bdoPicker: UIDatePicker!
    @IBOutlet weak var bdoDateLabel: UILabel!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var confirmPasswordField: UITextField!
    @IBOutlet var drivingNoField: UITextField!
    @IBOutlet weak var modelField: UITextField!
    @IBOutlet weak var ColorField: UITextField!
    @IBOutlet weak var noOfSeatsField: UITextField!
    @IBOutlet weak var busNoField: UITextField!
    
    let checkInDatePickerCellIndexPath = IndexPath(row: 9, section: 0)
    let checkInDateLabelCellIndexPath = IndexPath(row: 8, section: 0)
    
    var isCheckInDatePickerVisible: Bool = false {
        didSet {
            bdoPicker.isHidden = !isCheckInDatePickerVisible
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func register(_ sender: UIButton) {
        guard let firstName = firsNameField.text,!firstName.isEmpty,
              let lastName = lastNameField.text,!lastName.isEmpty,
              let cpr = cprField.text, !cpr.isEmpty,
              let phone = phoneField.text, !phone.isEmpty,
              let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty,
              let confirmPassword = confirmPasswordField.text, !confirmPassword.isEmpty,
              let drivingNumb = drivingNoField.text, !drivingNumb.isEmpty,
              let model = modelField.text, !model.isEmpty,
              let color = ColorField.text, !color.isEmpty,
              let busNo = busNoField.text, !busNo.isEmpty,
              let noOfSeats = noOfSeatsField.text, !noOfSeats.isEmpty
                , !validationOfTextFields()
        
        else {
            let alert = UIAlertController(title: "Missing field data", message: "please fill in the required fields", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            self.present(alert, animated: true)
                        return
        }
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password,completion: {[weak self] result, error in guard let self = self
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
            ref.child("users").child("drivers").child(uid!).setValue([ "First Name" : self.firsNameField.text, "Last Name" : self.lastNameField.text, "CPR" : self.cprField.text , "Phone" : self.phoneField.text, "Email" : self.emailField.text, "Password" : self.passwordField.text, "Confirm Password" : self.confirmPasswordField.text , "Driving No" : self.drivingNoField.text, "Bus Model" : self.modelField.text, "Bus Number": self.busNoField.text ,"Bus Color": self.ColorField.text, "Number of Seats": self.noOfSeatsField.text ])
            
            let alert = UIAlertController(title: "Success", message: "Account Successfully created", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
                self.navigationController?.popToRootViewController(animated: true)
        }))
            self.present(alert, animated: true)
        })
    }

    func validationOfTextFields() -> Bool {
        
        if passwordField.text != confirmPasswordField.text {
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
    override func tableView(_ tableView: UITableView,
       heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case checkInDatePickerCellIndexPath where
           isCheckInDatePickerVisible == false:
            return 0
        default:
            return UITableView.automaticDimension
        }
    }
    override func tableView(_ tableView: UITableView,
       estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case checkInDatePickerCellIndexPath:
            return 190
        default:
            return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView,
       didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath == checkInDateLabelCellIndexPath {
            isCheckInDatePickerVisible.toggle()
        } else {
            return
        }
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    
    
}


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    

    // MARK: - Table view data source

   /* override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

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
     /**/*/*/
