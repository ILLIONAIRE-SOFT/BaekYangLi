//
//  Station.swift
//  BaekYangLi
//
//  Created by LEOFALCON on 2017. 9. 16..
//  Copyright © 2017년 BaekYangLi. All rights reserved.
//

import Foundation
import ObjectMapper

struct Station {
    var lines : [Line]?
    
    init(lines : [Line]) {
        self.lines = lines
    }
}

struct Line {
    var name : String?
    var stationID : Int?
    var latitude : Double?
    var longitude : Double?
    var up : [ArrivalTime]?
    var down : [ArrivalTime]?
    
    init(name : String, stationID : Int, latitude: Double, longitude: Double, up : [ArrivalTime], down : [ArrivalTime]) {
        self.name = name
        self.stationID = stationID
        self.latitude = latitude
        self.longitude = longitude
        self.up = up
        self.down = down
    }
}

struct ArrivalTime {

    var arrivalTime : Date?
    var destination : String?
    var leftTime : Int?

    
    init(arrivalTime : Date, destination : String, leftTime: Int) {
        self.arrivalTime = arrivalTime
        self.destination = destination
        self.leftTime = leftTime
    }
}

