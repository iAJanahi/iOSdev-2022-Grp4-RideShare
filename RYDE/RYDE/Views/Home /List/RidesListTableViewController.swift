//
//  RidesListTableViewController.swift
//  RYDE
//
//  Created by iOSdev on 06/12/2022.
//

import UIKit
import FirebaseDatabase

class RidesListTableViewController: UITableViewController, ConfirmFromRideDelegate {
    
    // MARK: Rides List Table View Controller Outlets
    @IBOutlet var navBarSearchButton: UIButton!
    

    // MARK: Rides List Table View Controller Variables
    // Demo array for the rides
//    var ridesArray = [
//        Ride(rideId: "1", goingTime: "Date()", returnTime: "Date()", dateFrom: "Date from", dateTo: "Date to", driver: Driver(firstName: "Mohammed", lastName: "Jassim", licenseNumber: 123, gender: "Male"), fromLocation: "Muharraq", toLocation: "University of Bahrain", price: "2.5", daysOfWeek: [1, 3, 5], noOfPassengers: 2, noOfSeats: "16"),
//        Ride(rideId: "2", goingTime: "Date()", returnTime: "Date()", dateFrom: "Date from", dateTo: "Date to", driver: Driver(firstName: "Fatima", lastName: "Hassan", licenseNumber: 567, gender: "Female"), fromLocation: "Manama", toLocation: "Polytechnic", price: "12.5", daysOfWeek: [2, 4], noOfPassengers: 0, noOfSeats: "9")
//
//    ]
    
    var ridesArray = [Ride]()
    
    var tempFrom: String?
    var tempTo: String?
//    var tempArray: Any?
    
    var rideFilter: rideFilter?
    init?(coder: NSCoder, rideF: rideFilter) {
        self.rideFilter = rideF
        super.init(coder: coder)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented...")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        populateRideListData()
//        print(ridesArray)
        if let rideFilter = rideFilter {
            print(rideFilter)
            navBarSearchButton.setTitle("    \(rideFilter.fromLocation) -- \(rideFilter.toLocation)", for: .normal)
        }
        else {
            print("No filter was selected!")
        }
        print(ridesArray.count)
        print(ridesArray)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ridesArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ridesCell", for: indexPath) as! RidesListTableViewCell
        
        cell.configureCell(ride: ridesArray[indexPath.row])

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(ridesArray[indexPath.row])
    }

 

 

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func navBarSearchButtonTapped(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func filterButtonTapped(_ sender: Any) {
//        populateRideListData()
    }
    
    
    
    // MARK: Firebase
    // Reading from database
    func populateRideListData() {
//        ridesArray = []
        var tempArray: NSDictionary?
        let ref = Database.database(url: FBReference.databaseRef).reference()
        
        ref.child("users").child("drivers").observeSingleEvent(of: .value) { [self] (snapshot) in
            if let value = snapshot.value as? NSDictionary {
                for i in value.allKeys {
//                    print(i)
                    ref.child("users").child("drivers").child(i as! String).child("Rides").observeSingleEvent(of: .value) {
                        (rideSnapshot) in
        
                        if let rValue = rideSnapshot.value as? NSDictionary{
//                            print(rValue.allKeys)
                            for j in rValue.allKeys {
                                ref.child("users").child("drivers").child(i as! String).child("Rides").child("\(j)").observeSingleEvent(of: .value) {
                                    (infoSnapshot) in
                                    
                                    if let infoValue = infoSnapshot.value as? NSDictionary {
//                                        print(infoValue["from"])
                                        // Check if Ride ID does exist in the array already
//                                        print(infoValue)
                                        if !self.ridesArray.contains(where: {$0.rideId == j as! String}) {
                                            self.ridesArray.append(
                                                Ride(rideId: j as? String,
                                                     goingTime: infoValue["goingTime"]  as? String,
                                                     returnTime: infoValue["returnTime"]  as? String,
                                                     dateFrom: infoValue["fromDate"] as? String,
                                                     dateTo: infoValue["toDate"] as? String,
                                                     driverName: infoValue["DriverName"] as? String,
                                                     driverGender: infoValue["Gender"] as? String,
                                                     fromLocation: infoValue["fromLocation"]  as? String,
                                                     toLocation: infoValue["toLocation"]  as? String,
                                                     price: infoValue["PricePerRide"] as? String,
                                                     daysOfWeek: infoValue["DaysOfWeek"] as? [Int],
                                                     noOfSeats: infoValue["NoOfSeats"] as? String
                                                    )
                                            )

                                            print("Data for ride ID: \(j)  -- loaded and saved to array...")
//                                            print(self.ridesArray)
                                            self.tableView.reloadData()
                                        }
                                        
                                        
                                    }
                                }
                            }



                        }
                        
                        
                        
                        
                        else {
                            print("Inner value not found!")
                        }
                        
                    }
                }

            }
            else {
                print("Value Not Found: Error Fetching data!")
            }
        }
        
    }
    
    
    
    
    // Sending data to confirm page
    @IBSegueAction func goToConfirmPage(_ coder: NSCoder, sender: Any?) -> UIViewController? {
        if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell)  {
            print("Entered IF")
            let rideToSend = ridesArray[indexPath.row]
            
            return confirmViewController(coder: coder, bookedRide: rideToSend, selectedSeats: 3)
        }
        else {
            print("ELSE")
            return nil
        }
    }
    
    
    func goToHome() {
        self.performSegue(withIdentifier: "unwindToHome", sender: self)
    }
    
}
