//
//  HomeTableViewCell.swift
//  
//
//  Created by LEOFALCON on 2017. 9. 16..
//
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet var lineNum: UILabel!
    @IBOutlet var upFirstDestination: UILabel!
    @IBOutlet var upFirstLeftTime: UILabel!
    @IBOutlet var upSecondDestination: UILabel!
    @IBOutlet var upSecondLeftTime: UILabel!
    @IBOutlet var downFirstDestination: UILabel!
    @IBOutlet var downFirstLeftTime: UILabel!
    @IBOutlet var downSecondDestination: UILabel!
    @IBOutlet var downSecondLeftTime: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initCell(with station : Station) {
        self.lineNum.text = station.line
        self.lineNum.backgroundColor = getColor(station.line!)
 
        self.upFirstLeftTime.textColor = getColor(station.line!)
        self.upFirstLeftTime.text = getTime(station.up?[0].arriveTime)
        self.upFirstDestination.text = station.up?[0].destinationName
        
        self.upSecondLeftTime.textColor = getColor(station.line!)
        self.upSecondLeftTime.text = getTime(station.up?[1].arriveTime)
        self.upSecondDestination.text = station.up?[1].destinationName
        
        self.downFirstLeftTime.textColor = getColor(station.line!)
        self.downFirstLeftTime.text = getTime(station.down?[0].arriveTime)
        self.downFirstDestination.text =  station.down?[0].destinationName
        
        self.downSecondLeftTime.textColor = getColor(station.line!)
        self.downSecondLeftTime.text = getTime(station.down?[1].arriveTime)
        self.downSecondDestination.text =  station.down?[1].destinationName
    }
    
    func getTime(_ time: String?) -> String {
        guard let time = time else {
            return ""
        }
        
        let components = time.components(separatedBy: ":")
        let result = "\(components[0]):\(components[1])"
        return result
    }
    
    func getColor(_ line: String) -> UIColor {
        switch line {
        case "1":
            return UIColor(red:0.02, green:0.18, blue:0.58, alpha:1.0)
        case "2":
            return UIColor(red:0.06, green:0.65, blue:0.26, alpha:1.0)
        case "3":
            return UIColor(red:0.92, green:0.52, blue:0.02, alpha:1.0)
        case "4":
            return UIColor(red:0.00, green:0.66, blue:0.90, alpha:1.0)
        case "5":
            return UIColor(red:0.66, green:0.31, blue:0.58, alpha:1.0)
        case "6":
            return UIColor(red:0.82, green:0.55, blue:0.10, alpha:1.0)
        case "7":
            return UIColor(red:0.40, green:0.47, blue:0.19, alpha:1.0)
        case "8":
            return UIColor(red:0.91, green:0.31, blue:0.43, alpha:1.0)
        case "9":
            return UIColor(red:0.75, green:0.58, blue:0.11, alpha:1.0)
        case "B":
            return UIColor(red:0.75, green:0.58, blue:0.11, alpha:1.0)
        case "G":
            return UIColor(red:0.20, green:0.78, blue:0.65, alpha:1.0)
        case "I1":
            return UIColor(red:0.39, green:0.59, blue:0.87, alpha:1.0)
        case "I2":
            return UIColor(red:0.99, green:0.60, blue:0.00, alpha:1.0)
        case "SU":
            return UIColor(red:0.98, green:0.73, blue:0.00, alpha:1.0)
        default:
            return UIColor(red:0.92, green:0.52, blue:0.02, alpha:1.0)
        }
    }
}
