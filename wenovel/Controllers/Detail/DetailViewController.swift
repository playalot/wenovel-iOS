//
//  DetailViewController.swift
//  wenovel
//
//  Created by Tbxark on 27/04/2017.
//  Copyright © 2017 Tbxark. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fd_prefersNavigationBarHidden = true
        collectionView.register(R.nib.novelCardCollectionViewCell)
         (collectionView.collectionViewLayout as? UICollectionViewFlowLayout )?.itemSize = CGSize.init(width: R.Width.screen - 40, height: 100)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}

// MARK: - Target-Action
extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.nib.novelCardCollectionViewCell.identifier, for: indexPath) as! NovelCardCollectionViewCell
        cell.textLabel.text = "从前有座山,山里有座庙, 庙里有个老和尚和小和讲故事, 在讲什么呢?"
        cell.authLabel.text = "作者: TBXark 日期: 2017-12-20 共100个续集"
        return cell
    }

}
