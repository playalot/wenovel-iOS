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
    private var margin: (x: CGFloat, y: CGFloat) = (0, 0)
    private var items: [UIView] = [UIView]()
    
    func setUpViews(margin: (x: CGFloat, y: CGFloat), items: [UIView]) {
        isUserInteractionEnabled = true
        subviews.forEach({ $0.removeFromSuperview() })
        addSubview(bgImage)
        for v in items {
            addSubview(v)
        }
        self.margin = margin
        self.items = items
        layoutIfNeeded()
    }
    
    
    override func layoutSubviews() {
        
        let size = frame.height - margin.y * 2
        let space = (frame.width - margin.x * 2 - CGFloat(items.count) * size)/(CGFloat(items.count) - 1)
        var rect = CGRect.init(x: margin.x, y: margin.y, width: size, height: size)
        bgImage.frame = bounds
        for v in items {
            v.frame = rect
            rect.origin.x += space + size
        }
    }
}
