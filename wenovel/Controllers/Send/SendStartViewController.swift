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
    
    struct Cache: SendTempCache {
        func cacheNovel(title: String?, content: String?, id: String) -> Bool {
            return false
        }
        
        func readCache(id: String) -> (title: String?, content: String?)? {
            return nil
        }
    }


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
            userAvatar.layer.cornerRadius = 15
            userAvatar.clipsToBounds = true
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
                                            dependency: SendStartViewController.Cache())
        
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
            .do(onNext: {[weak self] _ in
                self?.dismiss(animated: true, completion: nil)
            })
            .subscribe(onNext: SVProgressHUD.showResult)
            .addDisposableTo(disposeBag)
        
    }
    
    
}


// MARK: - Target-Action
extension SendStartViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        
    }
}
