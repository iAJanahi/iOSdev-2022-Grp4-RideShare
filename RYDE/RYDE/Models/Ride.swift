//
//  Ride.swift
//  RYDE
//
//  Created by iOSdev on 05/12/2022.
//

import Foundation

struct Ride {
    
    var rideId: String?
    var goingTime: String?
    var returnTime: String?
    var dateFrom: String?
    var dateTo: String?
    var driver: Driver?
    var fromLocation: String?
    var toLocation: String?
    var price: String?
    var daysOfWeek: [Int]?
    var noOfPassengers: Int = 0
    var noOfSeats: String?
    
    
}


struct rideFilter {
    var fromLocation: String
    var toLocation: String
    var date: String
    var gointTime: String
    var returnTime: String
    var noOfPassengers: Int    
}

struct tempRide {
    var fromLoc: String?
    var toLoc: String?
    var goingTime: String?
    var returnTime: String?
}
