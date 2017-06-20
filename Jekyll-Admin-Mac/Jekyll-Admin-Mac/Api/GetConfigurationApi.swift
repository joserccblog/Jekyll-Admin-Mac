//
//  GetConfigurationApi.swift
//  Jekyll-Admin-Mac
//
//  Created by 张行 on 2017/6/10.
//  Copyright © 2017年 张行. All rights reserved.
//

import Foundation
import AlamofireObjectMapper
import Alamofire
import ObjectMapper

class GetConfigurationApi: BaseRequestApi<JekyllConfiguration> {
    override func URLPath() -> String {
        return "configuration"
    }
    
    override var responseKeyPath: String? {
        get {
            return "content"
        }
        set {
            self.responseKeyPath = newValue
        }
    }
}

class JekyllConfiguration: Mappable {
    var title:String?
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        title <- map["title"]
    }
}
