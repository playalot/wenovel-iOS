//
//  NovelRenderImp.swift
//  wenovel
//
//  Created by Tbxark on 11/05/2017.
//  Copyright © 2017 Tbxark. All rights reserved.
//

import UIKit
import WeNovelKit


protocol NovelRenderProtocol {
    func render(_ node: WNNovelNode) -> NovelRenderModel
}
extension NovelRenderProtocol {
    func render(_ nodes: [WNNovelNode]) -> [NovelRenderModel] {
        return nodes.map({ self.render($0) })
    }
}



class NovelRenderModel: Equatable {

    private(set) var data: WNNovelNode
    let text: NSAttributedString
    let size: CGSize
    init(data: WNNovelNode, text: NSAttributedString, size: CGSize) {
        self.data = data
        self.text = text
        self.size = size
    }
    
    func forceChangeData(data: WNNovelNode) {
        self.data = data
    }
    
    static func ==(lhs: NovelRenderModel, rhs: NovelRenderModel) -> Bool {
        return lhs.data == rhs.data
    }
}

struct NovelRenderStyle {
    let titleFont: UIFont
    let contentFont: UIFont
    let titleColor: UIColor
    let contentColor: UIColor
    init(color: (title: UIColor, content: UIColor) = (UIColor.black, UIColor.black),
         font: (title: UIFont, content: UIFont) = (UIFont.boldSystemFont(ofSize: 16),  UIFont.systemFont(ofSize: 15))) {
        titleFont = font.title
        contentFont = font.content
        titleColor = color.title
        contentColor = color.content
    }
}

class NovelRenderImp: NovelRenderProtocol {
    private let render: (_ title: String?, _ content: String?) -> (attr: NSAttributedString, size: CGSize)
    init(style: NovelRenderStyle, maxSize: CGSize, toSize: @escaping (CGFloat) -> CGSize) {
        let titleHeight = style.titleFont.lineHeight * 1.2
        let contentHeight = style.contentFont.lineHeight * 1.2
        render = { (title: String?, content: String?) -> (attr: NSAttributedString, size: CGSize) in
            let attr = NSMutableAttributedString()
            if let t = title {
                let titleAttr = NSMutableAttributedString(string: t + "\n")
                titleAttr.yy_font = style.titleFont
                titleAttr.yy_minimumLineHeight = titleHeight
                titleAttr.yy_color = style.titleColor
                attr.append(titleAttr)
            }
            if let c = content {
                let contentAttr = NSMutableAttributedString(string: c)
                contentAttr.yy_font = style.contentFont
                contentAttr.yy_minimumLineHeight = contentHeight
                contentAttr.yy_color = style.contentColor
                attr.append(contentAttr)
            }
            let h = attr.boundingRect(with: maxSize,
                                      options: [.usesLineFragmentOrigin, .usesFontLeading],
                                      context: nil).height
            return (attr, toSize(ceil(h)))
        }
    }
    
    func render(_ node: WNNovelNode) -> NovelRenderModel {
        let res = render(node.storyTitle, node.content)
        return NovelRenderModel(data: node, text: res.attr, size: res.size)
    }

}
