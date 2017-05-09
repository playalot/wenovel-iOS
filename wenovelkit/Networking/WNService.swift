//
//  WNService.swift
//  wenovel
//
//  Created by Tbxark on 27/04/2017.
//  Copyright © 2017 Tbxark. All rights reserved.
//

import NetworkService
import Simplicity

public struct WNService {
    public static func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey: Any]) -> Bool {
        return Simplicity.application(app, open: url, options: options)
        
    }
    
    public static func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return Simplicity.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }
}
