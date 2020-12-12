//
//  Api.swift
//  JingDataNetwork_Example
//
//  Created by Tian on 2018/8/29.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON

enum ApiService {
    case login(username:String,password:String)
    case user(userId:String)
    case userQuery(keyword:String)
}

extension ApiService:TargetType{
    // 定义请求的host
    var baseURL: URL {
        return URL(string: "http://127.0.0.1:8080")!
    }
    // 定义请求的路径
    var path: String {
        switch self {
        case .login(_, _):
            return "/account/login"
        case .user(let userId):
            return "user/\(userId)"
        case .userQuery(_):
            return "user/query"
        }
    }
    // 定义接口请求方式
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        case .user,.userQuery:
            return .get
        }
    }
    // 定义模拟数据
    var sampleData: Data {
        switch self {
        case .login(let username, _):
            return "{\"username\": \"\(username)\", \"id\": 100}".data(using: String.Encoding.utf8)!
        case .user(_):
            return "{\"username\": \"Wiki\", \"id\": 100}".data(using: String.Encoding.utf8)!
        case .userQuery(_):
            return "{\"username\": \"Wiki\", \"id\": 100}".data(using: String.Encoding.utf8)!
        }
    }
    // 构建参数
    var task: Task {
        switch self {
        case .login(let username, let passowrd):
            return .requestParameters(parameters: ["username": username,"passowrd": passowrd], encoding: URLEncoding.default)
        case .user(_):
            return .requestPlain
        case .userQuery(let keyword):
            return .requestParameters(parameters: ["keyword": keyword], encoding: URLEncoding.default)
        }
    }
    // 构建请求头部
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
