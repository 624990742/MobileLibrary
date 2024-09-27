//
//  MLUserInfoManager.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/4/2.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import UIKit

class MLUserInfoManager {
  
    
    /// 用户id
    class var userId: String? {
        get {
            return UserDefaults.AccountInfo.string(forKey: .userId)
        }
        set {
            UserDefaults.AccountInfo.set(value: newValue, forKey: .userId)
        }
    }
    
    ///
    class var userName: String? {
        get {
            return UserDefaults.AccountInfo.string(forKey: .userName)
        }
        set {
            UserDefaults.AccountInfo.set(value: newValue, forKey: .userName)
        }
    }
    
    class var userIphone: String? {
        get {
            return UserDefaults.AccountInfo.string(forKey: .userIphone)
        }
        set {
            UserDefaults.AccountInfo.set(value: newValue, forKey: .userIphone)
        }
    }
    
    class var userRole: String? {
        get {
            return UserDefaults.AccountInfo.string(forKey: .userRole)
        }
        set {
            UserDefaults.AccountInfo.set(value: newValue, forKey: .userRole)
        }
    }
    
    class var cardId: String? {
        get {
            return UserDefaults.AccountInfo.string(forKey: .cardId)
        }
        set {
            UserDefaults.AccountInfo.set(value: newValue, forKey: .cardId)
        }
    }
    
    
    class var userSex: String? {
        get {
            
            var str = "女"
            guard let userSex = UserDefaults.AccountInfo.string(forKey: .userSex) else {
                return str
            }
            if Int(userSex) == 1 {
                str = "男"
            }else{
                str = "女"
            }
            return str
        }
        set {
            UserDefaults.AccountInfo.set(value: newValue, forKey: .userSex)
        }
    }
    
    
    
    class var userIcon: String? {
        get {
            return UserDefaults.AccountInfo.string(forKey: .userIcon)
        }
        set {
            UserDefaults.AccountInfo.set(value: newValue, forKey: .userIcon)
        }
    }
    
    class var employeeId: String? {
        get {
            return UserDefaults.AccountInfo.string(forKey: .employeeId)
        }
        set {
            UserDefaults.AccountInfo.set(value: newValue, forKey: .employeeId)
        }
    }
    
    class var readCardId: String? {
        get {
            return UserDefaults.AccountInfo.string(forKey: .readCardId)
        }
        set {
            UserDefaults.AccountInfo.set(value: newValue, forKey: .readCardId)
        }
    }
    
    
    class var userUnit: String? {
        get {
            return UserDefaults.AccountInfo.string(forKey: .userUnit)
        }
        set {
            UserDefaults.AccountInfo.set(value: newValue, forKey: .userUnit)
        }
    }
    
    class var borrowStartDate: String? {
        get {
            return UserDefaults.AccountInfo.string(forKey: .borrowStartDate)
        }
        set {
            UserDefaults.AccountInfo.set(value: newValue, forKey: .borrowStartDate)
        }
    }
    
    
    
    
//
//   ///登录成功保存用户信息
//    static  func setupLoginSuccessInfo(entity :[String :Any]?,success :() ->()){
//        guard let entity = entity else {
//            MLAlert.show(type: .info, text: "数据出错,请重试")
//            return }
//
//        if let name = entity["userName"] {
//            UserDefaults.AccountInfo.set(value: name, forKey: .userName)
//        }
//        if let mobile = entity["mobile"] {
//            UserDefaults.AccountInfo.set(value: mobile, forKey: .userIphone)
//        }
//        if let userId = entity["userId"] {
//            UserDefaults.AccountInfo.set(value: userId, forKey: .userId)
////            self.userId = (userId as? String)
//        }
//        if let userId = entity["userPassword"] {
//            UserDefaults.AccountInfo.set(value: userId, forKey: .userPassword)
//        }
//
//        TProgressHUD.hide()
//        success()
//    }

    
    static  func setupLoginSuccessInfo(infoModel :MLUserInfoModel,success :() ->()){
    

        if  infoModel.userId.isEmpty {
            MLAlert.show(type: .info, text: "数据出错,请重新登录")
            return
        }
        
        if !infoModel.userPassword.isEmpty {
            UserDefaults.AccountInfo.set(value: infoModel.userPassword, forKey: .userPassword)
        }
        if !infoModel.userName.isEmpty {
            UserDefaults.AccountInfo.set(value: infoModel.userName, forKey: .userName)
        }
        if !infoModel.userIphone.isEmpty {
            UserDefaults.AccountInfo.set(value: infoModel.userIphone, forKey: .userIphone)
        }
        if  !infoModel.userId.isEmpty {
            UserDefaults.AccountInfo.set(value: infoModel.userId, forKey: .userId)
        }
        
        if  !infoModel.userEmail.isEmpty {
            UserDefaults.AccountInfo.set(value: infoModel.userEmail, forKey: .userEmail)
        }
        
        if  (infoModel.userSex != 0) {
            UserDefaults.AccountInfo.set(value: infoModel.userSex, forKey: .userSex)
        }
        
        if  !infoModel.borrowStartDate.isEmpty {
            UserDefaults.AccountInfo.set(value: infoModel.borrowStartDate, forKey: .borrowStartDate)
        }
        
        if  !infoModel.userUnit.isEmpty {
            UserDefaults.AccountInfo.set(value: infoModel.userUnit, forKey: .userUnit)
        }
        if  !infoModel.userIcon.isEmpty {
            UserDefaults.AccountInfo.set(value: infoModel.userIcon, forKey: .userIcon)
        }

        if  !infoModel.userRole.isEmpty {
            UserDefaults.AccountInfo.set(value: infoModel.userRole, forKey: .userRole)
        }
        
        if  !infoModel.employeeId.isEmpty {
            UserDefaults.AccountInfo.set(value: infoModel.employeeId, forKey: .employeeId)
        }
        
        if  !infoModel.readCardId.isEmpty {
            UserDefaults.AccountInfo.set(value: infoModel.readCardId, forKey: .readCardId)
        }
    
        
        if  !infoModel.borrowStartDate.isEmpty {
            UserDefaults.AccountInfo.set(value: infoModel.borrowStartDate, forKey: .borrowStartDate)
        }
        
        if  !infoModel.userUnit.isEmpty {
            UserDefaults.AccountInfo.set(value: infoModel.userUnit, forKey: .userUnit)
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: ML_LOGIN_SUCCESS), object: nil)
        TProgressHUD.hide()
        success()
    }
    
    
    
    /// 退出登录
    class func logout(success:@escaping ()->(),failure :@escaping (String)->()) -> Void {
       
//            let time = String(Int64(Date().timeIntervalSince1970 * 1000))
//            UserDefaults.AccountInfo.set(value: time, forKey: .logoutTime)
            UserDefaults.AccountInfo.remove(forkey: .userPassword)
            UserDefaults.AccountInfo.remove(forkey: .cardId)
            UserDefaults.AccountInfo.remove(forkey: .userIphone)
            UserDefaults.AccountInfo.remove(forkey: .userId)
            UserDefaults.AccountInfo.remove(forkey: .userName)
            UserDefaults.AccountInfo.remove(forkey: .userRole)
            self.userId = nil
        success();
    }
    
}





extension UserDefaults {
    
    // 账户信息
    struct AccountInfo: MLUserDefaultsSettable {
        enum DefaultKeys: String {
            case userId
            case userName
            case userSex
            case userIphone
            case userEmail
            case userAge
            case userPassword
            case userRole
            case userState
            case cardId
            case readCardId
            case userUnit
            case breakNumber
            case adminLeve
            case borrowMaxNumber
            case borrowStartDate
            case borrowDay
            case fineMoney
            case employeeId
            case loginTime
            case userIcon
        }
    }
 
}

//MARK: -   后续可以在里边增加自定义判断
protocol MLUserDefaultsSettable {
    associatedtype DefaultKeys: RawRepresentable
}

extension MLUserDefaultsSettable where DefaultKeys.RawValue==String {
    
    static func set(value: Any?, forKey key: DefaultKeys) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
    static func dictionary(forKey key:DefaultKeys) -> [String : Any]? {
        
        return UserDefaults.standard.dictionary(forKey: key.rawValue)
    }
    static func array(forKey key:DefaultKeys) -> [Any]? {
        return UserDefaults.standard.array(forKey: key.rawValue)
    }
    static func string(forKey key: DefaultKeys) -> String? {
        return UserDefaults.standard.string(forKey: key.rawValue)
    }
    
    static func int(forKey key: DefaultKeys) -> Int {
        
        return UserDefaults.standard.integer(forKey: key.rawValue)
    }
    static func bool(forKey key :DefaultKeys) -> Bool {
        return UserDefaults.standard.bool(forKey: key.rawValue)
    }
    static func remove(forkey key: DefaultKeys) -> Void {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    ///返回keys
    private static func getCurrentKey(key :DefaultKeys) -> DefaultKeys {
        
        return key
    }
    
}


