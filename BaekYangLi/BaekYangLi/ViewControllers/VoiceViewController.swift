//
//  VoiceViewController.swift
//  BaekYangLi
//
//  Created by Sohn on 16/09/2017.
//  Copyright © 2017 BaekYangLi. All rights reserved.
//

import UIKit
import NaverSpeech
import NVActivityIndicatorView

class VoiceViewController: BaseViewController {
    
    let clientID = "yfE2GTNiX2oucOT8WPIh"
    
    fileprivate let speechRecognizer: NSKRecognizer
    fileprivate let languages = Languages()
    
    @IBOutlet var voiceRecognitionButton: UIButton!
    @IBOutlet var destinationLabel: UILabel!
    @IBOutlet var activityIndicator: NVActivityIndicatorView!
    
    required init?(coder aDecoder: NSCoder) {
        let configuration = NSKRecognizerConfiguration(clientID: clientID)
        configuration?.canQuestionDetected = true
        self.speechRecognizer = NSKRecognizer(configuration: configuration)
        super.init(coder: aDecoder)
        self.speechRecognizer.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        initViews()
    }
    
    // MARK: Methods
    private func initViews() {
        
        voiceRecognitionButton.addTarget(self, action: #selector(self.tappedStartRecognize), for: .touchDown)
        voiceRecognitionButton.addTarget(self, action: #selector(self.endRecognize), for: .touchUpInside)
        
        voiceRecognitionButton.layer.cornerRadius = 40
    }
    
    func tappedStartRecognize() {
        if self.speechRecognizer.isRunning {
            self.speechRecognizer.stop()
        } else {
            self.speechRecognizer.start(with: self.languages.selectedLanguage)
            UIView.animate(withDuration: 0.5, animations: {
                self.voiceRecognitionButton.backgroundColor = UIColor.blue
            })
        }
    }
    
    func endRecognize() {
        if self.speechRecognizer.isRunning {
            self.speechRecognizer.stop()
            self.activityIndicator.stopAnimating()
            UIView.animate(withDuration: 0.5, animations: {
                self.voiceRecognitionButton.backgroundColor = UIColor.red
            })
        }
    }

}

// MARK: - NSKRecognizerDelegate
extension VoiceViewController: NSKRecognizerDelegate {
    
    public func recognizerDidEnterReady(_ aRecognizer: NSKRecognizer!) {
        self.activityIndicator.startAnimating()
    }
    
    public func recognizer(_ aRecognizer: NSKRecognizer!, didReceive aResult: NSKRecognizedResult!) {

        if let result = aResult.results.first as? String {
            self.destinationLabel.text = result
            
            startLoading()
            MetroAPI.getDestinationInfo(completion: { 
                self.stopLoading()
                // present detail view with information
            })
        }
    }
}
