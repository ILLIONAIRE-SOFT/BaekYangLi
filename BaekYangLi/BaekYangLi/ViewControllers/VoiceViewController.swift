//
//  VoiceViewController.swift
//  BaekYangLi
//
//  Created by Sohn on 16/09/2017.
//  Copyright © 2017 BaekYangLi. All rights reserved.
//

import UIKit

class VoiceViewController: UIViewController {

    @IBOutlet var voiceRecognitionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        voiceRecognitionButton.addTarget(self, action: #selector(self.tappedStartRecognize), for: .touchDown)
        voiceRecognitionButton.addTarget(self, action: #selector(self.endRecognize), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tappedStartRecognize() {
        print("Start Recognize")
    }
    
    func endRecognize() {
        print("End Recognize")
    }
    

}
