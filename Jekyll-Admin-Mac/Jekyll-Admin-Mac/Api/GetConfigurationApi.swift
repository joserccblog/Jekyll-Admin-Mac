//
//  GetConfigurationApi.swift
//  Jekyll-Admin-Mac
//
//  Created by 张行 on 2017/6/10.
//  Copyright © 2017年 张行. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

typealias GetConfigurationApiSuccessCompletionHandle = (_ configuration:JekyllConfiguration) -> Void
typealias GetConfigurationApiFailureCompletionHandle = (_ error:Error?) -> Void

class GetConfigurationApi {
    func loadRequest(success:GetConfigurationApiSuccessCompletionHandle?, failure:GetConfigurationApiFailureCompletionHandle?) {
        Alamofire.request("http://localhost:4000/_api/configuration", method: .get).responseJSON { (response) in
            switch response.result {
                case .success(let value):
                    guard let valueDic = value as? [String:Any] else {
                        self.completionHandle(success: nil, failure: failure, configuration: nil, error: nil);
                        return
                    }
                    guard let content = valueDic["content"] as? [String:Any] else {
                        self.completionHandle(success: nil, failure: failure, configuration: nil, error: nil);
                        return
                    }
                    guard let configuration = JekyllConfiguration(JSON: content) else {
                        self.completionHandle(success: nil, failure: failure, configuration: nil, error: nil);
                        return
                    }
                    self.completionHandle(success: success, failure: nil, configuration: configuration, error: nil)
                case .failure(let error):
                    self.completionHandle(success: nil, failure: failure, configuration: nil, error: error)
            }
        }
    }
    
    func completionHandle(success:GetConfigurationApiSuccessCompletionHandle?, failure:GetConfigurationApiFailureCompletionHandle?, configuration:JekyllConfiguration?, error:Error?) {
        if let success = success , let configuration = configuration{
            success(configuration)
        } else if let failure = failure {
            failure(error)
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


