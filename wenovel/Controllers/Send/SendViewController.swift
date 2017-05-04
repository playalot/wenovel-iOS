//
//  SendViewController.swift
//  wenovel
//
//  Created by Tbxark on 27/04/2017.
//  Copyright © 2017 Tbxark. All rights reserved.
//

import UIKit
import FDFullscreenPopGesture

class SendViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fd_prefersNavigationBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func sendButtonDidClick(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}


// MARK: - Target-Action
extension SendViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        
    }
}
