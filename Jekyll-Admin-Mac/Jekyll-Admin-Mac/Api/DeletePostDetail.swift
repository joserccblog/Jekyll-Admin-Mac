//
//  DeletePostDetail.swift
//  Jekyll-Admin-Mac
//
//  Created by 张行 on 2017/6/20.
//  Copyright © 2017年 张行. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire

class DeletePostDetail: BaseRequestApi<DeletePostDetailResponse> {
    override func URLPath() -> String {
        return "collections/posts/\(self.name)"
    }
    
    let name:String
    
    init(name:String) {
        self.name = name
    }
    
    override func requestMethod() -> HTTPMethod {
        return HTTPMethod.delete
    }
}

class DeletePostDetailResponse: BaseMappable  {
    func mapping(map: Map) {
        
    }
}
