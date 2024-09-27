//
//  MLValidateTool.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/4/2.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import Foundation

/// 验证
enum MLValidate {
    case email(_: String)
    case phoneNum(_: String)
    case cardIDNum(_: String)
    case username(_: String)
    case password(_: String)
    case nickname(_: String)
    case URL(_: String)
    case IP(_: String)
    case pureNumer(_ : String)
    
    var isRight: Bool {
        var predicateStr:String!
        var currObject:String!
        switch self {
        case let .email(str):
            predicateStr = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
            currObject = str
        case let .phoneNum(str):
            predicateStr = "^1[0-9]{10}$"
            currObject = str
            ///20220113400052
        case let .cardIDNum(str):
//            predicateStr = "^[0-9]{7}$"
//            predicateStr = "^BL\\d{8}$"
            predicateStr = "^BL\\d{1,8}$"
            currObject = str
        case let .username(str):
            predicateStr = "^[A-Za-z0-9]{6,20}+$"
            currObject = str
        case let .password(str):
            predicateStr = "^[a-zA-Z0-9]{6,15}+$"
            currObject = str
        case let .nickname(str):
            predicateStr = "^[\\u4e00-\\u9fa5]{2,6}$"
            currObject = str
        case let .URL(str):
            predicateStr = "^(https?:\\/\\/)?([\\da-z\\.-]+)\\.([a-z\\.]{2,6})([\\/\\w \\.-]*)*\\/?$"
            currObject = str
        case let .IP(str):
            predicateStr = "^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"
            currObject = str
        case let .pureNumer(str):
            predicateStr = #"^\d+$"#
            currObject = str
        }

        
        let predicate =  NSPredicate(format: "SELF MATCHES %@" ,predicateStr)
        return predicate.evaluate(with: currObject)
    }
    
}
