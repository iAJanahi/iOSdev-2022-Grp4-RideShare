//
//  RidesListTableViewCell.swift
//  RYDE
//
//  Created by iOSdev on 06/12/2022.
//

import UIKit

class RidesListTableViewCell: UITableViewCell {

    @IBOutlet var driverNameLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    
    @IBOutlet var goingTimeLabel: UILabel!
    @IBOutlet var returnTimeLabel: UILabel!
    
    @IBOutlet var priceLabel: UILabel!
        
    @IBOutlet var saturdayIcon: UIImageView!
    @IBOutlet var sundayIcon: UIImageView!
    @IBOutlet var mondayIcon: UIImageView!
    @IBOutlet var tuesdayIcon: UIImageView!
    @IBOutlet var wednesdayIcon: UIImageView!
    @IBOutlet var thursdayIcon: UIImageView!
    @IBOutlet var fridayIcon: UIImageView!
    
    @IBOutlet var passengersLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configureCell(ride: Ride) {
        

        if let gTime = ride.goingTime,
           let rTime = ride.returnTime,
           let price = ride.price, 
           let seatNo = ride.noOfSeats,
           let driverName = ride.driverName
//           let driverGender = ride.driverGender
        {
            goingTimeLabel.text = "\(gTime)"
            returnTimeLabel.text = "\(rTime)"
            priceLabel.text = "\(price) BD"
            passengersLabel.text = "\(ride.noOfPassengers)/\(seatNo)"
            driverNameLabel.text = "\(driverName)"
        }
        
        
        if let days = ride.daysOfWeek {
            //            print("DoW: \(days)")
            for i in 0...days.count-1 {
                //                print(days[i])
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

       
    }
    
    
    
}
