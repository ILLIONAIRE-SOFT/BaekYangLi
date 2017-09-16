//
//  ARViewController.swift
//  BaekYangLi
//
//  Created by LEOFALCON on 2017. 9. 16..
//  Copyright © 2017년 BaekYangLi. All rights reserved.
//

import UIKit
import ARCL
import CoreLocation

class ARViewController: UIViewController {
    var sceneLocationView = SceneLocationView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneLocationView.run()
        view.addSubview(sceneLocationView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        sceneLocationView.frame = view.bounds
    }

}

