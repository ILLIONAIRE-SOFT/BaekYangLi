//
//  SplashViewController.swift
//  BaekYangLi
//
//  Created by LEOFALCON on 2017. 9. 16..
//  Copyright © 2017년 BaekYangLi. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        StationStore.shared.getNearestStations {
            self.presentMainViewController()
        }
    }
    
    private func presentMainViewController() {
        let appDelegate = UIApplication.shared.delegate! as! AppDelegate
        
        let initialViewController = self.storyboard!.instantiateViewController(withIdentifier: "Main")
        appDelegate.window?.rootViewController = initialViewController
        appDelegate.window?.makeKeyAndVisible()
    }
}
