//
//  SideMenuItemView.swift
//  Jekyll-Admin-Mac
//
//  Created by 张行 on 2017/6/8.
//  Copyright © 2017年 张行. All rights reserved.
//

import Cocoa
import FontAwesomeIconFactory

typealias SideMenuItemViewClickCompletionHandle = (_ view:SideMenuItemView) -> Void

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
    
    var clickCompletionHandle:SideMenuItemViewClickCompletionHandle?
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.loadXibView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.loadXibView()
    }
    
    func sizeThatFits(_ size: NSSize) -> NSSize {
        let labelSize = self.itemTitle.sizeThatFits(size)
        let sizeWidth = size.height + 10 + labelSize.width + 10
        return NSSize(width: sizeWidth, height: size.height)
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.itemTitle.stringValue = "测试"
        self.iconImageView.iconHex = "F15C"
    }
    
    func addClick(completionHandle:@escaping SideMenuItemViewClickCompletionHandle) {
        self.clickCompletionHandle = completionHandle
        let click = NSClickGestureRecognizer(target: self, action:#selector(self.clickAction))
        self.addGestureRecognizer(click)
    }
    
    func clickAction() {
        guard let completionHandle = self.clickCompletionHandle else {
            return
        }
        completionHandle(self)
    }
}
