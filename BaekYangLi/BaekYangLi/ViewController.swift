//
//  ViewController.swift
//  BaekYangLi
//
//  Created by LEOFALCON on 2017. 9. 15..
//  Copyright © 2017년 BaekYangLi. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    let locationManager = CLLocationManager()
    var loadLocation : Bool = true
    var currentLocation = CLLocationCoordinate2D()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
//        MetroStore.fetchStations()
//        MetroAPI.getNearestStations { (stations) in
//            
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        StationStore.shared.getNearestStations { 
            
        }
    }
        
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if loadLocation {
            CLGeocoder().reverseGeocodeLocation(manager.location!) { (placemarks, error) in
                if (error != nil) {
                    return
                }
                if (placemarks?.count)! > 0 {
                    let placemark = placemarks?[0]
                    if let coordinate = placemark?.location?.coordinate {
                        self.currentLocation = coordinate
//                        print(coordinate)
                    }
                }
            }
        }
    }
}
