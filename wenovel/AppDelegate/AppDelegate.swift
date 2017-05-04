//
//  AppDelegate.swift
//  wenovel
//
//  Created by Tbxark on 26/04/2017.
//  Copyright © 2017 Tbxark. All rights reserved.
//

import UIKit
import WeNovelKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setUpApplication()
        return true
    }

}


extension AppDelegate {
    func setUpApplication() {
        WeNovelNetWorking.default.commonErrorHandle = { (_, error) in
        
        }
        
        WeNovelNetWorking.default.noAuthErrorHandle = { (_, error) in
        
        }
    }
}

