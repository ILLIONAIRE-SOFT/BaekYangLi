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
    @IBOutlet var lineNumberLabel: UILabel!
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.selectionStyle = .none
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        pointLabel.clipsToBounds = true
        pointLabel.layer.cornerRadius = 8
        lineNumberLabel.layer.cornerRadius = 8
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func initCell(with destination: String, lineNumber: String) {
        pointLabel.backgroundColor = getColor(lineNumber)
        stationName.text = destination
        lineNumberLabel.text = lineNumber
    }
    
    func getColor(_ line: String) -> UIColor {
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
