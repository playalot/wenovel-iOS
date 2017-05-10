//
//  NovelCardCollectionViewCell.swift
//  wenovel
//
//  Created by Tbxark on 10/05/2017.
//  Copyright © 2017 Tbxark. All rights reserved.
//

import UIKit
import YYText
import YYImage

class NovelCardCollectionViewCell: UICollectionViewCell, Reusable {
    
    struct Layout {
        static func height(textHeight: CGFloat) -> CGFloat {
            return R.Margin.large + R.Margin.large + 20 + R.Margin.small + textHeight + R.Height.toolBar + R.Margin.large
        }
    }
    private let userImage = UIImageView()
    private let userName = UILabel()
    private let contentText = YYLabel()
    
    private let likeBtn = UIButton(image: R.image.icon_like()?.resize(maxHeight: 15))
    private let commentBtn = UIButton(image: R.image.icon_comment()?.resize(maxHeight: 15))
    private let replayBtn = UIButton(image: R.image.icon_edit()?.resize(maxHeight: 15))
    private let shareBtn = UIButton(image: R.image.icon_share()?.resize(maxHeight: 15))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        shareInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        shareInit()
    }
    
    
    private func shareInit() {
        backgroundColor = UIColor.white
        let toolBar = UIView()
        toolBar.isUserInteractionEnabled = true
        contentView.addSubview(userImage)
        contentView.addSubview(userName)
        contentView.addSubview(contentText)
        contentView.addSubview(toolBar)
        toolBar.addSubview(likeBtn)
        toolBar.addSubview(commentBtn)
        toolBar.addSubview(replayBtn)
        toolBar.addSubview(shareBtn)
        
        userImage.addCorner(radius: 10, sourceSize: CGSize(width: 20, height: 20), color: UIColor.white)
        userImage.snp.makeConstraints { (make) in
            make.top.left.equalTo(R.Margin.large * 2)
            make.size.equalTo(20)
        }
        userName.font = UIFont.boldSystemFont(ofSize: 10)
        userName.textColor = UIColor.gray
        userName.snp.makeConstraints { (make) in
            make.left.equalTo(userImage.snp.right).offset(R.Margin.large)
            make.right.equalTo(contentView).offset(-1.5 * R.Margin.large)
            make.top.bottom.equalTo(userImage)
        }
        toolBar.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(R.Margin.large)
            make.right.equalTo(contentView).offset(-R.Margin.large)
            make.bottom.equalTo(contentView).offset(-R.Margin.large/2)
            make.height.equalTo(R.Height.toolBar)
        }
        let btnSize = CGSize(width: (R.Width.screen - R.Margin.large * 2)/4, height: R.Height.toolBar)
        for (i, btn) in [likeBtn, commentBtn, replayBtn, shareBtn].enumerated() {
            btn.snp.makeConstraints({ (make) in
                make.size.equalTo(btnSize)
                make.left.equalTo(toolBar).offset(btnSize.width * CGFloat(i))
                make.centerY.equalTo(toolBar)
            })
        }
        func initTitleButton(btn: UIButton) {
            btn.setTitle("0", for: .normal)
            btn.setTitleColor(UIColor.darkGray, for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            btn.imageEdgeInsets = UIEdgeInsets(top: 14, left: 30, bottom: 14, right: btnSize.width - 30 - 20)
            btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        }
        initTitleButton(btn: likeBtn)
        initTitleButton(btn: commentBtn)
        initTitleButton(btn: replayBtn)
        replayBtn.imageEdgeInsets = UIEdgeInsets(top: 14, left: 30, bottom: 14, right: btnSize.width - 30 - 20)

        contentText.numberOfLines = 0
        contentText.textVerticalAlignment = .top
        contentText.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(2 * R.Margin.large)
            make.right.equalTo(contentView).offset(-2 * R.Margin.large)
            make.top.equalTo(userImage.snp.bottom).offset(R.Margin.small)
            make.bottom.equalTo(toolBar.snp.top)
        }
    }
    
    
    func test() {
        userImage.image = R.image.text_avatar()
        userName.text = "TBXark"
        let attr = NSMutableAttributedString()
        attr.yy_color = UIColor.black
        let title = NSMutableAttributedString(string: "从前有座山,山里有座庙\n")
        title.yy_font = UIFont.boldSystemFont(ofSize: 16)
        title.yy_minimumLineHeight = 30
        let content = NSMutableAttributedString(string: "从前有座山,山里有座庙, 庙里有个老和尚和小和讲故事, 在讲什么呢? 在讲: 从前有座山,山里有座庙, 庙里有个老和尚和小和讲故事, 在讲什么呢? 在讲: 从前有座山,山里有座庙, 庙里有个老和尚和小和讲故事, 在讲什么呢? 从前有座山,山里有座庙, 庙里有个老和尚和小和讲故事, 在讲什么呢? 在讲: 从前有座山,山里有座庙, 庙里有个老和尚和小和讲故事, 在讲什么呢? 在讲:...... ")
        content.yy_font = UIFont.systemFont(ofSize: 15)
        content.yy_minimumLineHeight = 20
        attr.append(title)
        attr.append(content)
        contentText.attributedText = attr
    
    }

    override func draw(_ rect: CGRect) {
        let color = UIColor(white: 0.9, alpha: 1)
        let rectanglePath = UIBezierPath(roundedRect: rect.insetBy(dx: 14, dy: 7), cornerRadius: 4)
        color.setStroke()
        UIColor.white.setFill()
        rectanglePath.lineWidth = 1/3.0
        rectanglePath.stroke()
        
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 28, y: rect.height - 7 - R.Height.toolBar))
        bezierPath.addLine(to: CGPoint(x: rect.width - 28, y: rect.height - 7  - R.Height.toolBar))
        color.setStroke()
        bezierPath.lineWidth = 1/3.0
        bezierPath.stroke()
    }
}
