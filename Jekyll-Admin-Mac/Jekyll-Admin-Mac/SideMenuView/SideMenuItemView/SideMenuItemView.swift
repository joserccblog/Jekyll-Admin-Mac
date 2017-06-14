//
//  SideMenuItemView.swift
//  Jekyll-Admin-Mac
//
//  Created by 张行 on 2017/6/8.
//  Copyright © 2017年 张行. All rights reserved.
//

import Cocoa
import FontAwesomeIconFactory

@IBDesignable
class SideMenuItemView: BaseView {
    @IBInspectable @IBOutlet weak var iconImageView: NIKFontAwesomeImageView!
    @IBOutlet weak var itemTitle: NSTextField!
    @IBOutlet weak var view: BaseView!
    @IBOutlet weak var lineView: BaseView!
    
    var menuItemConfiguration:SideMenuItemConfiguration? {
        didSet {
            guard let configuration = self.menuItemConfiguration else {
                return
            }
            self.itemTitle.stringValue = configuration.title
            self.iconImageView.iconHex = configuration.iconHex as NSString
            self.lineView.isHidden = configuration.hidden
            let color = configuration.selected ? configuration.selectedColor : configuration.normalColor
            self.iconImageView.color = color
            self.itemTitle.textColor = color
        }
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.loadXibView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.loadXibView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.itemTitle.stringValue = "测试"
        self.iconImageView.iconHex = "F15C"
    }
}
