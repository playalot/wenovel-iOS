//
//  UIKit+Extension.swift
//  wenovel
//
//  Created by Tbxark on 09/05/2017.
//  Copyright © 2017 Tbxark. All rights reserved.
//

import UIKit
import WeNovelKit
import SVProgressHUD

extension SVProgressHUD {
    static func showResult(_ result: WNResult<String>) {
        switch result {
        case .success(let value):
            SVProgressHUD.showSuccess(withStatus: value)
        case .error(let error):
            let desc = (error as NSError).userInfo[NSLocalizedDescriptionKey] as? String
            SVProgressHUD.showError(withStatus: desc ?? "Error")
        }
    }
}


extension UIButton {
    convenience init(image: UIImage?) {
        self.init(frame: CGRect.zero)
        setImage(image, for: .normal)
    }
}
