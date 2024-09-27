//
//  workModel.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/3/9.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import Foundation

class MLWorkModel :MLBaseSwiftModel {
    var name: String!
    var iconName: String!
    var child = [MLWorkModel]()
    
    
    func mapping(mapper: HelpingMapper) {
        
        
    }
//    ///转换完成
//    func didFinishMapping() {
//        
//    }
    
    required init() {
    }
}

///管理员和读者信息
class MLReaderAndManagerPeopleInfoModel :MLBaseSwiftModel {
    var id = 0
    var userName = ""
    var userIphone = ""
    var userEmail = ""
    var userState = 1
    var userRole = ""
    var userIcon = ""
    var readCardId = ""
    var employeeId = ""
    var userSex = 1
 
    func mapping(mapper: HelpingMapper) {
    }
    required init() {
    }
}




class MLUserInfoModel: MLBaseSwiftModel {
        // 用户唯一标识符
        var userId: String = ""
       
        // 头像
        var userIcon: String = ""
    
        // 用户名称
        var userName: String = ""
        
        // 性别，1代表男性，2代表女性
        var userSex: Int = 0
        
        // 用户年龄，以字符串形式表示
        var userAge: String = ""
        
        // 用户手机号码（11位）
        var userIphone: String = ""
        
        // 用户电子邮箱地址
        var userEmail: String = ""
        
        // 用户密码（6到18位字符）
        var userPassword: String = ""
        
        // 用户角色，可取值为："superAdmin"（超级管理员）、"admin"（普通管理员）、"reader"（读者）
        var userRole: String = ""
        
        // 用户状态，0表示禁止，1表示正常
        var userState: Int = 1 // Consider using a Bool if appropriate for your context
        
        // 身份证号码
        var cardId: String = ""
        
        // 借阅证号
        var readCardId: String = ""
        
        // 用户所属单位名称
        var userUnit: String = ""
        
        // 违约次数
        var breakNumber: Int = 6
        
        // 管理员负责的图书类别范围（1: 数理化，2: 语文、历史、地理、政治，3: 杂志、外刊）
        var adminLevel: Int = 0
        
        // 最大允许借阅书籍数量
        var borrowMaxNumber: Int = 10
        
        // 借阅开始日期，以字符串形式表示
        var borrowStartDate: String = ""
        
        // 借阅天数
        var borrowDay: Int = 0
        
        // 罚款金额
        var fineMoney: Int = 0
        
        // 员工ID
        var employeeId: String = ""
    
    required init() {
    }
}

///借阅记录
class MLBookRecordInfoModel: MLBaseSwiftModel {
    // 主键
    var recordId: Int = 0

    // 书名
    var recordBookTitle: String = ""
    //作者
    var recordBookAuthor: String = ""

    // ISBN
    var recordBookISBN: String = ""

    // 借阅人
    var recordBorrower: String = ""
    
    var recordBookPress: String = ""

    // 借阅时间（假设存储为字符串格式的日期时间）
    var recordBorrowerTime: String = ""

    // 归还时间（假设存储为字符串格式的日期时间）
    var recordBackTime: String = ""

    // 图书类别
    var bookType: Int = 0

    // 用户ID
    var userId: String = ""

    // 用户名
//    var userName: String = ""

    // 用户手机号
    var userIphone: String = ""

    // 创建时间
    var createTime: String = ""

    // 更新时间
    var updateTime: String = ""
    
    var reacordBookState: Int = 0
    
    var bookInsideCode: String = ""
    required init() {
    }
}



class MLBorrowBooksModel: MLBaseSwiftModel {
    
    var sec: Int = 0
    var row: Int = 0
    var title: String = ""
    var titleValue: String = ""
    
    required init() {
    }
}
