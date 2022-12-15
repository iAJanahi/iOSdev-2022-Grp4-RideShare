//
//  HistoryViewController.swift
//  RYDE
//
//  Created by iOSdev on 14/12/2022.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var completedTableView: UITableView!
    
    // labels for current RYDE
    @IBOutlet var driverNameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var pickTimeLabel: UILabel!
    
    
    var passenger: [Ride] = [Ride(rideId: "0934bfjd", goingTime: "12:00PM", returnTime: "1:00PM", dateFrom: "15-12-2022", dateTo: "1-1-2023", driverName: "Philipe Pringuet", fromLocation: "Saar", toLocation: "Polytechnic", price: "2 BD", noOfPassengers: 1, noOfSeats: "16")]
    
    var completedRide : [Ride] = [Ride(rideId: "reor3432", goingTime: "08:00 AM", returnTime: "2:00 PM", dateFrom: "11-12-2022", dateTo: "11-12-2022", driverName: "Abdulla Isa", fromLocation: "Manama", toLocation: "Polytechnic", price: "3 BD", noOfPassengers: 2, noOfSeats: "12")]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return completedRide.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as! HistoryTableViewCell
        
        cell.update(viewRides: completedRide[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Completed Rides"
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        // Do any additional setup after loading the view.
        completedTableView.delegate = self
        completedTableView.dataSource = self
        
        driverNameLabel.text = passenger.first?.driverName
        dateLabel.text = passenger.first?.dateFrom
        pickTimeLabel.text = passenger.first?.goingTime
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

//    func configure(current: passenger){
//        driverNameLabel.text = current.firstName
//        dateLabel.text = current.fir
//        pickTimeLabel.text = current.goingTime
//    }

}
