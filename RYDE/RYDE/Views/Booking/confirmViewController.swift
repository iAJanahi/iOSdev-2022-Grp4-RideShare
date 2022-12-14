//
//  confirmViewController.swift
//  RYDE
//
//  Created by iOSdev on 05/12/2022.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

protocol ConfirmFromRideDelegate: class {
    func goToHome()
}
class confirmViewController: UIViewController {

    weak var delegation: ConfirmFromRideDelegate?
    
    @IBOutlet weak var noOfPassengers: UILabel!
    @IBOutlet weak var toLocation: UILabel!
    @IBOutlet weak var driverName: UILabel!
    @IBOutlet weak var goingTime: UILabel!
    @IBOutlet weak var returnTime: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var confirmationView: UIView!
    
    var fullName = ""
    

    
    
    
    var bookedRide: Ride?
    var selectedSeats: Int?
    var userLong: Double?
    var userLat: Double?
    
    init?(coder: NSCoder, bookedRide: Ride, selectedSeats: Int, userLong: Double, userLat: Double) {
        self.bookedRide = bookedRide
        self.selectedSeats = selectedSeats
        self.userLong = userLong
        self.userLat = userLat
    
        super.init(coder: coder)
    }
    required init?(coder: NSCoder) {
        fatalError("Init coder has not been implemented!")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        confirmationView.layer.cornerRadius = 10
        
        getUserName()
        if let bookedRide = bookedRide, let selectedSeats = selectedSeats {
            print(bookedRide)
            noOfPassengers.text = "x\(selectedSeats)"
            toLocation.text = bookedRide.toLocation
            driverName.text = bookedRide.driverName
            goingTime.text = "\(bookedRide.goingTime!)"
            returnTime.text = "\(bookedRide.returnTime!)"
            
            let totalPrice = Double(bookedRide.price!)! * Double(selectedSeats)
//            print(Double(bookedRide.price!)! + selectedSeats)
            price.text = "\(totalPrice) BHD"
            
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
                    
                    let fName = value?["First Name"] as? String
                    let lName = value?["Last Name"] as? String
                    self.fullName = "\(fName!) \(lName!)"
                    
                    print(self.fullName)

                    
                    
                }
            }
        }
            
        })
            
    }
    
    
    @IBAction func payWithAppleButtonTapped(_ sender: Any) {
//        getUserName()
        let alert = UIAlertController(title: "Payment Successful", message: "Thank you for your payment !", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { [self] action in
//            print(Auth.auth().currentUser?.uid)
//            print(self.userLat)
//            print(self.userLong)
    
            sendPassengerToFB(long: self.userLong ?? 0, lat: self.userLat ?? 0, name: self.fullName, rideID: self.bookedRide?.rideId ?? "")
            
            self.DismissView()
        }))
        
        present(alert, animated: true, completion: nil)
    }
    @IBAction func payWithBenefitButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Payment Successful", message: "Thank you for your payment !", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { [self] action in
//            print(Auth.auth().currentUser?.uid)
//            print(self.userLat)
//            print(self.userLong)
    
            sendPassengerToFB(long: self.userLong ?? 0, lat: self.userLat ?? 0, name: self.fullName, rideID: self.bookedRide?.rideId ?? "")
            
            self.DismissView()
        }))
        
        present(alert, animated: true, completion: nil)
        
    }
    @IBAction func payWithCashButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Payment Successful", message: "Thank you for your payment !", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { [self] action in
//            print(Auth.auth().currentUser?.uid)
//            print(self.userLat)
//            print(self.userLong)
    
            sendPassengerToFB(long: self.userLong ?? 0, lat: self.userLat ?? 0, name: self.fullName, rideID: self.bookedRide?.rideId ?? "")
            
            self.DismissView()
        }))
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func DismissView() {
        print("Dismiss")
        dismiss(animated: true)
//        delegation?.goToHome()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
//        delegation?.goToHome()
        _ = self.tabBarController?.selectedIndex = 1

    }
    
    
    func sendPassengerToFB(long: Double, lat: Double, name: String, rideID: String) {
        print(" \(long)-\(lat) / \(name) / \(rideID)")
        
        let ref = Database.database(url: FBReference.databaseRef).reference()
        
//        let rId = UUID().uuidString // Ride ID
        ref.child("RidesPassengers").child("\(rideID)").child("\(Auth.auth().currentUser!.uid)").setValue([
            "Name": fullName,
            "Longtitude": long,
            "Latitude": lat
        ])
        
        
    }
    

    
}
