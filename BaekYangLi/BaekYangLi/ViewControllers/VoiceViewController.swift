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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

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
            print(result)
            var removeWithoutWhiteSpace = result.trimmingCharacters(in: CharacterSet.whitespaces)
            removeWithoutWhiteSpace = removeWithoutWhiteSpace.replacingOccurrences(of: " ", with: "")
            
            self.destinationLabel.text = removeWithoutWhiteSpace
            
            startLoading()
            MetroAPI.getDestinationInfos(destination: removeWithoutWhiteSpace, completion: { (destinationInfos) in
                self.stopLoading()
                
                let tabTwoSB = UIStoryboard(name: "Tab2", bundle: nil)
                let metroCourseVC = tabTwoSB.instantiateViewController(withIdentifier: "MetroCourseViewController") as! MetroCourseViewController
                
                if destinationInfos.count != 0 {
                    metroCourseVC.destinationInfo = destinationInfos[0]
                    self.present(metroCourseVC, animated: true, completion: nil)
                } else {
                    let alertController = UIAlertController(title: nil, message: "역이 존재하지 않습니다.", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Done", style: .default, handler: nil)
                    alertController.addAction(action)
                    self.present(alertController, animated: true, completion: nil)
                }
            })
        }
    }
}
