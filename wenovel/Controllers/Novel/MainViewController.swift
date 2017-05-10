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

class MainViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let actionButton = (refresh: UIButton(image: R.image.icon_refresh()?.resize(maxHeight: 16)),
                                add: UIButton(image: R.image.icon_add()?.resize(maxHeight: 16)),
                                user: UIButton(image: R.image.icon_user()?.resize(maxHeight: 16)))
    @IBOutlet weak var novelList: UICollectionView! {
        didSet {
            novelList.registerCell(NovelCardCollectionViewCell.self)
        }
    }
    @IBOutlet weak var actionToolbar: ActionToolbar! {
        didSet {
            let size = CGSize.init(width: R.Width.screen - 60, height: 60)
            actionToolbar?.setUpViews(targetSize: size, margin: (30, 14),
                                      items: [actionButton.refresh, actionButton.add, actionButton.user])
        }
    }
    
    @IBOutlet weak var collectionLayout: UICollectionViewFlowLayout! {
        didSet {
            collectionLayout.itemSize = CGSize(width: R.Width.screen, height: 300)
            collectionLayout.minimumLineSpacing = 1
            collectionLayout.minimumInteritemSpacing = 1
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureWithObservable()
        actionToolbar.show()
    }

    private func configureWithObservable() {
        actionButton.add.rx.tap
            .subscribe(onNext: {[weak self] _ in
                   self?.performSegue(withIdentifier: R.segue.mainViewController.sendNewNovel.identifier, sender: nil)
                })
            .addDisposableTo(disposeBag)
        
        actionButton.user.rx.tap
            .subscribe(onNext: {[weak self] _ in
                self?.performSegue(withIdentifier: R.segue.mainViewController.mineInfo.identifier, sender: nil)
            })
            .addDisposableTo(disposeBag)
        
//        actionButton.refresh.rx.tap
//            .subscribe(onNext: {[waek self] _ in
//                
//            })
//            .addDisposableTo(disposeBag)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
    }

}

// MARK: - Target-Action
extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: NovelCardCollectionViewCell = collectionView.dequeueReusableCell(indexPath)
        cell.test()
        return cell
    }
}
