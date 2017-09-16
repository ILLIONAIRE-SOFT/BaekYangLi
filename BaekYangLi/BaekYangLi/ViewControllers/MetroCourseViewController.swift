//
//  MetroCourseViewController.swift
//  BaekYangLi
//
//  Created by Sohn on 16/09/2017.
//  Copyright © 2017 BaekYangLi. All rights reserved.
//

import UIKit

class MetroCourseViewController: UIViewController {
    
    var destinationInfo: DestinationInfo?
    var stations: [String] = []
    
    @IBOutlet var stationCountLabel: UILabel!
    @IBOutlet var transferLabel: UILabel!
    @IBOutlet var timeToDestination: UILabel!
    @IBOutlet var destinationLabel: UILabel!
    @IBOutlet var startLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        if let destinationName = destinationInfo?.statnTnm,
            let startName = destinationInfo?.statnFnm {
            destinationLabel.text = destinationName
            startLabel.text = startName
        }
        
        if let stationsString = destinationInfo?.shtStatnNm {
            let stations = stationsString.components(separatedBy: ",")
            
            for station in stations {
                let st = station.trimmingCharacters(in: CharacterSet.whitespaces)
                
                if st != "" {
                    self.stations.append(st)
                }
            }
        }
        
        if let timeToDest = destinationInfo?.shtTravelTm {
            self.timeToDestination.text = "\(timeToDest)분"
        }
        
        if let stationCount = destinationInfo?.shtStatnCnt {
            self.stationCountLabel.text = "\(stationCount)개 역"
        }
        
        if let transferCount = destinationInfo?.shtTransferCnt {
            self.transferLabel.text = "\(transferCount)번 환승"
        }
    }
    
    // MARK: IBActions
    @IBAction func tappedDone(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension MetroCourseViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.stations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StationCourseCell") as! StationCourseCell
        
        let lineNumber = destinationInfo?.shtStatnId?[indexPath.row]
        cell.initCell(with: stations[indexPath.row], lineNumber: lineNumber!)
        
        
        return cell
    }
}
