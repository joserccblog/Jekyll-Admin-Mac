//
//  GetPostListApi.swift
//  Jekyll-Admin-Mac
//
//  Created by 张行 on 2017/6/16.
//  Copyright © 2017年 张行. All rights reserved.
//

import Foundation
import AlamofireObjectMapper
import Alamofire
import ObjectMapper



class GetPostListApi: BaseRequestApi<PostDetail> {
    override func URLPath() -> String {
        return "collections/posts/entries"
    }
}

class PostDetail: NSObject, Mappable, BaseListViewDataSource {
    static func converModel(model: PostDetail) -> BaseListViewDataModel {
        let data = BaseListViewDataModel()
        data.title = model.title
        data.date = model.date
        data.fileName = model.name
        data.httpURL = model.httpURL
        return data
    }

    typealias M = PostDetail

    var path:String?
    var url:String?
    var id:String?
    var collection:String?
    var relativePath:String?
    var draft:Bool = false
    var categories:[String] = []
    var title:String?
    var date:String?
    var slug:String?
    var ext:String?
    var tags:[String] = []
    var layout:String?
    var httpURL:String?
    var apiURL:String?
    var name:String?
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        path <- map["path"]
        url <- map["url"]
        id <- map["id"]
        collection <- map["collection"]
        relativePath <- map["relative_path"]
        draft <- map["draft"]
        categories <- map["categories"]
        title <- map["title"]
        date <- map["date"]
        slug <- map["slug"]
        ext <- map["ext"]
        tags <- map["tags"]
        layout <- map["layout"]
        httpURL <- map["http_url"]
        apiURL <- map["api_url"]
        name <- map["name"]
    }
    
    
    
}
