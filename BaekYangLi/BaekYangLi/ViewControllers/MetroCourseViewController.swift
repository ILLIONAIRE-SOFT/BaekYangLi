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
    
    @IBOutlet var point1: UILabel!
    @IBOutlet var point2: UILabel!
    @IBOutlet var point3: UILabel!
    @IBOutlet var destPoint: UILabel!
    @IBOutlet var startPoint: UILabel!
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
        
        var lines = [String]()

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
        
        guard var sts = destinationInfo?.shtStatnId else {
            return
        }
        
        for (i, l) in sts.enumerated() {
            if lines.count == 0 {
                lines.append(l)
            }
            if lines[lines.count-1] != l  && l != "" {
                lines.append(l)
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
            switch transferCount {
                case "0":
                    startPoint.backgroundColor = getColor(lines[0])
                    destPoint.backgroundColor = getColor(lines[0])
                    break;
                case "1":
                    startPoint.backgroundColor = getColor(lines[0])
                    point1.backgroundColor = UIColor(red:0, green:0, blue:0, alpha:0)
                    point2.backgroundColor = getColor(lines[1]);
                    point3.backgroundColor = UIColor(red:0, green:0, blue:0, alpha:0)
                    destPoint.backgroundColor = getColor(lines[1])
                    break;
                case "2":
                    startPoint.backgroundColor = getColor(lines[0])
                    point1.backgroundColor = getColor(lines[1])
                    point2.backgroundColor = UIColor(red:0, green:0, blue:0, alpha:0)
                    point3.backgroundColor = getColor(lines[2])
                    destPoint.backgroundColor = getColor(lines[2])
                    break;
                case "3":
                    startPoint.backgroundColor = getColor(lines[0])
                    point1.backgroundColor = getColor(lines[1])
                    point2.backgroundColor = getColor(lines[2])
                    point3.backgroundColor = getColor(lines[3])
                    destPoint.backgroundColor = getColor(lines[3])
                    break;
                default:
                    startPoint.backgroundColor = getColor(lines[0])
                    point1.backgroundColor = getColor(lines[1])
                    point2.backgroundColor = getColor(lines[2])
                    point3.backgroundColor = getColor(lines[3])
                    destPoint.backgroundColor = getColor(lines[lines.count-1])
                    break;
            }
        }
        
    }
    
    // MARK: IBActions
    @IBAction func tappedDone(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func getColor(_ line: String) -> UIColor {
        print(line)
        switch line {
        case "1호선":
            return UIColor(red:0.02, green:0.18, blue:0.58, alpha:1.0)
        case "2호선":
            return UIColor(red:0.06, green:0.65, blue:0.26, alpha:1.0)
        case "3호선":
            return UIColor(red:0.92, green:0.52, blue:0.02, alpha:1.0)
        case "4호선":
            return UIColor(red:0.00, green:0.66, blue:0.90, alpha:1.0)
        case "5호선":
            return UIColor(red:0.66, green:0.31, blue:0.58, alpha:1.0)
        case "6호선":
            return UIColor(red:0.82, green:0.55, blue:0.10, alpha:1.0)
        case "7호선":
            return UIColor(red:0.40, green:0.47, blue:0.19, alpha:1.0)
        case "8호선":
            return UIColor(red:0.91, green:0.31, blue:0.43, alpha:1.0)
        case "9호선":
            return UIColor(red:0.75, green:0.58, blue:0.11, alpha:1.0)
        case "분당선":
            return UIColor(red:0.75, green:0.58, blue:0.11, alpha:1.0)
        case "경춘선":
            return UIColor(red:0.20, green:0.78, blue:0.65, alpha:1.0)
        case "인천1호선":
            return UIColor(red:0.39, green:0.59, blue:0.87, alpha:1.0)
        case "인천2호선":
            return UIColor(red:0.99, green:0.60, blue:0.00, alpha:1.0)
        case "수인선":
            return UIColor(red:0.98, green:0.73, blue:0.00, alpha:1.0)
        default:
            return UIColor(red:0.92, green:0.52, blue:0.02, alpha:1.0)
        }
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
