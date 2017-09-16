//
//  SplashViewController.swift
//  BaekYangLi
//
//  Created by LEOFALCON on 2017. 9. 16..
//  Copyright © 2017년 BaekYangLi. All rights reserved.
//

import UIKit
import CoreLocation


class SplashViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    var loadLocation : Bool = true
    var currentLocation = CLLocationCoordinate2D()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    fileprivate func presentMainViewController() {
        let appDelegate = UIApplication.shared.delegate! as! AppDelegate
        
        let initialViewController = self.storyboard!.instantiateViewController(withIdentifier: "Main")
        appDelegate.window?.rootViewController = initialViewController
        appDelegate.window?.makeKeyAndVisible()
    }
}

// MARK: - CLLocationManagerDelegate
extension SplashViewController: CLLocationManagerDelegate {
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
                        self.loadLocation = false
                        StationStore.shared.getNearestStations(latitude: self.currentLocation.latitude, longitude: self.currentLocation.longitude) {
                            self.presentMainViewController()
                        }
                    }
                }
            }
        }
    }
}

