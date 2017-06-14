//
//  NSView+BackgroundColor.swift
//  Jekyll-Admin-Mac
//
//  Created by 张行 on 2017/6/13.
//  Copyright © 2017年 张行. All rights reserved.
//

import AppKit

extension NSView {
    @IBInspectable var backgroundColor:NSColor! {
        get {
            guard let backgroundColor = NSColor(cgColor: (self.layer?.backgroundColor)!) else {
                return NSColor.clear
            }
            return backgroundColor
        }
        set {
            self.wantsLayer = true
            self.layer?.backgroundColor = newValue.cgColor
        }
    }
}
