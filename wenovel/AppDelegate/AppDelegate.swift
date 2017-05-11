//
//  AppDelegate.swift
//  wenovel
//
//  Created by Tbxark on 26/04/2017.
//  Copyright © 2017 Tbxark. All rights reserved.
//

import UIKit
import RxSwift
import WeNovelKit
import IQKeyboardManagerSwift
import SVProgressHUD

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    fileprivate let disposeBag = DisposeBag()
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        setApperance()
        setUpApplication()
        window = UIWindow(frame: UIScreen.main.bounds)
        setUpRootViewContrller()
        setUpDependency()
        window?.makeKeyAndVisible()
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return WNService.application(_:app, open: url, options: options)
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return WNService.application(_: application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }

}


extension AppDelegate {
    fileprivate func setUpRootViewContrller() {
        window?.rootViewController = WNAuthManager.default.readCache() ? R.storyboard.mainViewController().instantiateInitialViewController() : R.storyboard.loginViewController().instantiateInitialViewController()
        WNAuthManager.default.authChangeObservable.subscribe(onNext: {[weak self] (isAuth) in
            guard let `self` = self else { return }
            guard let w = self.window else { return }
            let vc = isAuth ? R.storyboard.mainViewController().instantiateInitialViewController() : R.storyboard.loginViewController().instantiateInitialViewController()
            UIView.transition(with: w, duration: 1, options: .transitionCrossDissolve, animations: {
                w.rootViewController = vc
            }, completion: nil)           
        })
        .addDisposableTo(disposeBag)
    }
    fileprivate func setUpApplication() {
        WNNetworking.default.commonErrorHandle = { (_, error) in
            
        }
        
        WNNetworking.default.noAuthErrorHandle = { (_, error) in
            
        }
    }
    
    
    fileprivate func setUpDependency() {
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().toolbarDoneBarButtonItemImage = R.image.icon_arrow_down()
        IQKeyboardManager.sharedManager().previousNextDisplayMode = .alwaysHide
        IQKeyboardManager.sharedManager().disabledDistanceHandlingClasses = [SendStartViewController.self, SendNodeViewController.self]
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        UINavigationBar.appearance().backIndicatorImage = R.image.icon_arrow_left()
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = R.image.icon_arrow_left()
        UINavigationBar.appearance().tintColor = UIColor.darkGray
        UITableViewCell.appearance().selectionStyle = .none
        
        SVProgressHUD.setMinimumDismissTimeInterval(1)
    }
    
    
    fileprivate func setApperance() {
        UIToolbar.appearance().tintColor = UIColor.darkGray
        
    }
    


}


