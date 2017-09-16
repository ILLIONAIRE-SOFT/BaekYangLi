//
//  StationCourseCell.swift
//  BaekYangLi
//
//  Created by Sohn on 16/09/2017.
//  Copyright © 2017 BaekYangLi. All rights reserved.
//

import UIKit

class StationCourseCell: UITableViewCell {

    @IBOutlet var pointLabel: UILabel!
    @IBOutlet var stationName: UILabel!
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func initCell(with destination: String) {
        pointLabel.layer.cornerRadius = 12
        stationName.text = destination
    }

}
