//
//  SendNodeViewController.swift
//  wenovel
//
//  Created by Tbxark on 09/05/2017.
//  Copyright © 2017 Tbxark. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import WeNovelKit
import SVProgressHUD

class SendNodeViewController: UIViewController {

    var initData: (WNNovelNode)?
    private var viewModel: SendNodeViewModel!
    private var disposeBag: DisposeBag!
    
    @IBOutlet weak var userAvatar: UIImageView! {
        didSet {
            userAvatar.addCorner(radius: 13, sourceSize: CGSize(width: 30, height: 30), color: UIColor.white)
        }
    }
    @IBOutlet weak var cancleButton: UIButton!
    @IBOutlet weak var commitButton: UIButton!
    @IBOutlet weak var contentText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureWithObservable()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func configureWithObservable() {
        
        disposeBag = nil
        disposeBag = DisposeBag()
        
        cancleButton.rx.tap
            .subscribe(onNext: {[weak self] _ in
                self?.dismiss(animated: true, completion: nil)
            })
            .addDisposableTo(disposeBag)
        
        let send = commitButton.rx.tap.asObservable().do(onNext: { SVProgressHUD.show() })

        viewModel = SendNodeViewModel(input: (id: initData?.id ?? IDNOTFOUND,
                                               content: contentText.rx.text.orEmpty.asObservable(),
                                               saveCache: Observable<Void>.never(),
                                               readCache: Observable<Void>.never(),
                                               send: send),
                                       dependency: NovelSendTempCacheImp())
        
        
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
