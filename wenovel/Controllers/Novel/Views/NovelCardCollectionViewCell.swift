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
import YYWebImage
import WeNovelKit


enum NovelAction {
    case like, dislike, comment, replay, share
}

protocol NovelCardCellDelegate: class {
    func novelCardCollectionViewCell(didSelect cell: NovelCardCollectionViewCell, data: WNNovelNode, action: NovelAction)
}

extension NovelCardCellDelegate {
    func novelCardCollectionViewCell(didSelect cell: NovelCardCollectionViewCell, data: WNNovelNode, action: NovelAction) {
        print("\(data)  \(action)")
    }
}

class NovelCardCollectionViewCell: UICollectionViewCell, Reusable {
    
    struct Layout {
        static func size(textHeight: CGFloat) -> CGSize {
            return CGSize(width: R.Width.screen,
                          height: R.Margin.large + R.Margin.large + 20 + R.Margin.small + textHeight + R.Height.toolBar + R.Margin.large)
        }
        struct Image {
            struct Like {
                static let active = R.image.icon_like()?.resize(maxHeight: 15).yy_image(byTintColor: UIColor.red)
                static let deactive = R.image.icon_like()?.resize(maxHeight: 15)
            }
        }
    }
    private let userImage = UIImageView()
    private let userName = UILabel()
    private let contentText = YYLabel()
    
    private let likeBtn = QuickButton(image: Layout.Image.Like.deactive)
    private let commentBtn = QuickButton(image: R.image.icon_comment()?.resize(maxHeight: 15))
    private let replayBtn = QuickButton(image: R.image.icon_edit()?.resize(maxHeight: 15))
    private let shareBtn = QuickButton(image: R.image.icon_share()?.resize(maxHeight: 15))
    
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
            make.top.equalTo(R.Margin.large * 1.5)
            make.left.equalTo(R.Margin.large * 2)
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
    
   
    func configureWithModel(_ dataModel: NovelRenderModel, delegate: NovelCardCellDelegate) {
        userImage.loadURL(url: dataModel.data.user?.avatar)
        userName.text = dataModel.data.user?.nickname
        contentText.attributedText = dataModel.text
        
        likeBtn.setNormalImage(dataModel.data.isLike ? Layout.Image.Like.active : Layout.Image.Like.deactive)
        likeBtn.setNormalTitle("\(dataModel.data.counts?.likes ?? 0)")
        
        likeBtn.clickAction = {[weak self, weak delegate] _ in
            guard let `self` = self else { return }
            delegate?.novelCardCollectionViewCell(didSelect: self,
                                                  data: dataModel.data,
                                                  action: dataModel.data.isLike ? NovelAction.dislike :  NovelAction.like)
        }
        commentBtn.clickAction = {[weak self, weak delegate] _ in
            guard let `self` = self else { return }
            delegate?.novelCardCollectionViewCell(didSelect: self,
                                                  data: dataModel.data,
                                                  action: NovelAction.comment)
        }
        replayBtn.clickAction = {[weak self, weak delegate] _ in
            guard let `self` = self else { return }
            delegate?.novelCardCollectionViewCell(didSelect: self,
                                                  data: dataModel.data,
                                                  action: NovelAction.replay)
        }
        shareBtn.clickAction = {[weak self, weak delegate] _ in
            guard let `self` = self else { return }
            delegate?.novelCardCollectionViewCell(didSelect: self,
                                                  data: dataModel.data,
                                                  action: NovelAction.share)
        }
        
    }
    
    override func draw(_ rect: CGRect) {
        let color = UIColor(white: 0.85, alpha: 1)
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
