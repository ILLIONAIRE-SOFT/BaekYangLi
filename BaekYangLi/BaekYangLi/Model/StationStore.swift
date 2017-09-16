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
            
            var tempStations = [Station]()
            var tempName = ""
            for station in self.nearestStations {
                if tempName == "" || tempName == station.name {
                    tempStations.append(station)
                    if let name = station.name {
                        tempName = name
                    }
                } else {
                    self.groupedStations.append(tempStations)
                    tempStations.removeAll()
                    tempStations.append(station)
                    if let name = station.name {
                        tempName = name
                    }
                }
            }
            self.groupedStations.append(tempStations)
            completion()
        }
    }
}
