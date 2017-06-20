//
//  BaseRequestApi.swift
//  Jekyll-Admin-Mac
//
//  Created by 张行 on 2017/6/16.
//  Copyright © 2017年 张行. All rights reserved.
//

import Foundation
import AlamofireObjectMapper
import Alamofire
import ObjectMapper


typealias BaseRequestResponseObjectCompletionHandle<T:BaseMappable> = (_ model:T?) -> Void
typealias BaseRequestResponseArrayCompletionHandle<T:BaseMappable> = (_ models:[T]) -> Void
typealias BaseRequestFailureCompletionHandle = (_ error:Error?) -> Void

protocol BaseRequestProtocol {
    associatedtype R:BaseMappable
    func loadObjectRequest(success:@escaping BaseRequestResponseObjectCompletionHandle<R>, failure:@escaping BaseRequestFailureCompletionHandle)
    func loadArrayRequest(success:@escaping BaseRequestResponseArrayCompletionHandle<R>, failure:@escaping BaseRequestFailureCompletionHandle)
}

class BaseRequestApi<T:BaseMappable>: BaseRequestProtocol {
    func loadArrayRequest(success: @escaping ([T]) -> Void, failure: @escaping BaseRequestFailureCompletionHandle) {
        Alamofire.request(self.URLFullPath(), method:self.requestMethod()).responseArray(keyPath:self.responseKeyPath) { (response:DataResponse<[R]>) in
            guard let value = response.value else {
                failure(response.error)
                return
            }
            success(value)
        }
    }

    func loadObjectRequest(success: @escaping (T?) -> Void, failure: @escaping (Error?) -> Void) {
        Alamofire.request(self.URLFullPath(),method:self.requestMethod()).responseObject(keyPath:self.responseKeyPath) { (response:DataResponse<R>) in
            guard let code = response.response?.statusCode, code == 200 else {
                failure(response.error)
                return
            }
            success(response.value)
        }
    }

    var responseKeyPath:String?
    var URL:String = "http://localhost:4000/_api"
    typealias R = T

    func URLPath() -> String {
        return ""
    }
    
    func URLFullPath() -> String {
        guard self.URLPath().characters.count > 0 else {
            return self.URL
        }
        return "\(self.URL)/\(self.URLPath())"
    }
    
    func requestMethod() -> HTTPMethod {
        return HTTPMethod.get
    }
}



