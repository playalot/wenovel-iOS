//
//  NovelDetailViewController.swift
//  wenovel
//
//  Created by Tbxark on 11/05/2017.
//  Copyright © 2017 Tbxark. All rights reserved.
//

import UIKit
import RxSwift
import WeNovelKit

class NovelDetailViewController: UIViewController {

    var initData: (WNNovelNode)?
    
    fileprivate var viewModel: NovelNodeFeedViewModel!
    private var disposeBag: DisposeBag!
    private let position = (min: R.Height.fullNavigationBar, max: R.Height.screen - 200)
    private let actionButton = (back: UIButton(image: R.image.icon_arrow_left()?.resize(maxHeight: 16)),
                                forward: UIButton(image: R.image.icon_arrow_right()?.resize(maxHeight: 16)),
                                more: UIButton(image: R.image.icon_more()?.resize(maxWidth: 16)),
                                add: UIButton(image: R.image.icon_add()?.resize(maxHeight: 16)))
    @IBOutlet weak var actionToolbar: ActionToolbar! {
        didSet {
            let size = CGSize.init(width: R.Width.screen - 60, height: 60)
            actionToolbar?.setUpViews(targetSize: size, margin: (30, 14),
                                      items: [actionButton.back, actionButton.forward, actionButton.more, actionButton.add])
        }
    }

    @IBOutlet weak var textContent: UITextView!
    @IBOutlet weak var resizeYPosition: NSLayoutConstraint!
    @IBOutlet weak var novelList: UICollectionView! {
        didSet {
            novelList.registerCell(NovelCardCollectionViewCell.self)
        }
    }
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout! {
        didSet {
            collectionViewLayout.itemSize = CGSize(width: R.Width.screen, height: 300)
            collectionViewLayout.minimumLineSpacing = 1
            collectionViewLayout.minimumInteritemSpacing = 1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        actionToolbar.show(duration: nil)
        configureWithObservable()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        novelList.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 80, right: 0)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func configureWithObservable() {
        disposeBag = nil
        disposeBag = DisposeBag()
        
        viewModel = NovelNodeFeedViewModel(input: (node: initData, refresh: novelList.rx_beginRefresh()), dependency: NovelRenderImp())
        actionButton.back.rx.tap
            .subscribe(onNext: {[weak self] _ in
                guard let `self` = self else { return }
                self.backBarButtonDidClick(nil)
            })
            .addDisposableTo(disposeBag)
        
        
        actionButton.add.rx.tap
            .subscribe(onNext: {[weak self] _ in
                    guard let `self` = self else { return }
                    self.performSegue(withIdentifier: R.segue.novelDetailViewController.sendNode, sender: nil)
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

        
        viewModel.nodeChange
            .subscribe(onNext: {[weak self] (node: WNNovelNode) in
                guard let `self` = self else { return }
                self.navigationItem.title = node.storyTitle ?? ""
                self.textContent.text = node.content
                self.textContent.contentOffset = CGPoint.zero
                self.novelList.headerBeginRefresh()
            })
            .addDisposableTo(disposeBag)
        
            
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let iden = segue.identifier else { return }
        switch iden {
        case R.segue.novelDetailViewController.sendNode.identifier:
            guard  let vc = segue.destination as? SendNodeViewController else { return }
            vc.initData = viewModel.nodeData
        case R.segue.novelDetailViewController.showDetail.identifier:
            guard let data = sender,
                let model = data as? WNNovelNode,
                let vc = segue.destination as? NovelDetailViewController else { return }
            vc.initData = model
        default:
            break
        }
    }

    @IBAction func resizeButtonDidPan(_ sender: UIPanGestureRecognizer) {
        let y = sender.location(in: view).y - R.Height.fullNavigationBar
        guard y > position.min, y < position.max else { return }
        resizeYPosition.constant = y
    }
}

extension NovelDetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.novelData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = viewModel.novelData[indexPath.row]
        performSegue(withIdentifier: R.segue.novelDetailViewController.showDetail, sender: data)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: NovelCardCollectionViewCell = collectionView.dequeueReusableCell(indexPath)
        let data = viewModel.novelData[indexPath.row]
        cell.configureWithModel(data)
        return cell
    }
}
