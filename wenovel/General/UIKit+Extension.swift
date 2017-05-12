//
//  UIKit+Extension.swift
//  wenovel
//
//  Created by Tbxark on 09/05/2017.
//  Copyright © 2017 Tbxark. All rights reserved.
//

import UIKit
import WeNovelKit
import SnapKit
import SVProgressHUD
import YYWebImage

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
        imageView?.contentMode = .scaleAspectFit
    }
    
    func setNormalImage(_ image: UIImage?) {
        setImage(image, for: .normal)
    }
    func setNormalTitle( _ title: String?) {
        setTitle(title, for: .normal)
    }
}


protocol UITableViewCellHeight {
    static var defaultHeight: CGFloat { get }
}


private let kSplineTag = 2017

extension UITableViewCell {
    
    func setSeparatorLineHidden(_ hidden: Bool) {
        subviews.forEach {
            if $0.tag == kSplineTag {
                $0.isHidden = hidden
            }
        }
    }
    
    func removeSeparatorLine() {
        subviews.forEach {
            if $0.tag == kSplineTag {
                $0.removeFromSuperview()
            }
        }
    }
    
    func addSeparatorLineIfNeed(force: Bool = false) {
        guard force || !subviews.contains(where: { $0.tag == kSplineTag }) else {
            return
        }
        let line = UIView()
        line.backgroundColor = UIColor(white: 0.8, alpha: 1)
        
        contentView.addSubview(line)
        line.tag = kSplineTag
        line.snp.makeConstraints { (make) in
            make.right.bottom.equalTo(self)
            make.left.equalTo(self).offset(20)
            make.height.equalTo(1 / 3.0)
        }
    }
}

private let kCornerRadiusTag = 100003
extension UIView {
    func addCorner(radius: CGFloat, sourceSize: CGSize, color: UIColor) {
        for v in subviews {
            guard let imgv = v as? UIImageView, imgv.tag == kCornerRadiusTag else { continue }
            imgv.removeFromSuperview()
            break
        }
        let imgv = UIImageView(image: UIImage.cornerImage(radius: radius, size: sourceSize, color: color))
        imgv.frame = bounds
        addSubview(imgv)
        imgv.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalTo(self)
        }
    }
    
    func removeCorner() {
        for v in subviews {
            guard v.tag == kCornerRadiusTag else { continue }
            v.removeFromSuperview()
            break
        }
    }
}


extension UIImage {
    
    static func cornerImage(radius: CGFloat, size: CGSize, color: UIColor) -> UIImage? {
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContext(CGSize(width: size.width * scale, height: size.height * scale))
        let w = size.width * scale
        let h = size.height * scale
        let r = radius * scale
        func path(center: CGPoint, startAngle: CGFloat, endAngle: CGFloat, endPoint: CGPoint) -> UIBezierPath {
            let path = UIBezierPath()
            path.addArc(withCenter: center, radius: r, startAngle: startAngle, endAngle: endAngle, clockwise: true)
            path.addLine(to: endPoint)
            return path
        }
        let paths = [path(center: CGPoint(x: w - r, y: h - r), startAngle: 0, endAngle: CGFloat.pi/2, endPoint: CGPoint(x: w, y: h)),
                     path(center: CGPoint(x: r, y: h - r), startAngle: CGFloat.pi/2, endAngle: CGFloat.pi, endPoint: CGPoint(x: 0, y: h)),
                     path(center: CGPoint(x: r, y: r), startAngle: CGFloat.pi, endAngle: CGFloat.pi/2*3, endPoint: CGPoint(x: 0, y: 0)),
                     path(center: CGPoint(x: w - r, y: r), startAngle: CGFloat.pi/2*3, endAngle: CGFloat.pi*2, endPoint: CGPoint(x: w, y: 0))]
        color.setFill()
        paths.forEach({
            $0.close()
            $0.fill()
        })
        return UIGraphicsGetImageFromCurrentImageContext()
    }

    // 可根据指定 尺寸,或最大尺寸缩放图形
    func resize(_ width: CGFloat? = nil, height: CGFloat? = nil, maxWidth: CGFloat? = nil, maxHeight: CGFloat? = nil) -> UIImage {
        guard let imgRef = self.cgImage else {
            return self
        }
        var w = width ?? size.width
        var h = height ?? size.height
        if let mW = maxWidth {
            if w > mW {
                h = mW / w * h
                w = mW
            }
        }
        if let mH = maxHeight {
            if h > mH {
                w = mH / h * w
                h = mH
            }
        }
        let srcSize = CGSize(width: imgRef.width, height: imgRef.height)
        var dstSize = CGSize(width: w, height: h)
        let scaleRatio = dstSize.width / srcSize.width
        if scaleRatio > 1 && (abs(srcSize.width - dstSize.width) > 0.1 || abs(srcSize.height - dstSize.height) > 0.1) {
            return self
        }
        if size.width < w || size.height < h {
            return self
        }
        let orient = imageOrientation
        var transform = CGAffineTransform.identity
        
        switch orient {
        case .up: //EXIF = 1
            transform = CGAffineTransform.identity;
        case .upMirrored: //EXIF = 2
            transform = CGAffineTransform(translationX: srcSize.width, y: 0.0);
            transform = transform.scaledBy(x: -1.0, y: 1.0);
        case .down: //EXIF = 3
            transform = CGAffineTransform(translationX: srcSize.width, y: srcSize.height);
            transform = transform.rotated(by: CGFloat.pi);
        case .downMirrored: //EXIF = 4
            transform = CGAffineTransform(translationX: 0.0, y: srcSize.height);
            transform = transform.scaledBy(x: 1.0, y: -1.0);
        case .leftMirrored: //EXIF = 5
            dstSize = CGSize(width: dstSize.width, height: dstSize.height);
            transform = CGAffineTransform(translationX: srcSize.height, y: srcSize.width);
            transform = transform.scaledBy(x: -1.0, y: 1.0);
            transform = transform.rotated(by: 3.0 * CGFloat.pi * 0.5);
        case .left: //EXIF = 6
            dstSize = CGSize(width: dstSize.width, height: dstSize.height);
            transform = CGAffineTransform(translationX: 0.0, y: srcSize.width);
            transform = transform.rotated(by: 3.0 * CGFloat.pi * 0.5);
        case .rightMirrored: //EXIF = 7
            dstSize = CGSize(width: dstSize.width, height: dstSize.height);
            transform = CGAffineTransform(scaleX: -1.0, y: 1.0);
            transform = transform.rotated(by: CGFloat.pi * 0.5);
        case .right: //EXIF = 8
            dstSize = CGSize(width: dstSize.width, height: dstSize.height);
            transform = CGAffineTransform(translationX: srcSize.height, y: 0.0);
            transform = transform.rotated(by: CGFloat.pi * 0.5);
        }
        
        UIGraphicsBeginImageContextWithOptions(dstSize, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else {
            return self
        }
        switch orient {
        case .right, .left:
            context.scaleBy(x: -scaleRatio, y: scaleRatio)
            context.translateBy(x: -srcSize.height, y: 0)
        default:
            context.scaleBy(x: scaleRatio, y: -scaleRatio)
            context.translateBy(x: 0, y: -srcSize.height)
        }
        context.concatenate(transform)
        context.draw(imgRef, in: CGRect(x: 0, y: 0, width: srcSize.width, height: srcSize.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        
        return resizedImage ?? self
    }
}


private let kCloseBarButtonTag = 100001
private let kBackBarButtonTag  = 100002

extension UIViewController {
    @objc var showCloseBarButtonItem: Bool {
        get {
            guard let tag = navigationItem.rightBarButtonItem?.tag else {
                return true
            }
            return tag == kCloseBarButtonTag
        }
        set {
            _ = addCloseBarButtonItem()
        }
    }
    
    @objc var showBackBarButtonItem: Bool {
        get {
            guard let tag = navigationItem.rightBarButtonItem?.tag else {
                return true
            }
            return tag == kBackBarButtonTag
        }
        set {
            _ = addBackBarButtonItem()
        }
    }
    
    @objc func closeBarButtonDidClick(_ btn: UIBarButtonItem?) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func backBarButtonDidClick(_ btn: UIBarButtonItem?) {
        if let nav = navigationController, nav.viewControllers.count == 1 {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    func addCloseBarButtonItem() -> UIBarButtonItem {
        let btn = UIBarButtonItem(image: R.image.icon_close()?.resize(maxHeight: 16), style: UIBarButtonItemStyle.plain, target: self, action: #selector(UIViewController.closeBarButtonDidClick(_:)))
        navigationItem.leftBarButtonItem = btn
        btn.tag = kCloseBarButtonTag
        return btn
    }
    
    func addBackBarButtonItem() -> UIBarButtonItem {
        let btn = UIBarButtonItem(image: R.image.icon_arrow_left()?.resize(maxHeight  : 16), style: UIBarButtonItemStyle.plain, target: self, action: #selector(UIViewController.backBarButtonDidClick(_:)))
        btn.tag = kBackBarButtonTag
        navigationItem.leftBarButtonItem = btn
        return btn
    }
}


extension UIImageView {
    func loadURL(url: URL?) {
        yy_setImage(with: url, options: YYWebImageOptions.setImageWithFadeAnimation)
    }
}



