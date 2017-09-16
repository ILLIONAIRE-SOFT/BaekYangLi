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
        let coordinate = CLLocationCoordinate2D(latitude: 37.829014, longitude: 127.603069)
        let location = CLLocation(coordinate: coordinate, altitude: 100)
        
        let toolTipView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        toolTipView.backgroundColor = .white
        let label = UILabel(frame:  CGRect(x: 0, y: 0, width: 100, height: 25))
        label.center = toolTipView.center
        
        label.text = "백양리역"
        toolTipView.addSubview(label)
        
        let image = UIImage(view: toolTipView)
        
        let annotationNode = LocationAnnotationNode(location: location, image: image)
        sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: annotationNode)

        view.addSubview(sceneLocationView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        sceneLocationView.frame = view.bounds
    }

}

extension UIImage {
    convenience init(view: UIView) {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: (image?.cgImage)!)
    }
}

