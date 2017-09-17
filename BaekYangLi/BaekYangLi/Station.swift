//
//  Station.swift
//  BaekYangLi
//
//  Created by LEOFALCON on 2017. 9. 16..
//  Copyright © 2017년 BaekYangLi. All rights reserved.
//

import Foundation
import ObjectMapper

class Station: Mappable {
    var station_id: Int?
    var station_code: String?
    var line: String?
    var name: String?
    var lat: Double?
    var lng: Double?
    var map_station_code: String?
    var distance: Double?
    var up: [StationTimeInfo]?
    var down: [StationTimeInfo]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        station_id <- map["station_id"]
        station_code <- map["station_code"]
        line <- map["line"]
        name <- map["name"]
        lat <- map["lat"]
        lng <- map["lng"]
        map_station_code <- map["map_station_code"]
        distance <- map["D"]
        up <- map["up"]
        down <- map["down"]
        
    }
}

class StationTimeInfo: Mappable {
    
    var arriveTime: String?
    var destinationName: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        arriveTime <- map["ARRIVETIME"]
        destinationName <- map["DESTSTATION_NAME"]
    }
}
