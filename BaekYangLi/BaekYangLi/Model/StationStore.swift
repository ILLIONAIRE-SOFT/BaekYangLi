//
//  StationStore.swift
//  BaekYangLi
//
//  Created by Sohn on 16/09/2017.
//  Copyright © 2017 BaekYangLi. All rights reserved.
//

import Foundation

class StationStore {
    
    static let shared = StationStore()
    
    private(set) var nearestStations: [Station] = []
    
    public func getNearestStations(completion: @escaping () -> ()) {
        MetroAPI.getNearestStations { (stations) in
            self.nearestStations = stations
            print(self.nearestStations)
            print(self.nearestStations[0].up?[0].destinationName)
        }
    }
}
