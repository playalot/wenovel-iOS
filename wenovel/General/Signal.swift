//
//  Signal.swift
//  wenovel
//
//  Created by Tbxark on 09/05/2017.
//  Copyright © 2017 Tbxark. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

struct Signal {
    public static func keyboardHeight() -> Observable<CGFloat> {
        return NotificationCenter.default.rx
            .notification(NSNotification.Name.UIKeyboardWillChangeFrame)
            .map { (notify: Notification) -> CGFloat in
                if let userInfo = (notify as NSNotification).userInfo,
                    let beginFrame = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue,
                    let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
                    beginFrame.height > 0 {
                    let y = endFrame.origin.y == CGFloat.infinity ? 0 : endFrame.origin.y
                    let height = endFrame.size.height == CGFloat.infinity ? 0 : endFrame.size.height
                    let offset: CGFloat = y + height - UIScreen.main.bounds.height
                    let keyboardVisibleHeight = height - offset
                    return keyboardVisibleHeight
                } else {
                    return 0
                }
        }
    }
}
