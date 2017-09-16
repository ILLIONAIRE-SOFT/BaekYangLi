//
//  ViewController.swift
//  BaekYangLi
//
//  Created by LEOFALCON on 2017. 9. 15..
//  Copyright © 2017년 BaekYangLi. All rights reserved.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var loadLocation : Bool = true
    var currentLocation = CLLocationCoordinate2D()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.tableView.delegate = self
//        self.tableView.dataSource = self
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        StationStore.shared.getNearestStations { 
            
        }
    }
}

//extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 3
//    }
//    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 0
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
////    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////        ret
////    }
//
//}
extension HomeViewController: CLLocationManagerDelegate {
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
                    }
                }
            }
        }
    }
}
