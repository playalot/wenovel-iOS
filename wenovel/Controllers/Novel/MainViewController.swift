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
    private var disposeBag: DisposeBag!
    fileprivate var viewModel: NovelFeedViewModel!
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
        layoutViewController()
        actionToolbar.show(duration: 1)
        novelList.headerBeginRefresh()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        novelList.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 80, right: 0)
    }

    private func layoutViewController() {
        navigationItem.title = "W E N O V E L"
    }
    
    private func configureWithObservable() {
        disposeBag = nil
        disposeBag = DisposeBag()
        viewModel = NovelFeedViewModel(input: novelList.rx_beginRefresh(), dependency: NovelRenderImp())
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
        viewModel.novelSignal
            .do(onNext:  {[weak self] _ in
                self?.novelList.reloadData()
                })
            .subscribe({ [weak self] _ in
                self?.novelList.headerEndRefresh()
                self?.novelList.footerEndRefresh()
            })
            .addDisposableTo(disposeBag)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let iden = segue.identifier else { return }
        switch  iden {
        case R.segue.mainViewController.showDetail.identifier:
            guard let data = sender,
                let model = data as? WNNovelNode,
                let vc = segue.destination as? NovelDetailViewController else { return }
            vc.initData = model
        default:
            break
        }
    }

}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.novelData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = viewModel.novelData[indexPath.row]
        performSegue(withIdentifier: R.segue.mainViewController.showDetail, sender: data)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: NovelCardCollectionViewCell = collectionView.dequeueReusableCell(indexPath)
        let data = viewModel.novelData[indexPath.row]
        cell.configureWithModel(data)
        return cell
    }
}
