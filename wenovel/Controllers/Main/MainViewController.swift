//
//  ViewController.swift
//  wenovel
//
//  Created by Tbxark on 26/04/2017.
//  Copyright © 2017 Tbxark. All rights reserved.
//

import UIKit
import IBAnimatable

class MainViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fd_prefersNavigationBarHidden = true
        collectionView.register(R.nib.novelCardCollectionViewCell)
        (collectionView.collectionViewLayout as? UICollectionViewFlowLayout )?.itemSize = CGSize.init(width: R.Width.screen - 40, height: 100)
    }
    @IBAction func addButtonDidCkick(_ sender: AnimatableButton) {
//        sender.animate(AnimationType.pop(repeatCount: 1), duration: 0.2)
//        performSegue(withIdentifier: "SendNewNovel", sender: self)
        performSegue(withIdentifier: R.segue.mainViewController.sendNewNovel.identifier, sender: sender)
    }
    @IBAction func refreshButtonDidClick(_ sender: AnimatableButton) {
        sender.animate(AnimationType.rotate(direction: AnimationType.RotationDirection.cw, repeatCount: 6), duration: 1)
            .then(AnimationType.pop(repeatCount: 1), duration: 0.2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

// MARK: - Target-Action
extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ShowDetail", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.nib.novelCardCollectionViewCell.identifier, for: indexPath) as! NovelCardCollectionViewCell
        cell.textLabel.text = "从前有座山,山里有座庙, 庙里有个老和尚和小和讲故事, 在讲什么呢?"
        cell.authLabel.text = "作者: TBXark 日期: 2017-12-20 共100个续集"
        return cell
    }
}
