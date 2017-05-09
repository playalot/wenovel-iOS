//
//  NovelCollectionViewCell.swift
//  wenovel
//
//  Created by Tbxark on 09/05/2017.
//  Copyright © 2017 Tbxark. All rights reserved.
//

import UIKit

class NovelCollectionViewCell: UICollectionViewCell {
    
    private let userAvatar = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        shareInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func shareInit() {
        
    }
}
