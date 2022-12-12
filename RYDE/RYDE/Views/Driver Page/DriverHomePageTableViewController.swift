//
//  DriverHomePageTableViewController.swift
//  RYDE
//
//  Created by iOSdev on 07/12/2022.
//

import UIKit
import FirebaseDatabase

class DriverHomePageTableViewController: UITableViewController, DriverHomePageDelegate, UISearchBarDelegate {
    

    // MARK: DriverHomePage Outlets
    @IBOutlet var searchBar: UISearchBar!
    
    // MARK: DriverHomePage Variables
//    var tempRideArray = [tempRide]()
    var ridesArray = [Ride]()
    var filteredRidesArray = [Ride]()
    var searching: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        filteredRidesArray = ridesArray
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        populateData()

//        print(tempRideArray["a"])
    }
    override func viewWillAppear(_ animated: Bool) {
//        print("Will appear..")
        //populateLabel()
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 2
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning  implementation, return the number of rows
//        return filteredRidesArray.count
        return ridesArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "driverRidesCell", for: indexPath) as! DriverRideListTableViewCell
        
        cell.configureCell(inputRide: ridesArray[indexPath.row])
//        print(tempRideArray[indexPath.row])
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    

    
    func populateData() {
        ridesArray = []
        let ref = Database.database(url: FBReference.databaseRef).reference()
        
        ref.child("driver").child("4").child("rides").observeSingleEvent(of: .value) { [self] (snapshot) in
            if let value = snapshot.value as? NSDictionary {
                for i in value.allKeys {
                    ref.child("driver").child("4").child("rides").child("\(i)").observeSingleEvent(of: .value) {
                        (dataSnapshot) in
                        if let value = dataSnapshot.value as? NSDictionary {
//                            print(value["fromLocation"])
//                            self.ridesArray = []
                            if self.ridesArray.isEmpty {
//                                print(value["PricePerRide"] as? Int)
                                self.ridesArray.append(
                                    Ride(rideId: i as? String,
                                         goingTime: value["goingTime"]  as? String,
                                         returnTime: value["returnTime"]  as? String,
                                         dateFrom: value["fromDate"] as? String,
                                         dateTo: value["toDate"] as? String,
                                         fromLocation: value["fromLocation"]  as? String,
                                         toLocation: value["toLocation"]  as? String,
                                         price: value["PricePerRide"] as? String,
                                         daysOfWeek: value["DaysOfWeek"] as? [Int],
                                         noOfSeats: value["NoOfSeats"] as? String
                                        )
                                )

                                print("Data for ride ID: \(i)  -- loaded and saved to array...")
                                self.tableView.reloadData()
                            }
                            else {
                                print(i)
                                if !self.ridesArray.contains(where: {$0.rideId == i as! String}) {
                                    self.ridesArray.append(
                                        Ride(rideId: i as? String,
                                             goingTime: value["goingTime"]  as? String,
                                             returnTime: value["returnTime"]  as? String,
                                             dateFrom: value["fromDate"] as? String,
                                             dateTo: value["toDate"] as? String,
                                             fromLocation: value["fromLocation"]  as? String,
                                             toLocation: value["toLocation"]  as? String,
                                             price: value["PricePerRide"] as? String,
                                             daysOfWeek: value["DaysOfWeek"] as? [Int],
                                             noOfSeats: value["NoOfSeats"] as? String
                                            )
                                    )

                                    print("Data for ride ID: \(i)  -- loaded and saved to array...")
                                    filteredRidesArray = ridesArray
                                    self.tableView.reloadData()
                                }
                                
                            }
                           
                        }
                        else {
                            print("Error in fetching inside data!")
                        }
                    }
                }
            }
            else {
                print("Value Not Found: Error Fetching data!")
            }
            
//            print(value?.allKeys)
            
            
            
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(ridesArray[indexPath.row])
        addToPassengers(indexPath: indexPath)
    }

    
    
    // Connecting the delegate to be able to call refresh function after adding a ride
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "homeToAdd" {
            if let destinationNavigation = segue.destination as? UINavigationController {
                if let destinationTVC = destinationNavigation.viewControllers.first as? AddEditRideTableViewController {
                    destinationTVC.delegation = self
                }
            }
        }
    }
    
    // Refresh date, to be called from the next controller after the driver adds a ride
    func refreshData() {
        print("Date refreshed after addition...")
        populateData()
        tableView.reloadData()
    }
    
    // Refresh after sliding up
    @IBAction func refreshControl(_ sender: UIRefreshControl) {
        populateData()
        tableView.reloadData()
        sender.endRefreshing()
    }
    
    
    // Adding the ability to delete
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Remove item from table view and delete it from array
//            print(ridesArray[indexPath.row].rideId)
            
            let ref = Database.database(url: FBReference.databaseRef).reference()
            ref.child("driver").child("4").child("rides").child("\(ridesArray[indexPath.row].rideId!)").removeValue()
            
            
            ridesArray.remove(at: indexPath.row)
            filteredRidesArray = ridesArray
            print("Data deleted...")
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
    }
    
    // Adding ability to re-order items
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedItem = ridesArray.remove(at: sourceIndexPath.row)
        ridesArray.insert(movedItem, at: destinationIndexPath.row)
        filteredRidesArray = ridesArray
    }
    
    

    // Function to increase the number of passengers/seat, that will be called after each passenger books a ride
    func addToPassengers(indexPath: IndexPath) {
        ridesArray[indexPath.row].noOfPassengers += 1
        filteredRidesArray = ridesArray
        tableView.reloadData()
    }
    
    
    
    // MARK: Implementing DRIVER Search Table
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchBar.showsCancelButton = true
        
        // If there is no text, filteredData is the same. If user enters text, filter changes based on text. For each item return true if it's included and false if not.
        if searchText.isEmpty {
            searching = false
            filteredRidesArray = ridesArray
        }
        else {
//            print(searchText)
//            print(filteredRidesArray[1].toLocation?.lowercased().contains(searchText.lowercased()))
//            for i in 0...ridesArray.count - 1 {
//                if ridesArray[i].toLocation?.lowercased().contains(searchText.lowercased()) == true {
//                    ridesArray[i] = filteredRidesArray[i]
//                }
//                else {
//                    print("Not")
//                    filteredRidesArray.remove(at: i)
//                }
//            }
//            for i in 0...ridesArray.count-1 {
//                filteredRidesArray[i].toLocation = ridesArray[i].toLocation contains(loc.range(of: searchText, options: .caseInsensitive, range: nil) != nil)
//            }
            
        }
        
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    
    // Setting up ability to edit
    
}
