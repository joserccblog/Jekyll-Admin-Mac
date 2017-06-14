//
//  ViewController.swift
//  Jekyll-Admin-Mac
//
//  Created by 张行 on 2017/6/7.
//  Copyright © 2017年 张行. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var navigationBar: NavigationBar!
    @IBOutlet weak var rightContentView: NSView!
    
    var views:[NSView] = []
    
    var sideMenuIndex:Int = -1
    
    @IBOutlet weak var sideMenu: SideMenuView! {
        didSet {
            self.sideMenu.selectMenuCompletionHandle = { [weak self] index in
                self?.changeContentView(index: index)
                self?.sideMenuIndex = index
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addViews(viewType: PostsView.self)
        self.changeContentView(index: self.sideMenuIndex)
        let getConfigurationApi = GetConfigurationApi()
        getConfigurationApi.loadRequest(success: { [weak self] (configuration) in
            guard let title = configuration.title else {
                return
            }
            self?.navigationBar.blogMenuItem.itemTitle.stringValue = title
        }) { (error) in
            
        }
    }
    
    func addViews(viewType:NSView.Type) {
        let posts = viewType.init(frame: self.rightContentView.bounds)
        posts.autoresizingMask = [.viewWidthSizable,.viewHeightSizable]
        self.views.append(posts)
    }
    
    func changeContentView(index:Int) {
        for view in self.rightContentView.subviews {
            view.removeFromSuperview()
        }
        guard self.views.count > index && index >= 0 else {
            return
        }
        let addView = self.views[index]
        self.rightContentView.addSubview(addView)
    }

}

