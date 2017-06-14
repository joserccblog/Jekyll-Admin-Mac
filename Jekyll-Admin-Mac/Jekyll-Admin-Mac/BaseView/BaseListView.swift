//
//  BaseListView.swift
//  Jekyll-Admin-Mac
//
//  Created by 张行 on 2017/6/13.
//  Copyright © 2017年 张行. All rights reserved.
//

import Cocoa

@IBDesignable
class BaseListView: NSView {
    
    @IBOutlet weak var header: ContentHeader!
    
    var title:String? {
        get {
            return self.header.titleLabel.stringValue
        }
        set {
            guard let title = newValue else {
                return
            }
            self.header.titleLabel.stringValue = title
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
        self.title = "文章"
        self.header.prepareForInterfaceBuilder()
    }
}
