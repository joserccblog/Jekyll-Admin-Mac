//
//  NSButton+TitleColor.swift
//  Jekyll-Admin-Mac
//
//  Created by 张行 on 2017/6/14.
//  Copyright © 2017年 张行. All rights reserved.
//

import AppKit


extension NSButton {
    @IBInspectable var titleColor:NSColor? {
        get {
            return self.attributedTitle.attribute(NSForegroundColorAttributeName, at: 0, longestEffectiveRange: nil, in: NSMakeRange(0, self.title.characters.count)) as? NSColor
        }
        set {
            guard let color = newValue else {
                return
            }
            let style = NSMutableParagraphStyle()
            style.alignment = self.alignment
            let dict = [
                NSForegroundColorAttributeName:color,
                NSParagraphStyleAttributeName:style,
                NSFontAttributeName:NSFont.boldSystemFont(ofSize: 15)
            ]
            let mutableAttributeString = NSMutableAttributedString(string: self.title, attributes: dict)
            self.attributedTitle = mutableAttributeString
            
        }
    }
}
