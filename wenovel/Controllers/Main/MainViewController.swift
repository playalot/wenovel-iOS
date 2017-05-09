//
//  ViewController.swift
//  wenovel
//
//  Created by Tbxark on 26/04/2017.
//  Copyright © 2017 Tbxark. All rights reserved.
//

import UIKit
import RxSwift
import WeNovelKit
import IBAnimatable

class MainViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let actionButton = (refresh: UIButton(image: R.image.icon_refresh()),
                                add: UIButton(image: R.image.icon_add()),
                                user: UIButton(image: R.image.icon_user()))
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var actionToolbar: ActionToolbar! {
        didSet {
            actionToolbar?.setUpViews(margin: (30, 14),
                                      items: [actionButton.refresh, actionButton.add, actionButton.user])
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureWithObservable()
    }

    private func configureWithObservable() {
        actionButton.add.rx.tap
            .subscribe(onNext: {[weak self] _ in
                   self?.performSegue(withIdentifier: R.segue.mainViewController.sendNewNovel.identifier, sender: nil)
                })
            .addDisposableTo(disposeBag)
        
        actionButton.user.rx.tap
            .subscribe(onNext: { _ in
                WNAuthManager.default.logout()
            })
            .addDisposableTo(disposeBag)
        
    }

}

// MARK: - Target-Action
extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ShowDetail", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
    }
}
