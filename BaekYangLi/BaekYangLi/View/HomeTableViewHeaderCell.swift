//
//  HomeTableViewHeaderCell.swift
//  BaekYangLi
//
//  Created by LEOFALCON on 2017. 9. 16..
//  Copyright © 2017년 BaekYangLi. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class HomeTableViewHeaderCell: UITableViewCell {
    
//    @IBOutlet var distance: UILabel!
    
    init(style: UITableViewCellStyle, reuseIdentifier: String?, station: Station) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
//        self.backgroundColor = UIColor.clear
        
        self.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 246/255, alpha: 1.0)
        self.initCell(with: station)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    private func initCell(with station: Station) {
        let stationLabel = UILabel()
        stationLabel.text = station.name!
        stationLabel.font = UIFont.systemFont(ofSize: 32, weight: UIFontWeightUltraLight)
        
        self.addSubview(stationLabel)
        
        stationLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(24)
//            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        let bottomSeparator = UILabel()
        bottomSeparator.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        
        self.addSubview(bottomSeparator)
        
        bottomSeparator.snp.makeConstraints { (make) in
            make.bottom.equalTo(self)
            make.height.equalTo(0.5)
            make.left.equalTo(self)
            make.right.equalTo(self)
        }
        
        let topSeparator = UILabel()
        topSeparator.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        
        self.addSubview(topSeparator)
        
        topSeparator.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.height.equalTo(0.5)
            make.left.equalTo(self)
            make.right.equalTo(self)
        }
    }
    
}
