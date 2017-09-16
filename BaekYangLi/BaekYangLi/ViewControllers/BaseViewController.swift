//
//  BaseViewController.swift
//  BaekYangLi
//
//  Created by Sohn on 16/09/2017.
//  Copyright © 2017 BaekYangLi. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var overlay: UIView?
    var loadingActivityIndicator: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        stopLoading()
    }
    
    func startLoading() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        overlay = UIView(frame: view.frame)
        overlay?.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        loadingActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
        loadingActivityIndicator?.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        loadingActivityIndicator?.center = CGPoint(x: (overlay?.bounds.width)!/2, y: (overlay?.bounds.height)!/2)
        
        overlay?.addSubview(loadingActivityIndicator!)
        loadingActivityIndicator?.startAnimating()
        
        view.addSubview(overlay!)
    }
    
    func stopLoading() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
        guard
            let overlay = overlay,
            let indicator = loadingActivityIndicator else {
                return
        }
        
        UIView.animate(withDuration: 0.2, animations: {
            overlay.alpha = 0
        }) { (_) in
            indicator.stopAnimating()
            indicator.removeFromSuperview()
            overlay.removeFromSuperview()
        }
    }
    

}
