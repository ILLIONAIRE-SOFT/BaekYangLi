//
//  Station.swift
//  BaekYangLi
//
//  Created by LEOFALCON on 2017. 9. 16..
//  Copyright © 2017년 BaekYangLi. All rights reserved.
//

import Foundation

class Station {
    let name : String
    let station_id : Int
    let lat : Double
    let lng : Double
    var up : [ArriveTime]
    var down : [ArriveTime]
    
    init(name: String, station_id : Int, lat: Double, lng : Double, up: [ArriveTime], down: [ArriveTime]) {
        self.name = name
        self.station_id = station_id
        self.lat = lat
        self.lng = lng
        self.up = up
        self.down = down
    }
}

class ArriveTime {
    var arriveTime : Date
    var destination : String
    var leftTime : Int
    
    init(arriveTime:Date, destination : String, leftTime : Int) {
        self.arriveTime = arriveTime
        self.destination = destination
        self.leftTime = leftTime
    }
}

