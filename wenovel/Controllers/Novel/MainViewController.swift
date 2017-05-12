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
    fileprivate let nodeAction =  PublishSubject<(NovelAction, WNNovelNode)>()
    private let actionButton = (refresh: UIButton(image: R.image.icon_refresh()?.resize(maxHeight: 16)),
                                add: UIButton(image: R.image.icon_add()?.resize(maxHeight: 16)),
                                user: UIButton(image: R.image.icon_user()?.resize(maxHeight: 16)))
    @IBOutlet weak var novelList: UICollectionView! {
        didSet {
            novelList.backgroundColor = UIColor.white
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
        let render = NovelRenderImp(style: NovelRenderStyle(),
                                    maxSize: CGSize(width: R.Width.screen - 4 * R.Margin.large, height: 300),
                                    toSize: NovelCardCollectionViewCell.Layout.size(textHeight:))
        
        
        let like = nodeAction.asObserver()
            .filter({ a, d in a == .like || a == .dislike })
            .map({ a , n in  (a == .like, n)})
        viewModel = NovelFeedViewModel(input: (novelList.rx_beginRefresh() , like),
                                       dependency: render)
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
        
        
        viewModel.reloadNovel
            .subscribe(onNext: {[weak self] (res: WNResult<Int>) in
                switch res {
                case .success(let value):
                    self?.novelList.reloadItems(at: [IndexPath(row: value, section: 0)])
                case .error(let error):
                    print(error)
                }
            })
            .addDisposableTo(disposeBag)
        
        nodeAction.subscribe(onNext: {[weak self] (action: NovelAction, node: WNNovelNode) in
            switch action {
            case .replay:
                self?.performSegue(withIdentifier: R.segue.mainViewController.sendNode, sender: node)
            default:
                break
            }
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
        case R.segue.mainViewController.sendNode.identifier:
            guard let data = sender,
                let model = data as? WNNovelNode,
                let vc = segue.destination as? SendNodeViewController else { return }
            vc.initData = model
        default:
            break
        }
    }

}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, NovelCardCellDelegate {
    
    func novelCardCollectionViewCell(didSelect cell: NovelCardCollectionViewCell, data: WNNovelNode, action: NovelAction) {
        nodeAction.on(.next((action, data)))
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.novelData.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = viewModel.novelData[indexPath.row]
        performSegue(withIdentifier: R.segue.mainViewController.showDetail, sender: data.data)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        (cell as? NovelCardCollectionViewCell)?.setNeedsDisplay()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.novelData[indexPath.row].size
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: NovelCardCollectionViewCell = collectionView.dequeueReusableCell(indexPath)
        let data = viewModel.novelData[indexPath.row]
        cell.configureWithModel(data, delegate: self)
        return cell
    }
}
