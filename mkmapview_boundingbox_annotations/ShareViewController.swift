//
//  ShareViewController.swift
//  teatestr
//
//  Created by AamirR on 5/27/19.
//  Copyright © 2019 AamirR. All rights reserved.
//

import UIKit
import Social

class ShareViewController: SLComposeServiceViewController {
    
    var textViewTintColor: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // hack to disable cursor which appears for a while during presentation animation
        self.textViewTintColor = self.textView.tintColor
        self.textView.tintColor = .clear
    }
    
    override func presentationAnimationDidFinish() {
        super.presentationAnimationDidFinish()
        
        guard let tintColor = self.textViewTintColor else { return }
        
        self.textView.resignFirstResponder()
        self.textView.tintColor = tintColor
        self.textViewTintColor = nil
    }
    
    override func didSelectCancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
