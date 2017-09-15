//
//  VoiceViewController.swift
//  BaekYangLi
//
//  Created by Sohn on 16/09/2017.
//  Copyright © 2017 BaekYangLi. All rights reserved.
//

import UIKit
import NaverSpeech

class VoiceViewController: UIViewController {
    
    let clientID = "yfE2GTNiX2oucOT8WPIh"
    
    fileprivate let speechRecognizer: NSKRecognizer
    fileprivate let languages = Languages()
    
    @IBOutlet var voiceRecognitionButton: UIButton!
    
    required init?(coder aDecoder: NSCoder) { // NSKRecognizer를 초기화 하는데 필요한 NSKRecognizerConfiguration을 생성
        let configuration = NSKRecognizerConfiguration(clientID: clientID)
        configuration?.canQuestionDetected = true
        self.speechRecognizer = NSKRecognizer(configuration: configuration)
        super.init(coder: aDecoder)
        self.speechRecognizer.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let configuration = NSKRecognizerConfiguration(clientID: ClientID)
//        configuration?.canQuestionDetected = true
//        self.speechRecognizer = NSKRecognizer(configuration: configuration)
//        self.speechRecognizer.delegate = self
        
        voiceRecognitionButton.addTarget(self, action: #selector(self.tappedStartRecognize), for: .touchDown)
        voiceRecognitionButton.addTarget(self, action: #selector(self.endRecognize), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tappedStartRecognize() {
        if self.speechRecognizer.isRunning {
            self.speechRecognizer.stop()
        } else {
            self.speechRecognizer.start(with: self.languages.selectedLanguage)
            print("Speech Recognizing Start")
//            self.recognitionButton.isEnabled = false
//            self.statusLabel.text = "Connecting......"
        }
        print("Start Recognize")
    }
    
    func endRecognize() {
        if self.speechRecognizer.isRunning {
            self.speechRecognizer.stop()
        }
        print("End Recognize")
    }
    

}

extension VoiceViewController: NSKRecognizerDelegate {
    
    public func recognizerDidEnterReady(_ aRecognizer: NSKRecognizer!) {
        print("Event occurred: Ready")
//        self.statusLabel.text = "Connected"
//        self.recognitionResultLabel.text = "Recognizing......"
//        self.setRecognitionButtonTitle(withText: "Stop", color: .red)
//        self.recognitionButton.isEnabled = true
    }
    
//    public func recognizer(_ aRecognizer: NSKRecognizer!, didReceivePartialResult aResult: String!) {
//        if let result = aResult {
//            print(result)
//        }
//    }
    
    public func recognizer(_ aRecognizer: NSKRecognizer!, didReceive aResult: NSKRecognizedResult!) {
        print("Final result: \(aResult)")
        if let result = aResult.results.first as? String {
            print("Result: " + result)
        }
    }
}
