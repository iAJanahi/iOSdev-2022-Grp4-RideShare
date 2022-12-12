//
//  AddEditRideTableViewController.swift
//  RYDE
//
//  Created by iOSdev on 07/12/2022.
//

import UIKit
import FirebaseDatabase

protocol DriverHomePageDelegate: class {
    func refreshData()
}
class AddEditRideTableViewController: UITableViewController {

    weak var delegation: DriverHomePageDelegate?
    
    
    @IBOutlet var fromTextField: UITextField!
    @IBOutlet var toTextField: UITextField!
    @IBOutlet var goingTimePicker: UIDatePicker!
    @IBOutlet var returnTimePicker: UIDatePicker!
    @IBOutlet var dateFromPicker: UIDatePicker!
    @IBOutlet var dateToPicker: UIDatePicker!
    

    @IBOutlet var saturdayButton: UIButton!
    var isSaturdayClicked = false
    @IBOutlet var sundayButton: UIButton!
    var isSundayClicked = false
    @IBOutlet var mondayButton: UIButton!
    var isMondayClicked = false
    @IBOutlet var tuesdayButton: UIButton!
    var isTuesdayClicked = false
    @IBOutlet var wednesdayButton: UIButton!
    var isWednesdayClicked = false
    @IBOutlet var thursdayButton: UIButton!
    var isThursdayClicked = false
    @IBOutlet var fridayButton: UIButton!
    var isFridayClicked = false
    
    @IBOutlet var priceTextField: UITextField!
    @IBOutlet var noOfSeatsTextField: UITextField!
    
    var tempFrom: String = ""
    var tempTo: String = ""
    var tempGoing: String = ""
    var tempReturn: String = ""
    var tempDaysOfWeek = [String:Int]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setting a minimum date for the calendar date and time
        let calendar = Calendar(identifier: .gregorian)
        let currentDate = Date()
        var components = DateComponents()
        components.calendar = calendar
        let minDate = calendar.date(byAdding: components, to: currentDate)!
        
        dateFromPicker.minimumDate = minDate
        dateToPicker.minimumDate = dateFromPicker.date
        returnTimePicker.minimumDate = goingTimePicker.date
    }

    // MARK: - Table view data source

    // Saving inputted ride details to the specific driver rides
    @IBAction func addButtonTapped(_ sender: Any) {
//        tempFrom = fromTextField.text!
//        tempTo = toTextField.text!
        tempGoing = goingTimePicker.date.formatted(date: .omitted, time: .shortened)
        tempReturn = returnTimePicker.date.formatted(date: .omitted, time: .shortened)
        let tempDateFrom = dateFromPicker.date.formatted(date: .numeric, time: .omitted)
        let tempDateTo = dateToPicker.date.formatted(date: .numeric, time: .omitted)
        var daysOfWeekArray = Array(tempDaysOfWeek.values)
//        let tempNoOfSeats = noOfSeatsTextField.text!
//        let price = priceTextField.text

//        print("""
//            From: \(tempFrom)
//            To: \(tempTo)
//            Date: \(tempDateFrom) -- \(tempDateTo)
//            Going: \(tempGoing)
//            Return: \(tempReturn)
//            Price: \(String(describing: price)) BD
//            \(tempDaysOfWeek.values) days a week
//
//            """)
        
        guard let fromLoc = fromTextField.text, !fromLoc.isEmpty,
              let toLoc = toTextField.text, !toLoc.isEmpty,
              let noOfSeats = noOfSeatsTextField.text, !noOfSeats.isEmpty,
              let price = priceTextField.text, !price.isEmpty
        else {
            let alert = UIAlertController(title: "Missing Field Data", message: "Please fill in all the fields!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))

            self.present(alert, animated: true)

            return
        }

        let alert = UIAlertController(title: "Success", message: "Ride Successfully Added!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {
            _ in
            self.dismiss(animated: true)
        }))

        let ref = Database.database(url: FBReference.databaseRef).reference()
        let dId = "4" // When we know the driver ID it will be here
        let rId = UUID().uuidString // Ride ID
        ref.child("driver").child(dId).child("rides").child(rId).setValue([
            "fromLocation": fromLoc,
            "toLocation": toLoc,
            "goingTime": tempGoing,
            "returnTime": tempReturn,
            "fromDate": tempDateFrom,
            "toDate": tempDateTo,
            "NoOfSeats": noOfSeats,
            "PricePerRide": price,
            "DaysOfWeek": daysOfWeekArray,
            "NoOfPassengers": 0
        ])
        
        self.delegation?.refreshData()
        self.present(alert, animated: true)

//        self.dismiss(animated: true)

        return
    }
    
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    // Days of week buttons
  
    @IBAction func dayOfWeekButtonTapped(_ sender: UIButton) {
//        print(sender.tag)
        
        switch sender.tag {
        case 1:
            if !isSundayClicked {
                sundayButton.setImage(UIImage(systemName: "s.circle.fill"), for: .normal)
                isSundayClicked = !isSundayClicked
                tempDaysOfWeek["Sunday"] = 1
            }
            else {
                sundayButton.setImage(UIImage(systemName: "s.circle"), for: .normal)
                isSundayClicked = !isSundayClicked
                tempDaysOfWeek.removeValue(forKey: "Sunday")
            }
            
        case 2:
            if !isMondayClicked {
                mondayButton.setImage(UIImage(systemName: "m.circle.fill"), for: .normal)
                isMondayClicked = !isMondayClicked
                tempDaysOfWeek["Monday"] = 2
            }
            else {
                mondayButton.setImage(UIImage(systemName: "m.circle"), for: .normal)
                isMondayClicked = !isMondayClicked
                tempDaysOfWeek.removeValue(forKey: "Monday")

            }
            
        case 3:
            if !isTuesdayClicked {
                tuesdayButton.setImage(UIImage(systemName: "t.circle.fill"), for: .normal)
                isTuesdayClicked = !isTuesdayClicked
                tempDaysOfWeek["Tuesday"] = 3
            }
            else {
                tuesdayButton.setImage(UIImage(systemName: "t.circle"), for: .normal)
                isTuesdayClicked = !isTuesdayClicked
                tempDaysOfWeek.removeValue(forKey: "Tuesday")
            }
            
        case 4:
            if !isWednesdayClicked {
                wednesdayButton.setImage(UIImage(systemName: "w.circle.fill"), for: .normal)
                isWednesdayClicked = !isWednesdayClicked
                tempDaysOfWeek["Wednesday"] = 4
            }
            else {
                wednesdayButton.setImage(UIImage(systemName: "w.circle"), for: .normal)
                isWednesdayClicked = !isWednesdayClicked
                tempDaysOfWeek.removeValue(forKey: "Wednesday")
            }
            
        case 5:
            if !isThursdayClicked {
                thursdayButton.setImage(UIImage(systemName: "t.circle.fill"), for: .normal)
                isThursdayClicked = !isThursdayClicked
                tempDaysOfWeek["Thursday"] = 5
            }
            else {
                thursdayButton.setImage(UIImage(systemName: "t.circle"), for: .normal)
                isThursdayClicked = !isThursdayClicked
                tempDaysOfWeek.removeValue(forKey: "Thursday")
            }
            
        case 6:
            if !isFridayClicked {
                fridayButton.setImage(UIImage(systemName: "f.circle.fill"), for: .normal)
                isSundayClicked = !isSundayClicked
                tempDaysOfWeek["Friday"] = 6
            }
            else {
                fridayButton.setImage(UIImage(systemName: "f.circle"), for: .normal)
                isFridayClicked = !isFridayClicked
                tempDaysOfWeek.removeValue(forKey: "Friday")
            }
            
        case 7:
            if !isSaturdayClicked {
                saturdayButton.setImage(UIImage(systemName: "s.circle.fill"), for: .normal)
                isSaturdayClicked = !isSaturdayClicked
                tempDaysOfWeek["Saturday"] = 7
            }
            else {
                saturdayButton.setImage(UIImage(systemName: "s.circle"), for: .normal)
                isSaturdayClicked = !isSaturdayClicked
                tempDaysOfWeek.removeValue(forKey: "Saturday")
            }
            
        default:
            print("Error: No Button for the days of week!")
        }
    }
    
    
}
