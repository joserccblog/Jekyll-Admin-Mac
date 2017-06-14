//
//  NSView+LoadXibView.swift
//  Jekyll-Admin-Mac
//
//  Created by 张行 on 2017/6/9.
//  Copyright © 2017年 张行. All rights reserved.
//

import AppKit

extension NSView {
    func loadXibView() {
        guard let nibName = NSStringFromClass(type(of:self)).components(separatedBy: ".").last else {
            return
        }
        guard let xibView = self.getXibView(nibName: nibName) else {
            return
        }
        xibView.autoresizingMask = [.viewWidthSizable,.viewHeightSizable]
        xibView.frame = self.bounds
        self.addSubview(xibView)
    }
    
    func getXibView(nibName:String) -> NSView? {
        var views:NSArray = NSArray()
        Bundle(for: type(of: self)).loadNibNamed(nibName, owner: self, topLevelObjects: &views)
        var xibView:NSView?
        for any in views {
            guard let view = any as? NSView else {
                continue
            }
            xibView = view
        }
        return xibView
    }
}
