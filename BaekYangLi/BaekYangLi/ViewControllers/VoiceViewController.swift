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
    @IBOutlet var destinationLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) { // NSKRecognizer를 초기화 하는데 필요한 NSKRecognizerConfiguration을 생성
        let configuration = NSKRecognizerConfiguration(clientID: clientID)
        configuration?.canQuestionDetected = true
        self.speechRecognizer = NSKRecognizer(configuration: configuration)
        super.init(coder: aDecoder)
        self.speechRecognizer.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        voiceRecognitionButton.addTarget(self, action: #selector(self.tappedStartRecognize), for: .touchDown)
        voiceRecognitionButton.addTarget(self, action: #selector(self.endRecognize), for: .touchUpInside)
        
        initViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Methods
    private func initViews() {
        
        self.voiceRecognitionButton.layer.cornerRadius = 40
    }
    
    func tappedStartRecognize() {
        if self.speechRecognizer.isRunning {
            self.speechRecognizer.stop()
        } else {
            self.statusLabel.text = "녹음 준비중"
            self.speechRecognizer.start(with: self.languages.selectedLanguage)
            UIView.animate(withDuration: 0.5, animations: {
                self.voiceRecognitionButton.backgroundColor = UIColor.blue
            })
        }
    }
    
    func endRecognize() {
        if self.speechRecognizer.isRunning {
            self.speechRecognizer.stop()
            self.statusLabel.text = "녹음 중지"
            UIView.animate(withDuration: 0.5, animations: {
                self.voiceRecognitionButton.backgroundColor = UIColor.red
            })
        }
    }
    

}

extension VoiceViewController: NSKRecognizerDelegate {
    
    public func recognizerDidEnterReady(_ aRecognizer: NSKRecognizer!) {
        self.statusLabel.text = "녹음 중"
    }
    
    public func recognizer(_ aRecognizer: NSKRecognizer!, didReceive aResult: NSKRecognizedResult!) {

        if let result = aResult.results.first as? String {
            self.destinationLabel.text = result
        }
    }
}
