//
//  BaseListView.swift
//  Jekyll-Admin-Mac
//
//  Created by 张行 on 2017/6/13.
//  Copyright © 2017年 张行. All rights reserved.
//

import Cocoa
import ObjectMapper

protocol BaseListViewDataSource {
    associatedtype M:BaseMappable ///< 泛型类型
    static func converModels(models:[M]) -> [BaseListViewDataModel] ///< 将其他类型对象数组转换成BaseListViewDataModel对象数组
    static func converModel(model:M) -> BaseListViewDataModel ///< 将其他类型转换成BaseListViewDataModel对象
}

extension BaseListViewDataSource {
    static func converModels(models:[M]) -> [BaseListViewDataModel] {
        var datas:[BaseListViewDataModel] = []
        for model in models {
            let data = self.converModel(model: model)
            datas.append(data)
        }
        return datas
    }
}

class BaseListViewDataModel {
    var title:String? ///< 显示标题
    var date:String? ///< 显示时间
    var fileName:String? ///< Markdown 的文件名称
    var httpURL:String? ///< 文章的地址
}

@IBDesignable
class BaseListView: NSView, NSTableViewDataSource, NSTableViewDelegate, NSTextFieldDelegate {
    
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var header: ContentHeader! {
        didSet {
            NotificationCenter.default.addObserver(self, selector: #selector(self.searchFiledTextChanged(notification:)), name: NSNotification.Name.NSControlTextDidChange, object: nil)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
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
    
    var models:[BaseListViewDataModel] = [] {
        didSet {
            self.settingFilterModels()
        }
    }
    
    private var filterModels:[BaseListViewDataModel] = []
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.loadXibView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.loadXibView()
        guard let headerValue1 = self.header.headerContent as? ContentHeaderValue1 else {
            return
        }
        headerValue1.searchFiled.delegate = self
    }
 
    public func numberOfRows(in tableView: NSTableView) -> Int {
        return self.filterModels.count
    }
    
    public func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let identifier = tableColumn?.identifier else {
            return nil
        }
        let model = self.filterModels[row]
        let view = tableView.make(withIdentifier: identifier, owner: self)
        if let iconTitle = view as? IconTitleTableCellView, let title = model.title {
            iconTitle.configurationView(title: title)
        }
        if let dateView = view as? DateTableCellView, let date = model.date {
            dateView.configuration(dateString: date)
        }
        if let actionView = view as? ActionTableCellView {
            actionView.fileName = model.fileName
            actionView.httpURL = model.httpURL
            actionView.deleteSuccessCompletionHandle = { [weak self] (view1) in
                self?.models.remove(at: row)
                self?.tableView.reloadData()
            }
        }
        return view
    }
    
    override func prepareForInterfaceBuilder() {
        self.title = "文章"
        self.header.prepareForInterfaceBuilder()
    }
    
    
    func searchFiledTextChanged(notification:Notification) {
        guard let filed = notification.object as? NSTextField else {
            return
        }
        
        guard let headerValue1 = self.header.headerContent as? ContentHeaderValue1 else {
            return
        }
        
        guard filed == headerValue1.searchFiled else {
            return
        }
        self.filterDataModels(filter: filed.stringValue)
    }
    
    func filterDataModels(filter:String) {
        self.filterModels.removeAll()
        if filter.characters.count == 0 {
            self.filterModels.append(contentsOf: self.models)
        } else {
            for model in self.models {
                if let _ = model.title?.range(of: filter) {
                    self.filterModels.append(model)
                }
            }
        }
        self.tableView.reloadData()
    }
    
    func settingFilterModels() {
        guard let headerValue1 = self.header.headerContent as? ContentHeaderValue1 else {
            return
        }
        let filterText = headerValue1.searchFiled.stringValue
        self.filterDataModels(filter: filterText)
    }
}


