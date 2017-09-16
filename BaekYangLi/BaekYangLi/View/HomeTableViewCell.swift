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
        
        self.upFirstLeftTime.text = getTime(station.up?[1].arriveTime)
        self.upFirstDestination.text = station.up?[1].destinationName
        
        self.upSecondLeftTime.text = getTime(station.up?[0].arriveTime)
        self.upSecondDestination.text = station.up?[0].destinationName
        
        self.downFirstLeftTime.text = getTime(station.down?[1].arriveTime)
        self.downFirstDestination.text =  station.down?[1].destinationName
        
        self.downSecondLeftTime.text = getTime(station.down?[0].arriveTime)
        self.downSecondDestination.text =  station.down?[0].destinationName
    }
    
    func getTime(_ time: String?) -> String {
        guard let time = time else {
            return ""
        }
        
        let components = time.components(separatedBy: ":")
        let result = "\(components[0]):\(components[1])"
        return result
    }

}
