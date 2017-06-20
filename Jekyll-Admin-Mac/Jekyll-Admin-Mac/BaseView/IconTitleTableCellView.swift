//
//  IconTitleTableCellView.swift
//  Jekyll-Admin-Mac
//
//  Created by 张行 on 2017/6/15.
//  Copyright © 2017年 张行. All rights reserved.
//

import Cocoa

class IconTitleTableCellView: NSTableCellView {
    
    @IBOutlet weak var itemViewWidthConstraint: NSLayoutConstraint!

    @IBOutlet weak var itemView: SideMenuItemView!
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.loadXibView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.loadXibView()
        self.configurationView(title: "这是测试标题")
    }
    
    func configurationView(title:String) {
        let configuration = SideMenuItemConfiguration(title: title, iconHex: "F0F6", hidden: true, selected: false, normalColor: NSColor(red:0.267, green:0.267, blue:0.267, alpha:1.000))
        self.itemView.menuItemConfiguration = configuration
        let size = self.itemView.sizeThatFits(NSSize(width: Int.max, height: 20))
        self.itemViewWidthConstraint.constant = CGFloat(size.width)
    }
}
