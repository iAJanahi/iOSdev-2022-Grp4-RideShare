//
//  DriverRideListTableViewCell.swift
//  RYDE
//
//  Created by iOSdev on 07/12/2022.
//

import UIKit

class DriverRideListTableViewCell: UITableViewCell {

    @IBOutlet var fromLabel: UILabel!
    @IBOutlet var toLabel: UILabel!
    @IBOutlet var goingTimeLabel: UILabel!
    @IBOutlet var returnTimeLabel: UILabel!
    @IBOutlet var dateFromLabel: UILabel!
    @IBOutlet var dateToLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var noOfPassengerPerSeatLabel: UILabel!
    
    @IBOutlet var saturdayIcon: UIImageView!
    @IBOutlet var sundayIcon: UIImageView!
    @IBOutlet var mondayIcon: UIImageView!
    @IBOutlet var tuesdayIcon: UIImageView!
    @IBOutlet var wednesdayIcon: UIImageView!
    @IBOutlet var thursdayIcon: UIImageView!
    @IBOutlet var fridayIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(inputRide: Ride) {
        
        if let fromLoc = inputRide.fromLocation, let toLoc = inputRide.toLocation,
           let goingTime = inputRide.goingTime, let returnTime = inputRide.returnTime,
           let dateFrom = inputRide.dateFrom, let dateTo = inputRide.dateTo,
           let days = inputRide.daysOfWeek,
            let price = inputRide.price, let seats = inputRide.noOfSeats
        {
            fromLabel.text = "\(fromLoc)"
            toLabel.text = "\(toLoc)"
            goingTimeLabel.text = "\(goingTime)"
            returnTimeLabel.text = "\(returnTime)"
            dateFromLabel.text = "\(dateFrom)"
            dateToLabel.text = "\(dateTo)"
            priceLabel.text = "\(price) BD"
            noOfPassengerPerSeatLabel.text = "\(inputRide.noOfPassengers)/\(seats)"

//            print(days)
            for i in 0...days.count-1 {
                if days[i] == 1 {
                    sundayIcon.image = UIImage(systemName: "s.circle.fill")
                }
                else if days[i] == 2 {
                    mondayIcon.image = UIImage(systemName: "m.circle.fill")
                }
                else if days[i] == 3 {
                    tuesdayIcon.image = UIImage(systemName: "t.circle.fill")
                }
                else if days[i] == 4 {
                    wednesdayIcon.image = UIImage(systemName: "w.circle.fill")
                }
                else if days[i] == 5 {
                    thursdayIcon.image = UIImage(systemName: "t.circle.fill")
                }
                else if days[i] == 6 {
                    fridayIcon.image = UIImage(systemName: "f.circle.fill")
                }
                else {
                    saturdayIcon.image = UIImage(systemName: "s.circle.fill")
                }
            }
        }
        else {
            print("Nil was found when configuring driver cell...")
        }
    }

}
