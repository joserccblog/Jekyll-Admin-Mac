//
//  SideMenuView.swift
//  Jekyll-Admin-Mac
//
//  Created by 张行 on 2017/6/7.
//  Copyright © 2017年 张行. All rights reserved.
//

import Cocoa
import FontAwesomeIconFactory

typealias SideMenuViewSelectMenuIndexCompletionHandle = (_ index:Int) -> Void

class SideMenuView: NSView, NSTableViewDataSource, NSTableViewDelegate {
    
    @IBOutlet weak var view: BaseView!
    @IBOutlet weak var tableView: NSTableView!
    
    private var currentMenuIndex:Int = 0
    
    var selectMenuCompletionHandle:SideMenuViewSelectMenuIndexCompletionHandle? {
        didSet {
            guard let selectMenuCompletionHandle = self.selectMenuCompletionHandle else {
                return
            }
            selectMenuCompletionHandle(currentMenuIndex)
        }
    }
    var menuItems = [
        SideMenuItemConfiguration(title: "文章", iconHex: "F02D", hidden: true, selected: false, normalColor: NSColor(red:0.922, green:0.855, blue:0.757, alpha:1.000)),
        SideMenuItemConfiguration(title: "页面", iconHex: "F15C", hidden: false, selected: false, normalColor: NSColor(red:0.922, green:0.855, blue:0.757, alpha:1.000)),
        SideMenuItemConfiguration(title: "数据", iconHex: "F1C0", hidden: true, selected: false, normalColor: NSColor(red:0.922, green:0.855, blue:0.757, alpha:1.000)),
        SideMenuItemConfiguration(title: "文件", iconHex: "F15B", hidden: false, selected: false, normalColor: NSColor(red:0.922, green:0.855, blue:0.757, alpha:1.000)),
        SideMenuItemConfiguration(title: "配置", iconHex: "F013", hidden: true, selected: false, normalColor: NSColor(red:0.922, green:0.855, blue:0.757, alpha:1.000)),
    ]
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.loadXibView()
        changeTabeleViewState(row: 0, tableView: self.tableView)
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.loadXibView()
    }
    
    @IBAction func didClickRow(_ sender: NSTableView) {
        let row = sender.selectedRow
        changeTabeleViewState(row: row, tableView: sender)
    }
    
    func changeTabeleViewState(row:Int, tableView:NSTableView) {
        currentMenuIndex = row
        for (index, var configuration) in menuItems.enumerated() {
            configuration.selected = index == row
            menuItems[index] = configuration
        }
        tableView.reloadData()
        if let completionHandle = self.selectMenuCompletionHandle {
            completionHandle(row)
        }
    }
    
    public func numberOfRows(in tableView: NSTableView) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let view = tableView.make(withIdentifier: "SideMenuItemView", owner: self) as? SideMenuItemView else {
            return nil
        }
        let configuration = menuItems[row]
        view.menuItemConfiguration = configuration
        return view
    }
    
    override func prepareForInterfaceBuilder() {
    }
    
}
