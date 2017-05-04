//
//  NovelCardCollectionViewCell.swift
//  wenovel
//
//  Created by Tbxark on 27/04/2017.
//  Copyright © 2017 Tbxark. All rights reserved.
//

import UIKit
import YYText

class NovelCardCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var textLabel: YYLabel!
    @IBOutlet weak var authLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textLabel.numberOfLines = 0
        textLabel.textVerticalAlignment = .top
    }

}
