//
//  ActionToolbar.swift
//  wenovel
//
//  Created by Tbxark on 09/05/2017.
//  Copyright © 2017 Tbxark. All rights reserved.
//

import UIKit

class ActionToolbar: UIView {
    
    private let bgImage = UIImageView(image: R.image.tool_bar_bg())
    private var targetSize = CGSize.zero
    private var margin: (x: CGFloat, y: CGFloat) = (0, 0)
    private var items: [UIView] = [UIView]()
    
    func setUpViews(targetSize: CGSize, margin: (x: CGFloat, y: CGFloat), items: [UIView]) {
        isUserInteractionEnabled = true
        subviews.forEach({ $0.removeFromSuperview() })
        let size = targetSize.height - margin.y * 2
        let space = (targetSize.width - margin.x * 2 - CGFloat(items.count) * size)/(CGFloat(items.count) - 1)
        var rect = CGRect.init(x: margin.x, y: margin.y, width: size, height: size)
        addSubview(bgImage)
        for v in items {
            addSubview(v)
            v.frame = rect
            v.alpha = 0
            (v as? UIControl)?.isEnabled = false
            rect.origin.x += space + size

        }
        self.margin = margin
        self.items = items
        self.targetSize = targetSize
        bgImage.frame = CGRect(x: (targetSize.width - targetSize.height)/2, y: 0,
                               width: targetSize.height, height: targetSize.height)
    }
    
    
    func show() {
        UIView.animate(withDuration: 2/3.0, delay: 1/3.0,options: .curveEaseInOut, animations: {
            self.bgImage.frame = CGRect(origin: CGPoint.zero, size: self.targetSize)
        }, completion: { _ in
            UIView.animate(withDuration: 1/3.0, delay: 0, options: .curveEaseInOut, animations: {
                for v in self.items {
                    v.alpha = 1
                    (v as? UIControl)?.isEnabled = true
                }
            }, completion: nil)
        })
    }
}
