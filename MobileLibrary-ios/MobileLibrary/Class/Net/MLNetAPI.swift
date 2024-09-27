//
//  MLNetAPI.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/4/7.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import Foundation


var ml_baseUrl :String{
    var url = ""
    #if DEBUG
    url = "http://localhost:8080/"
    #else
    url = "http://localhost:8080/"
    #endif
    return url
}

enum MLNetAPI {
    case homeData(userId: String)
    case login(iphone: String,readCardId: String ,passwd: String, loginType: Int)
    case regisetr(iphone: String,readCardId: String ,passwd: String)
    case updateUser(iphone: String,readCardId: String ,passwd: String)
    case logout(iphone: String,readCardId: String)
    case updateUserInfo(userId: String,userName: String,userSex: Int,iphone: String,dateTime: String,userUnit: String)
    case allBooks(userId: String)
    case bookInfo(userId: String,bookISBN: String)
    case searchBook(userId: String,searchKeyWord: String)
    case hotBookList(userId: String)
    case applyForBorrow(userId: String,recordBookTitle: String,recordBookAuthor: String,recordBookPress: String,recordBookISBN: String ,userName: String,userIphone: String,recordBorrowerTime: String,recordBackTime: String,bookType: Int,updateTime: String,bookInsideCode: String)
    case getBookRecordState(userId: String,recordBookISBN: String)
    case getAllBookRecord(userId: String,userRole: String)
    ///reacordBookState  0 未申请借阅  1已申请借阅，待图书馆理员审核  2 已通过审核，借阅成功了
    case allBookRecordStateInfo(userId: String,reacordBookState: Int)
    case updateBorrowBookRecordState(userId: String,recordId: Int)
    case backBook(userId: String,recordId: Int)
    case updateBorrowInfo(userId: String,recordBookTitle: String,recordBookAuthor: String,recordBookPress: String,recordBookISBN: String ,userName: String,userIphone: String,recordBorrowerTime: String,recordBackTime: String,bookType: Int,updateTime: String,recordId: Int,bookInsideCode: String)
    case addBook(userId: String,bookTitle: String,bookISBN: String,bookPress: String,bookAuthor: String,bookPrice: Double,bookTotalPage: Int,bookUploadTime: String,bookState: Int,bookBrief: String,bookType: Int,bookCover: String,bookLibTotal: Int,bookBackTotal: Int,bookCategory: String)
    case searchBookRecord(userId: String,userName: String,userIphone: String)
}

extension MLNetAPI :TargetType {
    var baseURL: URL {
        switch self {
        case .homeData:
            break
        case .login:
            break
        case .regisetr:
            break
        case .updateUser:
            break
        case .logout:
            break
        case .updateUserInfo:
            break
        case .allBooks:
            break
        case .bookInfo:
            break
        case .searchBook:
            break
        case .hotBookList:
            break
        case .applyForBorrow:
            break
        case .getBookRecordState:
            break
        case .getAllBookRecord:
            break
        case .allBookRecordStateInfo:
            break
        case .updateBorrowBookRecordState:
            break
        case .backBook:
            break
        case .updateBorrowInfo:
            break
        case .addBook:
            break
        case .searchBookRecord:
            break
        }
        return URL(string: ml_baseUrl)!
    }
    
    
    //测试数据
    var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
   
    var method: Moya.Method {
        switch self {
            
        default:
            return .post
        }
    }

    ///请求头
    var headers: [String : String]? {
        return self.generatePublicParams() as? [String : String]
//        return nil
    }
    
    ///服务器后台资源路径
    var path: String {
        switch self {
        case .homeData:
            return "app/home"
        case .login:
            return "app/login"
        case .regisetr:
            return "app/register"
        case .updateUser:
            return "app/updateUser"
        case .logout:
            return "app/logout"
        case .updateUserInfo:
            return "app/updateUserInfo"
        case .allBooks:
            return "app/allBooks"
        case .bookInfo:
            return "app/book"
        case .searchBook:
            return "app/searchBook"
        case .hotBookList:
            return "app/hotBookList"
        case .applyForBorrow:
            return "app/applyForBorrow"
        case .getBookRecordState:
            return "app/getBookRecordState"
        case  .getAllBookRecord:
            return "app/getAllBookRecord"
        case .allBookRecordStateInfo:
            return "app/allBookRecordStateInfo"
        case .updateBorrowBookRecordState:
            return "app/updateBorrowBookRecordState"
        case .backBook:
            return "app/backBook"
        case .updateBorrowInfo:
            return "app/updateBorrowInfo"
        case .addBook:
            return "app/addBook"
        case .searchBookRecord:
            return "app/searchBookRecord"
            
        default :
            MLDeugLog(message:"nil")
        }
    }
    
    
    var task: Moya.Task {
        var params: [String: Any] = [:]
        switch self {
        case let .homeData(userId):
            params["userId"] = userId
            
        case let .login(iphone,readCardId, passwd, loginType):
            params["iphone"] = iphone
            params["passwd"] = passwd
            params["readCardId"] = readCardId
            params["loginType"] = loginType
            
        case let .regisetr(iphone, readCardId, passwd):
        
            params["iphone"] = iphone
            params["passwd"] = passwd
            params["readCardId"] = readCardId
            
        case let .updateUser(iphone, readCardId, passwd):
            params["iphone"] = iphone
            params["passwd"] = passwd
            params["readCardId"] = readCardId
            
        case let .logout(iphone, readCardId):
            params["iphone"] = iphone
            params["readCardId"] = readCardId
        
        case let .updateUserInfo(userId, userName, userSex, iphone, dateTime, userUnit):
            params["userId"] = userId
            params["userName"] = userName
            params["userSex"] = userSex
            params["iphone"] = iphone
            params["dateTime"] = dateTime
            params["userUnit"] = userUnit
            
        case let .allBooks(userId):
            params["userId"] = userId
            
        case let .bookInfo(userId, bookISBN):
            params["userId"] = userId
            params["bookISBN"] = bookISBN
        case let .searchBook(userId, searchKeyWord):
            params["userId"] = userId
            params["searchKeyWord"] = searchKeyWord
        case let .hotBookList(userId):
            params["userId"] = userId
        
        case let .applyForBorrow(userId, recordBookTitle, recordBookAuthor, recordBookPress, recordBookISBN, userName, userIphone, recordBorrowerTime, recordBackTime,bookType,updateTime,bookInsideCode):
            params["userId"] = userId
            params["recordBookTitle"] = recordBookTitle
            params["recordBookAuthor"] = recordBookAuthor
            params["recordBookPress"] = recordBookPress
            params["recordBookISBN"] = recordBookISBN
            params["recordBorrower"] = userName
            params["userIphone"] = userIphone
            params["recordBorrowerTime"] = recordBorrowerTime
            params["recordBackTime"] = recordBackTime
            params["bookType"] = bookType
            params["updateTime"] = updateTime
            params["bookInsideCode"] = bookInsideCode
            
        case let .getBookRecordState(userId, recordBookISBN):
            params["userId"] = userId
            params["recordBookISBN"] = recordBookISBN
            
        case let .getAllBookRecord(userId, userRole):
            params["userId"] = userId
            params["userRole"] = userRole
            
        case let .allBookRecordStateInfo(userId, reacordBookState):
            params["userId"] = userId
            params["reacordBookState"] = reacordBookState
           
        case let .updateBorrowBookRecordState(userId, recordId):
            params["userId"] = userId
            params["recordId"] = recordId
          
        case let .backBook(userId, recordId):
            params["userId"] = userId
            params["recordId"] = recordId
            
        case let .updateBorrowInfo(userId, recordBookTitle, recordBookAuthor, recordBookPress, recordBookISBN, userName, userIphone, recordBorrowerTime, recordBackTime, bookType, updateTime, recordId,bookInsideCode):
            params["userId"] = userId
            params["recordBookTitle"] = recordBookTitle
            params["recordBookAuthor"] = recordBookAuthor
            params["recordBookPress"] = recordBookPress
            params["recordBookISBN"] = recordBookISBN
            params["recordBorrower"] = userName
            params["userIphone"] = userIphone
            params["recordBorrowerTime"] = recordBorrowerTime
            params["recordBackTime"] = recordBackTime
            params["bookType"] = bookType
            params["updateTime"] = updateTime
            params["recordId"] = recordId
            params["bookInsideCode"] = bookInsideCode
            
        case let .addBook(userId, bookTitle, bookISBN, bookPress, bookAuthor, bookPrice, bookTotalPage, bookUploadTime, bookState, bookBrief, bookType, bookCover, bookLibTotal, bookBackTotal, bookCategory):
            params["userId"] = userId
            params["bookTitle"] = bookTitle
            params["bookISBN"] = bookISBN
            params["bookPress"] = bookPress
            params["bookAuthor"] = bookAuthor
            params["bookPrice"] = bookPrice
            params["bookTotalPage"] = bookTotalPage
            params["bookUploadTime"] = bookUploadTime
            params["bookState"] = bookState
            params["bookBrief"] = bookBrief
            params["bookType"] = bookType
            params["bookCover"] = bookCover
            params["bookLibTotal"] = bookLibTotal
            params["bookBackTotal"] = bookBackTotal
            params["bookCategory"] = bookCategory
            
        case let .searchBookRecord(userId, userName, userIphone):
            params["userId"] = userId
            params["userName"] = userName
            params["userIphone"] = userIphone
            
        default:
            MLDeugLog(message: "--- nil ---")
          break
        }
        let heder = headers
        for (key ,value) in heder! {
            params[key] = value
        }
        //Task是一个枚举值，根据后台需要的数据，选择不同的http task。
        return .requestParameters(parameters: params, encoding: URLEncoding.default)
    }
    
    
    
    

    // MARK: - 只能在该类中使用
    /// - Returns: 公用参数
   private func generatePublicParams() -> [String :Any] {
//       设置默认的Accept头
//        let  acceptValues  = ["text/html",
//                        "text/plain",
//                        "application/json",
//                        "image/png",
//                        "mage/jpeg",
//                        "application/octet-stream",
//                        "text/json",
//                        "text/javascript"]
    
       let  acceptValues  = ["application/json"]
         let acceptHeader = acceptValues.joined(separator: ", ")

        return ["Accept": acceptHeader]
    }
            
}

