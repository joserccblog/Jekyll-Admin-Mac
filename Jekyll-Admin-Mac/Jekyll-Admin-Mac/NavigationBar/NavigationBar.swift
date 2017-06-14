//
//  NavigationBar.swift
//  Jekyll-Admin-Mac
//
//  Created by 张行 on 2017/6/10.
//  Copyright © 2017年 张行. All rights reserved.
//

import Cocoa

class NavigationBar: BaseView {
    @IBOutlet weak var blogMenuItem: SideMenuItemView!
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.loadXibView()
        self.blogMenuItem.iconImageView.iconHex = "F015"
        self.blogMenuItem.itemTitle.stringValue = "我的博客"
        self.blogMenuItem.backgroundColor = NSColor.clear
        self.blogMenuItem.iconImageView.color = NSColor(red:0.267, green:0.267, blue:0.267, alpha:1.000)
    }
}
