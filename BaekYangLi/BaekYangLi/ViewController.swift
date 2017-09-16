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
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(StationStore.shared.groupedStations)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "modalARKitVC" {
            let ARKitVC = segue.destination as! ARViewController
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StationStore.shared.groupedStations[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let station = StationStore.shared.groupedStations[indexPath.section][indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell") as! HomeTableViewCell
        cell.initCell(with: station)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let station = StationStore.shared.groupedStations[section][0]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewHeaderCell") as! HomeTableViewHeaderCell
        
        cell.initCell(with: station)
        cell.backgroundColor = .red
        
        let ARButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        ARButton.center = cell.center
        ARButton.tag = section
        ARButton.backgroundColor = .black
        ARButton.addTarget(self, action: #selector(sendARViewController(_:)), for: .touchUpInside)
        cell.addSubview(ARButton)
        
        return cell
    }
    
    func sendARViewController(_ sender: UIButton)  {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ARViewController = storyboard.instantiateViewController(withIdentifier: "ARViewController") as! ARViewController
        
        var coordinate = CLLocationCoordinate2D()
        
        switch sender.tag {
        case 0:
            coordinate.latitude = StationStore.shared.groupedStations[0][0].lat!
            coordinate.longitude = StationStore.shared.groupedStations[0][0].lng!
            ARViewController.coordinate = coordinate
        case 1:
            coordinate.latitude = StationStore.shared.groupedStations[1][0].lat!
            coordinate.longitude = StationStore.shared.groupedStations[1][0].lng!
            ARViewController.coordinate = coordinate
        case 2:
            coordinate.latitude = StationStore.shared.groupedStations[2][0].lat!
            coordinate.longitude = StationStore.shared.groupedStations[2][0].lng!
            ARViewController.coordinate = coordinate
        default:
            break
        }
        present(ARViewController, animated: true, completion: nil)
    }

}


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
