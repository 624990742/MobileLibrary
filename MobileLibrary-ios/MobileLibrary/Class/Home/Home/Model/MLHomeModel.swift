//
//  MLHomeModel.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/3/28.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import Foundation
class MLHomeModel  : MLBaseSwiftModel{
    ///名字
    var name: String!
    ///封面
    var icon: String!
    ///作者
    var author: String!
    ///出版社
    var publicTitle: String!
    func mapping(mapper: HelpingMapper) {   
        
    }
}

///图书类型
class MLBookInfoModel  : MLBaseSwiftModel{
        // 图书编码
        var bookId: Int = 0
          
        // 书本名称
        var bookTitle: String = ""
          
        // 图书标准ISBN编号
        var bookISBN: String = ""
          
        // 图书出版社
        var bookPress: String = ""
          
        // 图书作者
        var bookAuthor: String = ""
          
        // 图书价格
        var bookPrice: Double = 0.0
          
        // 图书总页数（这里应该使用整数类型，而非字符串）
        var bookTotalPage: Int = 0 // 注意：这里假设总页数是整数，所以使用了 Int 类型
          
        // 图书上架时间（使用 Date 类型而非字符串更为合适）
        var bookUploadTime: String = "" // 注意：这里使用了 Date 类型来存储时间
          
        // 图书状态（0：可借阅，1:已借出，2：归还中，3：已下架）
        var bookState: Int = 0
          
        // 图书简介（这里使用 String 类型而非整数类型，可能是个错误）
        var bookBrief: String = "" // 注意：这里假设图书简介是文本，所以使用了 String 类型
          
        // 类别（例如：0:数理化、1：社会科学、2：历史）
        var bookType: Int = 0
          
        // 图书封面（通常是图片的URL或本地文件路径）
        var bookCover: String = ""
          
        // 图书库存总数
        var bookLibTotal: Int = 0
          
        // 已经归还数目
        var bookBackTotal: Int = 0
          
        // 图书中文分类
        var bookCategory: String = ""
       //图书编码
       var  bookInsideCode: String = ""
    
  
}
