//
//  HistoryTableViewCell.swift
//  RYDE
//
//  Created by iOSdev on 13/12/2022.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {


    
    @IBOutlet var driverNameLabel: UILabel!
    @IBOutlet var pickUpTimeLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func update(viewRides: Ride) {
        driverNameLabel.text = viewRides.driverName
        dateLabel.text = viewRides.dateFrom
        pickUpTimeLabel.text = viewRides.goingTime
    }
}
