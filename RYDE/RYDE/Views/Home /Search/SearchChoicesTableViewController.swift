//
//  SearchChoicesTableViewController.swift
//  RYDE
//
//  Created by iOSdev on 05/12/2022.
//

import UIKit

class SearchChoicesTableViewController: UITableViewController, getSelectedLocation {

    // MARK: Search choices MAIN variables (Other variables are within each of their section)
        
    
    // MARK: Seach choices outlets
    @IBOutlet var fromButton: UIButton!
    @IBOutlet var toButton: UIButton!
    
    // Section 1
    @IBOutlet var firstNextButton: UIButton!
    
    
    // Section 2
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var goingTimePicker: UIDatePicker!
    @IBOutlet var returnTimePicker: UIDatePicker!
        
    
    // Section 3
    @IBOutlet var noOfPassengersLabel: UILabel!
    @IBOutlet var noOfPassengersStepper: UIStepper!
    @IBOutlet var passengerStepper: UIStepper!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting a minimum date for the calendar date and time
        let calendar = Calendar(identifier: .gregorian)
        let currentDate = Date()
        var components = DateComponents()
        components.calendar = calendar
        let minDate = calendar.date(byAdding: components, to: currentDate)!
        
        datePicker.minimumDate = minDate
        returnTimePicker.minimumDate = goingTimePicker.date
        
        // Initializing no Of passengers label
        noOfPassengersLabel.text = Int(passengerStepper.value).description


    }
    
    
    
    
    // MARK: Table view setups
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        // For section 2 and 3, if it's not visible, hide by setting the height to 0
        switch indexPath {
        case calenderPickerCellIndexPath where isSectionTwoVisible == false,
            goingTimePickerCellIndexPath where isSectionTwoVisible == false,
            returnTimePickerCellIndexPath where isSectionTwoVisible == false,
            secondNextButtonCellIndexPath where isSectionTwoVisible == false:
            return 0
        case fromButtonCellIndexPath where isSectionOneVisible == false,
             toButtonCellIndexPath where isSectionOneVisible == false,
            firstNextButtonCellIndexPath where isSectionOneVisible == false:
            return 0
        case noOfPassengerCellIndexPath where isSectionThreeVisible == false,
            submitCellIndexPath where isSectionThreeVisible == false:
            return 0
        default:
            return UITableView.automaticDimension
        }
    
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case fromButtonCellIndexPath:
            return 50
        case toButtonCellIndexPath:
            return 50
        case firstNextButtonCellIndexPath:
            return 70
        case calenderPickerCellIndexPath:
            return 300
        case goingTimePickerCellIndexPath:
            return 50
        case returnTimePickerCellIndexPath:
            return 50
        case secondNextButtonCellIndexPath:
            return 70
        case noOfPassengerCellIndexPath:
            return 45
        case submitCellIndexPath:
            return 70
        default:
            return UITableView.automaticDimension
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath == whereCellIndexPath {
            isSectionOneVisible = true
            isSectionTwoVisible = false
            isSectionThreeVisible = false
        }
        else if indexPath == whenCellIndexPath {
            isSectionOneVisible = false
            isSectionTwoVisible = true
            isSectionThreeVisible = false
        }
        else if indexPath == whoCellIndexPath {
            isSectionOneVisible = false
            isSectionTwoVisible = false
            isSectionThreeVisible = true
        }
        else {
            return
        }

        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    
    
    
    // MARK: Search page section 1
    var tempFromLoc = ""
    var tempToLoc = ""
    
    var isSectionOneVisible: Bool = true {
        didSet {
            fromButton.isHidden = !isSectionOneVisible
            toButton.isHidden = !isSectionOneVisible
        }
    }
    let whereCellIndexPath = IndexPath(row: 0, section: 0)
    
    let fromButtonCellIndexPath = IndexPath(row: 1, section: 0)
    let toButtonCellIndexPath = IndexPath(row: 2, section: 0)
    let firstNextButtonCellIndexPath = IndexPath(row: 3, section: 0)

    
    // Function to get data from presented modal and change it
    func changeFromLocation(loc: String) {
        self.tempFromLoc = loc
        fromButton.setTitle(tempFromLoc, for: .normal)
    }
    func changeToLocation(loc: String) {
        self.tempToLoc = loc
        toButton.setTitle(tempToLoc, for: .normal)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Adding and if statement with identifier fromOrTo so we can differentiate between the choices
        if segue.identifier == "fromSegue" {
            let destinationVC = segue.destination as? LocationSearchViewController
            destinationVC?.delegate = self
            destinationVC?.chosenLocation = self.tempFromLoc
            destinationVC?.fromOrTo = "from"
        }
        if segue.identifier == "toSegue" {
            let destinationVC = segue.destination as? LocationSearchViewController
            destinationVC?.delegate = self
            destinationVC?.chosenLocation = self.tempToLoc
            destinationVC?.fromOrTo = "to"

        }
    }
    
    
    @IBAction func firstNextButtonTapped(_ sender: UIButton) {
        tableView.deselectRow(at: firstNextButtonCellIndexPath, animated: true)
        
        isSectionOneVisible = false
        isSectionThreeVisible = false
        isSectionTwoVisible = !isSectionTwoVisible
        
        tableView.beginUpdates()
        tableView.endUpdates()
        
    }
    
    
    
    
    // MARK: Search page section 2
    var isSectionTwoVisible: Bool = false {
        didSet {
            datePicker.isHidden = !isSectionTwoVisible
            goingTimePicker.isHidden = !isSectionTwoVisible
            returnTimePicker.isHidden = !isSectionTwoVisible
        }
    }

    let whenCellIndexPath = IndexPath(row: 0, section: 1)
    
    let calenderPickerCellIndexPath = IndexPath(row: 1, section: 1)
    let goingTimePickerCellIndexPath = IndexPath(row: 2, section: 1)
    let returnTimePickerCellIndexPath = IndexPath(row: 3, section: 1)
    let secondNextButtonCellIndexPath = IndexPath(row: 4, section: 1)
    
    // Setting the return time to be after going time constraint
    @IBAction func goingTimeValueChanged(_ sender: Any) {
        returnTimePicker.minimumDate = goingTimePicker.date
    }
    
    
    @IBAction func secondNextButtonTapped(_ sender: Any) {
        tableView.deselectRow(at: secondNextButtonCellIndexPath, animated: true)
        
        isSectionOneVisible = false
        isSectionTwoVisible = false
        isSectionThreeVisible = !isSectionThreeVisible
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    
    
    
    // MARK: Search page section 3
    var tempStepper = 1
    
    var isSectionThreeVisible = false

    let whoCellIndexPath = IndexPath(row: 0, section: 2)
    
    let noOfPassengerCellIndexPath = IndexPath(row: 1, section: 2)
    let submitCellIndexPath = IndexPath(row: 2, section: 2)
    
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        noOfPassengersLabel.text = Int(sender.value).description
        print(Int(sender.value).description)
        tempStepper = Int(sender.value)
    }
    

    @IBAction func submitButtonTapped(_ sender: Any) {
//        print("""
//        The Ryde to be searched for:
//
//        From:     \(tempFromLoc)     ----     To:     \(tempToLoc)
//
//        Date: \(datePicker.date.formatted(date: .complete, time: .omitted))  ---- Day of the week: \(datePicker.date.dayNumberOfWeek()!)
//
//        Going Time: \(goingTimePicker.date.formatted(date: .omitted, time: .shortened))
//        .
//        .
//        Return Time: \(returnTimePicker.date.formatted(date: .omitted, time: .shortened))
//
//        No. Of Passenger: \(tempStepper)
//
//        """)
    
//        print(RideSelectedInformation)
    }
    
    @IBSegueAction func goToRideListPage(_ coder: NSCoder) -> RidesListTableViewController? {
        let RideSelectedInformation = rideFilter(fromLocation: tempFromLoc, toLocation: tempToLoc, date: datePicker.date.formatted(date: .complete, time: .omitted), gointTime: goingTimePicker.date.formatted(date: .omitted, time: .shortened), returnTime: returnTimePicker.date.formatted(date: .omitted, time: .shortened), noOfPassengers: tempStepper)
        
        return RidesListTableViewController(coder: coder, rideF: RideSelectedInformation)
    }
    
}


extension Date {
    func dayNumberOfWeek() -> Int? {
            return Calendar.current.dateComponents([.weekday], from: self).weekday
        }
}
