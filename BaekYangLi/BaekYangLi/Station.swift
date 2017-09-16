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
    let lines : [Line]
    
    init(lines : [Line]) {
        self.lines = lines
    }
}

struct Line {
    let name : String
    let stationID : Int
    let lat : Double
    let lng : Double
    var up : [ArrivalTime]
    var down : [ArrivalTime]
    
    init(name: String, station_id : Int, lat: Double, lng : Double, up: [ArrivalTime], down: [ArrivalTime]) {
        self.name = name
        self.stationID = station_id
        self.lat = lat
        self.lng = lng
        self.up = up
        self.down = down
    }
}

struct ArrivalTime {
    var arrivalTime : Date
    var destination : String
    var leftTime : Int
    
    init(arrivalTime:Date, destination : String, leftTime : Int) {
        self.arrivalTime = arrivalTime
        self.destination = destination
        self.leftTime = leftTime
    }
}

