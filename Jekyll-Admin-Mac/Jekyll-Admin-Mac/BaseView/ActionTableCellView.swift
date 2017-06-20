//
//  ActionTableCellView.swift
//  Jekyll-Admin-Mac
//
//  Created by 张行 on 2017/6/16.
//  Copyright © 2017年 张行. All rights reserved.
//

import Cocoa

typealias ActionTableCellViewDeleteSuccessCompletionHandle = (_ view:ActionTableCellView) -> Void

class ActionTableCellView: NSTableCellView {
    @IBOutlet weak var deleteItemView: SideMenuItemView! {
        didSet {
            self.deleteItemView.addClick { (view) in
                guard let fileName = self.fileName, let window = NSApplication.shared().keyWindow else {
                    return
                }
                let alert = NSAlert()
                alert.messageText = "确定要删除\(fileName)"
                alert.addButton(withTitle: "删除")
                alert.addButton(withTitle: "取消")
                alert.beginSheetModal(for: window, completionHandler: { (response) in
                    if response == NSAlertFirstButtonReturn {
                        self.deletePost(fileName: fileName)
                    }
                })
            }
            
            
        }
    }
    @IBOutlet weak var lookItemView: SideMenuItemView! {
        didSet {
            self.addLookView()
        }
    }
    
    var deleteSuccessCompletionHandle:ActionTableCellViewDeleteSuccessCompletionHandle?
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.loadXibView()
        self.configurationView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.loadXibView()
        self.configurationView()
    }
    
    var fileName:String?
    var httpURL:String?
    
    func configurationView() {
        let configurationDelete = SideMenuItemConfiguration(title: "删除", iconHex: "F1F8", hidden: true, selected: false, normalColor: NSColor.white)
        let configurationLook = SideMenuItemConfiguration(title: "查看", iconHex: "F06E", hidden: true, selected: false, normalColor: NSColor.white)
        self.deleteItemView.menuItemConfiguration = configurationDelete
        self.lookItemView.menuItemConfiguration = configurationLook
    }
    
    func deletePost(fileName:String) {
        let api = DeletePostDetail(name: fileName)
        api.loadObjectRequest(success: { (response) in
            guard let completionHandle = self.deleteSuccessCompletionHandle else {
                return
            }
            completionHandle(self)
        }) { (error) in
            
        }
    }
    
    func addLookView() {
        self.lookItemView.addClick { (view) in
            guard let urlString = self.httpURL, let url = URL(string: urlString)  else {
                return
            }
            NSWorkspace.shared().open(url)
        }
    }
}
