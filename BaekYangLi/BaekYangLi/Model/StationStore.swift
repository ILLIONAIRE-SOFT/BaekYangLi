//
//  StationStore.swift
//  BaekYangLi
//
//  Created by Sohn on 16/09/2017.
//  Copyright © 2017 BaekYangLi. All rights reserved.
//

import UIKit

class StationStore {
    
    static let shared = StationStore()
    
    private(set) var nearestStations: [Station] = []
    private(set) var groupedStations: [[Station]] = []
    
    public func getNearestStations(completion: @escaping () -> ()) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        MetroAPI.getNearestStations { (stations) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            self.nearestStations = stations
            self.nearestStations.sort(by: { (first, second) -> Bool in
                return first.distance! < second.distance!
            })
            
//            var stationGroup = [Station]()
//            var previousStationName: String = ""
//            for station in nearestStations {
//                var stationGroup = [Station]()
//                if station.name == previousStationName {
//                    stationGroup.append(station)
//                } else {
//                    groupedStations.append(stationGroup)
//                }
//                
//                
//                previousStationName = station.name
//                
//            }
//            while groupedStations.count < 3 {
//                
//                
//                
//            }
            
            
            for station in self.nearestStations {
                print(station.name!)
            }
        }
    }
}
