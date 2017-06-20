//
//  DateTableCellView.swift
//  Jekyll-Admin-Mac
//
//  Created by 张行 on 2017/6/16.
//  Copyright © 2017年 张行. All rights reserved.
//

import Cocoa

class DateTableCellView: NSTableCellView {
    @IBOutlet weak var dateLabel: NSTextField!
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.loadXibView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.loadXibView()
    }
    
    func configuration(dateString:String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm:ss zzzz"
        guard let date = formatter.date(from: dateString) else {
            return
        }
        formatter.dateFormat = "MMM dd,yyyy"
        self.dateLabel.stringValue = formatter.string(from: date)
    }
    
}
