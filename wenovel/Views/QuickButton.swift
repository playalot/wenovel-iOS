//
//  QuickButton.swift
//  wenovel
//
//  Created by Tbxark on 12/05/2017.
//  Copyright © 2017 Tbxark. All rights reserved.
//

import UIKit


public typealias ButtonClick = (UIButton) -> Void
public typealias BarButtonClick = (UIBarButtonItem) -> Void

open class QuickButton: UIButton {
    
    public var clickAction: ButtonClick?
    
    public init() {
        super.init(frame: CGRect.zero)
        shareInit()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        shareInit()
    }
    
    public convenience init(image: UIImage?) {
        self.init(frame: CGRect.zero)
        setImage(image, for: .normal)
        imageView?.contentMode = .scaleAspectFit
        shareInit()
    }

    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        shareInit()
    }
    
    
    public class func build(image img: UIImage?, action: ButtonClick?) -> QuickButton {
        let button = QuickButton()
        button.setImage(img, for: .normal)
        button.clickAction = action
        return button
    }
    
    public class func build(title str: String, action: ButtonClick?) -> QuickButton {
        let button = QuickButton()
        button.setTitle(str, for: .normal)
        button.clickAction = action
        return button
    }
    
    
    open func shareInit() {
        self.addTarget(self,
                       action: #selector(QuickButton.quickButtonClick(_:)),
                       for: .touchUpInside)
    }
    
    public func quickButtonClick(_ button: QuickButton) {
        if let action = clickAction {
            action(button)
        }
    }    
}
