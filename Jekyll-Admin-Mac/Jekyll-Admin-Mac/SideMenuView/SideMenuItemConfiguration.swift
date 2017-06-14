//
//  SideMenuItemConfiguration.swift
//  Jekyll-Admin-Mac
//
//  Created by 张行 on 2017/6/9.
//  Copyright © 2017年 张行. All rights reserved.
//

import AppKit

struct SideMenuItemConfiguration {
    let title:String ///< 标题
    let iconHex:String ///< icon 的十六进制字符串
    let hidden:Bool ///< 是否隐藏底部线
    var selected:Bool ///< 是否被选中
    let normalColor:NSColor = NSColor(red:0.922, green:0.855, blue:0.757, alpha:1.000) ///< 默认状态颜色
    let selectedColor:NSColor = NSColor(red:1.000, green:0.600, blue:0.000, alpha:1.000) ///< 选中的颜色
}
