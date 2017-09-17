//
//  ViewController.swift
//  BaekYangLi
//
//  Created by LEOFALCON on 2017. 9. 15..
//  Copyright © 2017년 BaekYangLi. All rights reserved.
//

import UIKit
import CoreLocation
import NaverSpeech

class HomeViewController: BaseViewController {

    let clientID = "yfE2GTNiX2oucOT8WPIh"
    
    fileprivate let speechRecognizer: NSKRecognizer
    fileprivate let languages = Languages()
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var voiceRecognizeButton: UIButton!
    
    let locationManager = CLLocationManager()
    var loadLocation : Bool = true
    var currentLocation = CLLocationCoordinate2D()
    
    required init?(coder aDecoder: NSCoder) {
        let configuration = NSKRecognizerConfiguration(clientID: clientID)
        configuration?.canQuestionDetected = true
        self.speechRecognizer = NSKRecognizer(configuration: configuration)
        super.init(coder: aDecoder)
        self.speechRecognizer.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        initViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(StationStore.shared.groupedStations)
    }
    
    private func initViews() {
        
        voiceRecognizeButton.addTarget(self, action: #selector(self.tappedStartRecognize), for: .touchDown)
        voiceRecognizeButton.addTarget(self, action: #selector(self.endRecognize), for: .touchUpInside)
    }
    
    func tappedStartRecognize() {
        if self.speechRecognizer.isRunning {
            self.speechRecognizer.stop()
        } else {
            self.speechRecognizer.start(with: self.languages.selectedLanguage)
            UIView.animate(withDuration: 0.5, animations: {
                self.voiceRecognizeButton.backgroundColor = UIColor.blue
            })
        }
    }
    
    func endRecognize() {
        if self.speechRecognizer.isRunning {
            self.speechRecognizer.stop()
            UIView.animate(withDuration: 0.5, animations: {
                self.voiceRecognizeButton.backgroundColor = UIColor.red
            })
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StationStore.shared.groupedStations[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let station = StationStore.shared.groupedStations[indexPath.section][indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell") as! HomeTableViewCell
        cell.initCell(with: station)
        cell.layer.cornerRadius = 10
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let station = StationStore.shared.groupedStations[section][0]
        
        let cell = HomeTableViewHeaderCell(style: .default, reuseIdentifier: "HomeTableViewHeaderCell", station: station)
        
        return cell
    }

}


// MARK: - CLLocationManagerDelegate
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


// MARK: - NSKRecognizerDelegate
extension HomeViewController: NSKRecognizerDelegate {
    
    public func recognizerDidEnterReady(_ aRecognizer: NSKRecognizer!) {
    }
    
    public func recognizer(_ aRecognizer: NSKRecognizer!, didReceive aResult: NSKRecognizedResult!) {
        
        if let result = aResult.results.first as? String {
            var removeWithoutWhiteSpace = result.trimmingCharacters(in: CharacterSet.whitespaces)
            removeWithoutWhiteSpace = removeWithoutWhiteSpace.replacingOccurrences(of: " ", with: "")
            
            startLoading()
            MetroAPI.getDestinationInfos(destination: removeWithoutWhiteSpace, completion: { (destinationInfos) in
                self.stopLoading()
                
                let tabTwoSB = UIStoryboard(name: "Tab2", bundle: nil)
                let metroCourseVC = tabTwoSB.instantiateViewController(withIdentifier: "MetroCourseViewController") as! MetroCourseViewController
                
                if destinationInfos.count != 0 {
                    metroCourseVC.destinationInfo = destinationInfos[0]
                    self.present(metroCourseVC, animated: true, completion: nil)
                } else {
                    let alertController = UIAlertController(title: nil, message: "역이 존재하지 않습니다.", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Done", style: .default, handler: nil)
                    alertController.addAction(action)
                    self.present(alertController, animated: true, completion: nil)
                }
            })
        }
    }
}

