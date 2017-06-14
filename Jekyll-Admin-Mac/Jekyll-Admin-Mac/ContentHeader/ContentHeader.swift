//
//  ContentHeader.swift
//  Jekyll-Admin-Mac
//
//  Created by 张行 on 2017/6/10.
//  Copyright © 2017年 张行. All rights reserved.
//

import Cocoa

enum ContentHeaderStyle:Int {
    case value1
    case value2
}


@IBDesignable class ContentHeader: BaseView {
    @IBOutlet weak var rightContentView: NSView!
    @IBOutlet weak var titleLabel: NSTextField!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.loadXibView()
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.loadXibView()
    }
    
    @IBInspectable var style:Int = 0 {
        didSet {
            guard let headerStyle = ContentHeaderStyle(rawValue: self.style) else {
                return
            }
            switch headerStyle {
            case .value1:
                self.loadStyle1()
                break
            case .value2:
                break
            }
        }
    }
    
    func loadStyle1() {
        let style1View = ContentHeaderValue1(frame: self.rightContentView.bounds)
        style1View.autoresizingMask = [.viewWidthSizable,.viewHeightSizable]
        self.rightContentView.addSubview(style1View)
    }
    
    var headerContent:NSView? {
        get {
            let views = self.rightContentView.subviews
            guard views.count > 0 else {
                return nil
            }
            return views.first
        }
    }
    
    override func prepareForInterfaceBuilder() {
        self.style = 0
    }
}
