//
//  AppDelegate.swift
//  Jekyll-Admin-Mac
//
//  Created by 张行 on 2017/6/7.
//  Copyright © 2017年 张行. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        for window in sender.windows {
            window.makeKeyAndOrderFront(self)
        }
        return true
    }

}

