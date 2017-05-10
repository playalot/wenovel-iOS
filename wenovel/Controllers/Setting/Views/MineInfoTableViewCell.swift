//
//  SettingViewTableViewCell.swift
//  wenovel
//
//  Created by Tbxark on 10/05/2017.
//  Copyright © 2017 Tbxark. All rights reserved.
//

import UIKit


class SettingUserPreviewTableViewCell: UITableViewCell, UITableViewCellHeight {
    static let defaultHeight: CGFloat = 100
    @IBOutlet weak var avatarImage: UIImageView! {
        didSet {
            avatarImage.addCorner(radius: 30, sourceSize: CGSize(width: 60, height: 60), color: UIColor.white)
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subLabel: UILabel!
}
