//
//  HomeTableViewHeaderCell.swift
//  BaekYangLi
//
//  Created by LEOFALCON on 2017. 9. 16..
//  Copyright © 2017년 BaekYangLi. All rights reserved.
//

import Foundation
import UIKit

class HomeTableViewHeaderCell: UITableViewCell {
    
    @IBOutlet var distance: UILabel!
    @IBOutlet var stationName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func initCell(with station : Station) {
        self.stationName.text = station.name
        if let distance = station.distance {
            self.distance.text = "\(distance)m"
        }
    }
    
}
