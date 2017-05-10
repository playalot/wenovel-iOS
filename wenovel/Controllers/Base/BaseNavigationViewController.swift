//
//  BaseNavigationViewController.swift
//  wenovel
//
//  Created by Tbxark on 10/05/2017.
//  Copyright © 2017 Tbxark. All rights reserved.
//

import UIKit

class BaseNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.shadowImage = UIImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
