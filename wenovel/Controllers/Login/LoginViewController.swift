//
//  LoginViewController.swift
//  wenovel
//
//  Created by Tbxark on 08/05/2017.
//  Copyright © 2017 Tbxark. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import WeNovelKit
import SVProgressHUD

class LoginViewController: UIViewController {

    @IBOutlet weak var facebookBtn: UIButton!
    @IBOutlet weak var weiboBtn: UIButton!
    private var viewModel: OAuthLoginViewModel!
    private var disposeBag: DisposeBag!

    private func configureWithObservable() {
        disposeBag = nil
        disposeBag = DisposeBag()

        let facebookAuth = facebookBtn
            .rx.tap
            .asObservable()
            .throttle(0.5, scheduler: MainScheduler.asyncInstance)
            .mapToValue(WNOAthType.facebook)
        
        viewModel = OAuthLoginViewModel(input: facebookAuth)
        viewModel.signedIn
            .subscribe(onNext: SVProgressHUD.showResult)
            .addDisposableTo(disposeBag)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureWithObservable()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        print("LoginViewController is deinit")
    }
   
}
