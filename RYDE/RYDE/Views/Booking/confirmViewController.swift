//
//  confirmViewController.swift
//  RYDE
//
//  Created by iOSdev on 05/12/2022.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class confirmViewController: UIViewController {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var toLocation: UILabel!
    @IBOutlet weak var driverName: UILabel!
    @IBOutlet weak var goingReturnTime: UILabel!
    @IBOutlet weak var price: UILabel!
    
    
    
    
    var bookedRide: Ride?
    
    init?(coder: NSCoder, bookedRide: Ride) {
        self.bookedRide = bookedRide
        super.init(coder: coder)
    }
    required init?(coder: NSCoder) {
        fatalError("Init coder has not been implemented!")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let bookedRide = bookedRide {
            print(bookedRide)
            userName.text = "Something"
        }
        else {
            print("Booked ride failed!")
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func getUserName() {
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
                    
//                    let fName = value?["First Name"] as? String
//                    let lName = value?["Last Name"] as? String
//                    let fullName = "\(fName!) \(lName!)"
//                    self.fullName.text = fullName
//                    self.emailLabel.text = value? ["Email"] as? String
                    
                    
                }
            }
        }
            
        })
            
    }
    
    
    @IBAction func payWithAppleButtonTapped(_ sender: Any) {
    }
    @IBAction func payWithBenefitButtonTapped(_ sender: Any) {
    }
}
