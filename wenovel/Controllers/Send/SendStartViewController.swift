//
//  SendViewController.swift
//  wenovel
//
//  Created by Tbxark on 27/04/2017.
//  Copyright © 2017 Tbxark. All rights reserved.
//

import UIKit
import RxSwift
import SVProgressHUD
import IQKeyboardManagerSwift
import FDFullscreenPopGesture

class SendStartViewController: UIViewController {
    
    
    private var disposeBag: DisposeBag!
    private var viewModel: SendStartViewModel!
    @IBOutlet weak var cancleButton: UIButton! {
        didSet {
            cancleButton.imageView?.contentMode = .scaleAspectFit
        }
    }
    @IBOutlet weak var commitButton: UIButton! {
        didSet {
            commitButton.imageView?.contentMode = .scaleAspectFit
        }
    }
    @IBOutlet weak var userAvatar: UIImageView! {
        didSet {
            userAvatar.addCorner(radius: 13, sourceSize: CGSize(width: 30, height: 30), color: UIColor.white)
        }
    }
    @IBOutlet weak var titleTextView: UITextView! {
        didSet {
            titleTextView.textContainerInset = UIEdgeInsets.zero
        }
    }
    @IBOutlet weak var contentTextView: UITextView! {
        didSet {
            contentTextView.textContainerInset = UIEdgeInsets.zero
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureWithObservable()
        fd_prefersNavigationBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func configureWithObservable() {
        disposeBag = nil
        disposeBag = DisposeBag()
        
        
        let send = commitButton.rx.tap.asObservable().do(onNext: { SVProgressHUD.show() })
        
        viewModel = SendStartViewModel(input: (title: titleTextView.rx.text.orEmpty.asObservable(),
                                                    content: contentTextView.rx.text.orEmpty.asObservable(),
                                                    saveCache: Observable<Void>.never(),
                                                    readCache: Observable<Void>.never(),
                                                    send: send),
                                            dependency: NovelSendTempCacheImp())
        
        Signal.keyboardHeight()
            .subscribeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: {[weak self] (height: CGFloat) in
                guard let `self` = self else { return }
                self.contentTextView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: height, right: 0)
            })
            .addDisposableTo(disposeBag)
        
        
        cancleButton.rx.tap
            .subscribe(onNext: {[weak self] _ in
                self?.dismiss(animated: true, completion: nil)
            })
            .addDisposableTo(disposeBag)
        
        viewModel.sendNovel
            .subscribe(onNext: {[weak self] res in
                SVProgressHUD.showResult(res)
                if res.isSuccess() {
                     self?.dismiss(animated: true, completion: nil)
                }
            })
            .addDisposableTo(disposeBag)
        
    }
    
    
}


// MARK: - Target-Action
extension SendStartViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        
    }
}
