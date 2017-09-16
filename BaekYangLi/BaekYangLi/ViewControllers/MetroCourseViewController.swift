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
    @IBOutlet var destinationLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let startStationName = destinationInfo?.statnTnm {
            destinationLabel.text = startStationName
        }
        
        if let message = destinationInfo?.shtTransferMsg {
            messageLabel.text = message
        }
        
    }
    
    @IBAction func tappedComplete(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}
