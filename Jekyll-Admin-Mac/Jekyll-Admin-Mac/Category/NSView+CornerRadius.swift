//
//  NSView+CornerRadius.swift
//  Jekyll-Admin-Mac
//
//  Created by 张行 on 2017/6/10.
//  Copyright © 2017年 张行. All rights reserved.
//

import AppKit

extension NSView {
    @IBInspectable var cornerRadius:Int {
        get {
            guard let cornerRadius = self.layer?.cornerRadius else {
                return 0
            }
            return Int(cornerRadius)
        } set {
            self.wantsLayer = true
            self.layer?.masksToBounds = true
            self.layer?.cornerRadius = CGFloat(newValue)
        }
    }
}
