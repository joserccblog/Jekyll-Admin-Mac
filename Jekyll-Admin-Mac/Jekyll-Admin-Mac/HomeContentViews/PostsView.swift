//
//  PostsView.swift
//  Jekyll-Admin-Mac
//
//  Created by 张行 on 2017/6/14.
//  Copyright © 2017年 张行. All rights reserved.
//

import Cocoa

@IBDesignable
class PostsView: NSView {
    
    @IBOutlet weak var listView: BaseListView! {
        didSet {
            self.listView.header.style = 0
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
}
