//
//  ContentHeaderValue1.swift
//  Jekyll-Admin-Mac
//
//  Created by 张行 on 2017/6/10.
//  Copyright © 2017年 张行. All rights reserved.
//

import Cocoa

class ContentHeaderValue1: BaseView {
    @IBOutlet weak var action: NSButton!
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.loadXibView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.loadXibView()
    }
    
    override func prepareForInterfaceBuilder() {
        self.action.backgroundColor = NSColor.red
    }
}
