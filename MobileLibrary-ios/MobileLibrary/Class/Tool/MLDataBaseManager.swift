//
//  MLDataBaseManager.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/4/9.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import Foundation
import FMDB
import SwiftUI

class MLDataManager: NSObject {
static let shareManager = MLDataManager()
var fmdb:FMDatabase!
var fmdbQue:FMDatabaseQueue!
let lock = NSLock()

//1.重写父类的构造方法
override init() {
    super.init()
    //设置数据库的路径;fmdb.sqlite是由自己随意命名
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let sourceDatabasePath = Bundle.main.path(forResource: "MobileLibrary", ofType: "db")!
    let sourceDatabaseURL = URL(fileURLWithPath: sourceDatabasePath)
    
    let databasePath = documentsDirectory.appendingPathComponent("MobileLibrary.db")
    
    
    do {
        let fileExists =  FileManager.default.fileExists(atPath: databasePath.path)
        if !fileExists {
            try FileManager.default.copyItem(at: sourceDatabaseURL, to: databasePath)
            print("Database copied to the Documents directory.")
        } else {
            print("Database already exists in the Documents directory.")
        }
    } catch {
        print("Error copying database: \(error)")
    }
    
    
    
    //构造管理数据库的对象
    fmdb = FMDatabase(url: databasePath)
    fmdbQue = FMDatabaseQueue(url: databasePath)
    //判断数据库是否打开成功;如果打开失败则需要创建数据库
    if !fmdb.open() {
        MLDeugLog(message: "数据库打开失败")
        createDB()
        return
    }
}

    func option(){
        MLDeugLog(message: "拷贝数据库")
    }
    
    func createDB(){
        let createSql = MLDataManager.USERINFO_TABLE
        do {
            try fmdb.executeUpdate(createSql, values: nil)
        }catch {
            MLDeugLog(message: fmdb.lastErrorMessage())
        }
    }
    
    
//2.增
    func insertData(tableName: String,dict:[String: Any]) -> Bool {

        var state = false
    //加锁操作
    lock.lock()
    //(?,?)表示需要传的值，对应前面出现几个字段，后面就有几个问号
    if openDatabase(){
        let insetSql = self.getInserSql(table: tableName, dict: dict)
        let values = self.getValues(dict: dict)
    do {
        try fmdb.executeUpdate(insetSql, values: values)
        state = true
    }catch {
        MLDeugLog(message: fmdb.lastErrorMessage())
        state = false
     }
    }
    //解锁
    lock.unlock()
    return state
}
    
    
    
    

//3.删
    func deleteDataWith(tableName: String,conditions:[String: String]) {

    lock.lock()
        
        var deleteSql = "\(MLDataManager.ML_DELETE_TABLE_SQL) " + " " +  "\(tableName)"
        var bindings: [Any] = []
        var whereClauses: [String] = []
        for (column, value) in conditions {
            let placeholder = "?"
            whereClauses.append("\(column) = \(placeholder)")
            bindings.append(value)
        }

        if !whereClauses.isEmpty {
            deleteSql += " WHERE \(whereClauses.joined(separator: " AND "))"
        }
        
        
    do{
      
        try fmdb.executeUpdate(deleteSql, values: bindings)
    }catch {
        MLDeugLog(message: fmdb.lastErrorMessage())
    }
    
    //解锁
    lock.unlock()
}
//
////4.改
//    func updateDataWith(dict:[String: String]) {
//
//    //加锁
//    lock.lock()
//    //where id = ?中的id可传可不传
//    let updateSql = "update student set userName = ?,passWord = ? where id = ?"
//    //更新数据库
//    do{
//        let keys = dict.keys
//        let values = dict.values
//        try fmdb.executeUpdate(updateSql, values: [keys,values])
//    }catch {
//        MLDeugLog(message: fmdb.lastErrorMessage())
//    }
//
//    //解锁
//    lock.unlock()
//}
    
  

   ///更新数据
    func updateData(tableName: String, primaryKeyColumn: String, primaryKeyValue: Any, updates: [String: Any]) -> Bool {
        var state = true
        lock.lock()
        let columnsAndValues = updates.map { (key, value) in
            return "\(key)=?"
        }.joined(separator: ", ")

        // 构建参数化UPDATE语句
        let updateQuery = """
            UPDATE \(tableName)
            SET \(columnsAndValues)
            WHERE \(primaryKeyColumn)=?
        """

        var arguments: [Any] = []
        for value in updates.values {
            arguments.append(value)
        }
        arguments.append(primaryKeyValue)
        
        fmdbQue.inTransaction { db,arg  in
            if db.executeUpdate(updateQuery, withArgumentsIn: arguments){
                state = true
                    MLDeugLog(message: "更新成功")
                  }else{
                    MLDeugLog(message: "更新失败")
                      state = false
                }
            }
        lock.unlock()
        return state
    }

  
    
    
    
    
    
    

//5.判断数据库中是否有当前数据(查找一条数据)
    func isHasDataInTable(dict:[String: String]) -> [MLUserInfoModel] {

    var tempArray = [MLUserInfoModel]()
    let isHas = "select * from student where userName = ?"
    do{
        let set = try fmdb.executeQuery(isHas, values: [dict.keys])
        if set.next() {
            let model = MLUserInfoModel()
            //给字段赋值
            model.userName = set.string(forColumn: "userName") ?? ""
            model.userPassword = set.string(forColumn: "userPassword") ?? ""
            model.userSex  = Int(set.int(forColumn: "userSex") )
            model.userAge = set.string(forColumn: "userAge") ?? ""
            model.userIphone = set.string(forColumn: "userIphone") ?? ""
            model.userEmail = set.string(forColumn: "userEmail") ?? ""
            model.userRole = set.string(forColumn: "userRole") ?? ""
            model.userState = Int(set.int(forColumn: "userState") )
            model.cardId = set.string(forColumn: "cardId") ?? ""
            model.readCardId = set.string(forColumn: "readCardId") ?? ""
            model.userUnit = set.string(forColumn: "userUnit") ?? ""
            model.breakNumber = Int(set.int(forColumn: "breakNumber") )
            model.adminLevel = Int(set.int(forColumn: "adminLevel") )
            model.borrowMaxNumber = Int(set.int(forColumn: "borrowMaxNumber") )
            model.borrowStartDate = set.string(forColumn: "borrowStartDate") ?? ""
            model.borrowDay = Int(set.int(forColumn: "adminLevel") )
            model.fineMoney = Int(set.int(forColumn: "fineMoney") )
            model.employeeId = set.string(forColumn: "employeeId") ?? ""
            model.userIcon = set.string(forColumn: "userIcon") ?? ""
            tempArray.append(model)
        }
    }catch {
        MLDeugLog(message: fmdb.lastErrorMessage())
    }

    return tempArray
}

    ///搜索指定条件的数据
    func queryConditions(tableName: String,isAnd: Bool ,conditions: [String: Any])  -> [MLUserInfoModel] {
        var query = "SELECT * FROM \(tableName)"

        var bindings: [Any] = []
        var whereClauses: [String] = []

        for (column, value) in conditions {
            
            let placeholder = "?"
            whereClauses.append("\(column) = \(placeholder)")
            bindings.append(value)
        }

        if !whereClauses.isEmpty {
            if isAnd {
                query += " WHERE \(whereClauses.joined(separator: " AND "))"
            }else{
                query += " WHERE \(whereClauses.joined(separator: " OR "))"
            }
        }

        var result: [MLUserInfoModel] = []

        do {
            let set = try fmdb.executeQuery(query, values: bindings)
            //循环遍历结果
            while set.next() {
                let model = MLUserInfoModel()
                //给字段赋值
                model.userId = set.string(forColumn: "userId") ?? ""
                model.userName = set.string(forColumn: "userName") ?? ""
                model.userPassword = set.string(forColumn: "userPassword") ?? ""
                model.userSex  = Int(set.int(forColumn: "userSex") )
                model.userAge = set.string(forColumn: "userAge") ?? ""
                model.userIphone = set.string(forColumn: "userIphone") ?? ""
                model.userEmail = set.string(forColumn: "userEmail") ?? ""
                model.userRole = set.string(forColumn: "userRole") ?? ""
                model.userState = Int(set.int(forColumn: "userState") )
                model.cardId = set.string(forColumn: "cardId") ?? ""
                model.readCardId = set.string(forColumn: "readCardId") ?? ""
                model.userUnit = set.string(forColumn: "userUnit") ?? ""
                model.breakNumber = Int(set.int(forColumn: "breakNumber") )
                model.adminLevel = Int(set.int(forColumn: "adminLevel") )
                model.borrowMaxNumber = Int(set.int(forColumn: "borrowMaxNumber") )
                model.borrowStartDate = set.string(forColumn: "borrowStartDate") ?? ""
                model.borrowDay = Int(set.int(forColumn: "adminLevel") )
                model.fineMoney = Int(set.int(forColumn: "fineMoney") )
                model.employeeId = set.string(forColumn: "employeeId") ?? ""
                model.userIcon = set.string(forColumn: "userIcon") ?? ""
                result.append(model)
            }
        }catch {
            MLDeugLog(message: fmdb.lastErrorMessage())
        }
        return result
    }
    
    
    
 //MARK: - 管理员和员工界面操作

//6.查找全部数据
    func fetchAllData(tableName: String,role: String) ->[MLUserInfoModel] {
        
        var fetchSql = MLDataManager.ML_SELECT_ALL_TABLE_SQL + " " + "\(tableName)" + " " + "WHERE" + " "
        if role == MLPublickTool.kManager {
            fetchSql = fetchSql + "userRole = '\(MLPublickTool.kSupeManager)' OR userRole = '\(MLPublickTool.kManager)'"
        }else{
            fetchSql = fetchSql + "userRole = '\(MLPublickTool.kReader)'"
        }
    //用于承接所有数据的临时数组
    var tempArray = [MLUserInfoModel]()
    do {
        let set = try fmdb.executeQuery(fetchSql, values: nil)
        //循环遍历结果
        while set.next() {
            let model = MLUserInfoModel()
            //给字段赋值
            model.userId = set.string(forColumn: "userId") ?? ""
            model.userName = set.string(forColumn: "userName") ?? ""
            model.userPassword = set.string(forColumn: "userPassword") ?? ""
            model.userSex  = Int(set.int(forColumn: "userSex") )
            model.userAge = set.string(forColumn: "userAge") ?? ""
            model.userIphone = set.string(forColumn: "userIphone") ?? ""
            model.userEmail = set.string(forColumn: "userEmail") ?? ""
            model.userRole = set.string(forColumn: "userRole") ?? ""
            model.userState = Int(set.int(forColumn: "userState") )
            model.cardId = set.string(forColumn: "cardId") ?? ""
            model.readCardId = set.string(forColumn: "readCardId") ?? ""
            model.userUnit = set.string(forColumn: "userUnit") ?? ""
            model.breakNumber = Int(set.int(forColumn: "breakNumber") )
            model.adminLevel = Int(set.int(forColumn: "adminLevel") )
            model.borrowMaxNumber = Int(set.int(forColumn: "borrowMaxNumber") )
            model.borrowStartDate = set.string(forColumn: "borrowStartDate") ?? ""
            model.borrowDay = Int(set.int(forColumn: "adminLevel") )
            model.fineMoney = Int(set.int(forColumn: "fineMoney") )
            model.employeeId = set.string(forColumn: "employeeId") ?? ""
            model.userIcon = set.string(forColumn: "userIcon") ?? ""
            tempArray.append(model)
        }
    }catch {
        MLDeugLog(message: fmdb.lastErrorMessage())
    }

    return tempArray
  }
    
    
    func openDatabase() -> Bool {
            if fmdb != nil {
                if fmdb.open() {
                    return true
                }
            }
            return false
        }
    
    
    
        //MARK: - 通用的增删改查方法
    

        func searchData(tableName: String,isAnd: Bool ,conditions: [String: Any])  -> [[String: Any]]? {
            var query = "SELECT * FROM \(tableName)"

            var bindings: [Any] = []
            var whereClauses: [String] = []

            for (column, value) in conditions {
                
                let placeholder = "?"
                whereClauses.append("\(column) = \(placeholder)")
                bindings.append(value)
            }

            if !whereClauses.isEmpty {
                if isAnd {
                    query += " WHERE \(whereClauses.joined(separator: " AND "))"
                }else{
                    query += " WHERE \(whereClauses.joined(separator: " OR "))"
                }
            }

        
//            func searchData(withQuery query: String) -> [[String: Any]]? {
        
        var result: [[String: Any]]?
        fmdbQue?.inDatabase { db in
            var resultSet: FMResultSet?
            resultSet = db.executeQuery(query, withArgumentsIn: bindings)
            if let resultSet = resultSet {
                result = []
                while resultSet.next() {
                    var row = [String: Any]()
                    for i in 0..<resultSet.columnCount {
                        let columnName = resultSet.columnName(for: i) ?? ""
                        let columnType = resultSet.type(forColumnIndex: i)
                       MLDeugLog(message: "\(columnType)")
                        switch columnType {
                        case .integer:
                            row[columnName] = resultSet.longLongInt(forColumnIndex: i)
                            break
                        case .float:
                            row[columnName] = resultSet.double(forColumnIndex: i)
                            break
                        case .text, .blob:
                            row[columnName] = resultSet.string(forColumnIndex: i)
                            break
                        default:
                            row[columnName] = ""
                        }
                        
                    }
                    result?.append(row)
                }
            } else {
                MLDeugLog(message:"Error executing query: \(db.lastErrorMessage())")
            }
        }
        return result
    }

    
    // 插入数据的方法
        func insertData(tableName: String, dataArray: [[String: Any]]) {
            guard let database = fmdb else {
                print("Database connection is nil")
                return
            }
            // 拼接插入语句
            var columns = ""
            var values = ""
            for (key, _) in dataArray[0] { // 仅取第一个字典的键来构建插入语句
                columns += "\(key),"
                values += "?,"
            }
            columns.removeLast() // 去除最后一个逗号
            values.removeLast() // 去除最后一个逗号

            let insertStatement = "INSERT INTO \(tableName) (\(columns)) VALUES (\(values))"

            // 开启事务
            database.beginTransaction()

            // 循环执行插入操作
            for data in dataArray {
                let valuesArray = data.values.map { $0 }
                if !database.executeUpdate(insertStatement, withArgumentsIn: valuesArray) {
                    print("Failed to insert data: \(database.lastErrorMessage())")
                }
            }
            // 提交事务
            database.commit()
        }
    
    
    
    
    // 更新数据的方法
       func updateData(tableName: String, newDataArray: [[String: Any]], condition: String) {
           guard let database = fmdb else {
               print("Database connection is nil")
               return
           }

           // 开启事务
           database.beginTransaction()

           // 构建更新语句
           for newData in newDataArray {
               var updateStatement = "UPDATE \(tableName) SET "
               var arguments: [Any] = []

               for (key, value) in newData {
                   updateStatement += "\(key) = ?,"
                   arguments.append(value)
               }

               updateStatement.removeLast() // 去除最后一个逗号
               updateStatement += " WHERE \(condition)"

               // 执行更新语句
               if !database.executeUpdate(updateStatement, withArgumentsIn: arguments) {
                   print("Failed to update data: \(database.lastErrorMessage())")
               }
           }

           // 提交事务
           database.commit()
       }

    
    
    
    // 删除数据的方法
      func deleteData(tableName: String, condition: String) {
          guard let database = fmdb else {
              print("Database connection is nil")
              return
          }
          // 构建删除语句
          let deleteStatement = "DELETE FROM \(tableName) WHERE \(condition)"
          // 执行删除语句
          if !database.executeUpdate(deleteStatement, withArgumentsIn: []) {
              print("Failed to delete data: \(database.lastErrorMessage())")
          }
      }
    
    
    
    
    
    
}


extension MLDataManager {
    private static let ML_DELETE_TABLE_SQL = "DELETE FROM"
    private static let ML_SELECT_ALL_TABLE_SQL = "SELECT * FROM"
    private static let ML_INSERT_INTO_TABLE_SQL = "INSERT INTO"
    private static let ML_UPDATE_TABLE_SQL = "UPDATE"
    
    ///创建userInfo表
    static  let USERINFO_TABLE = "CREATE TABLE userInfo ( userId TEXT(255) NOT NULL PRIMARY KEY, userName TEXT(255) NOT NULL, userSex INTEGER NOT NULL CHECK (userSex IN (1, 2)), userAge TEXT(255) NOT NULL, userIphone TEXT(255) NOT NULL CHECK (LENGTH(userIphone) = 11), userEmail TEXT(255) NOT NULL, userPassword TEXT(255) NOT NULL CHECK (LENGTH(userPassword) BETWEEN 6 AND 18), userRole TEXT(255) NOT NULL CHECK (userRole IN ('superAdmin', 'admin', 'reader')), userState INTEGER NOT NULL DEFAULT 1 CHECK (userState IN (0, 1)), cardId TEXT(255) NOT NULL, readCardId TEXT(255) NOT NULL, userUnit TEXT(255) NOT NULL, breakNumber INTEGER NOT NULL DEFAULT 0, adminLevel INTEGER NOT NULL DEFAULT 0 CHECK (adminLevel IN (1, 2, 3)), borrowMaxNumber INTEGER NOT NULL DEFAULT 6, borrowStartDate TEXT(255) NOT NULL, borrowDay INTEGER NOT NULL DEFAULT 0, fineMoney INTEGER NOT NULL DEFAULT 0, employeeId TEXT(255) NOT NULL DEFAULT '0' );"
    
    ///图书表
    static let BOOKINFO_TABLE = """
CREATE TABLE `bookInfo` (
  `bookId` INTEGER NOT NULL,
  `bookTitle` TEXT NOT NULL,
  `bookISBN` TEXT NOT NULL,
  `bookPress` TEXT NOT NULL,
  `bookAuthor` TEXT NOT NULL,
  `bookPrice` DOUBLE NOT NULL,
  `bookTotalPage` TEXT NOT NULL,
  `bookUploadTime` TEXT NOT NULL,
  `bookState` INTEGER NOT NULL,
  `bookBrief` INTEGER NOT NULL,
  `bookType` INTEGER NOT NULL,
  `bookCover` TEXT NOT NULL,
  `bookLibTotal` INTEGER NOT NULL,
  `bookBackTotal` INTEGER NOT NULL,
  `bookCategory` TEXT NOT NULL,
  PRIMARY KEY (`bookId`)
);
"""
    
    ///借阅记录表
    static let BOOK_RECORD_INFO_TABLE =
"""
CREATE TABLE bookRecordInfo (
  recordId TEXT PRIMARY KEY,
  recordBookTitle TEXT,
  recordBookISBN TEXT,
  recordBorrower TEXT,
  recordBorrowerTime TEXT,
  recordBackTime TEXT,
  bookType INTEGER,
  userId TEXT,
  userName TEXT,
  userIphone TEXT,
  createTime TEXT,
  updateTime TEXT
);
"""
    
    ///收藏表
    static let COLLECTION_BOOK_INFO_TABLE =
"""
CREATE TABLE collectionBookInfo (
    collectionId INT  ,
    bookId TEXT NOT NULL,
    bookTitle TEXT NOT NULL,
    bookISBN TEXT NOT NULL,
    bookPress TEXT NOT NULL,
    bookAuthor TEXT NOT NULL,
    collectionTime TEXT NOT NULL,
    PRIMARY KEY (collectionId)
);
"""
    
    
    ///收藏表
    static let LOOP_COVER_INFO_TABLE =
    
    """
    CREATE TABLE loopCoverInfo (
      loopId INTEGER,
      title TEXT,
      content TEXT,
      url TEXT,
      imageUrl TEXT,
      createTime TEXT,
      updateTime TEXT,
      type INTEGER,

      PRIMARY KEY (loopId)
    );
    """
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    ///插入
  private  func getInserSql(table: String, dict:[String:Any]) -> String {
        var columns: [String] = []
        var values: [String] = []
        
        for (key, _) in dict {
            columns.append(key)
            values.append("?")
        }

        let columnsClause = columns.joined(separator: ", ")
        let valuesClause = values.joined(separator: ", ")
        let insertSql = "\(MLDataManager.ML_INSERT_INTO_TABLE_SQL) \(table) (\(columnsClause)) VALUES (\(valuesClause))"
        return insertSql
    }
    
    
    ///更新
    func getUpdateSql(table: String,primaryKey:String,dict:[String: String]) -> String {
        var setClauses: [String] = []
        for (key, _) in dict {
              setClauses.append("\(key) = ?")
          }
          let setClause = setClauses.joined(separator: ", ")
          let updateSql = "\(MLDataManager.ML_UPDATE_TABLE_SQL) \(table) SET \(setClause) WHERE \(primaryKey) = ?"

        return updateSql
    }
    
    
    
    
    
    private func getValues(dict:[String: Any])-> [String] {
        var queryArguments: [String] = []
        
        for value in dict.values {
            let valueStr = "\(value)"
            queryArguments.append(valueStr)
        }
      return queryArguments
    }
    
    
    
    
}

///数据库表
extension MLDataManager {
    ///用户表
    internal  static let KUSER_INFO_TABLE = "userInfo"
    ///图书表
    internal static let KBOOK_INFO_TABLE = "bookInfo"
    ///借阅记录表
    internal  static let KBOOK_RECORD_INFO_TABLE = "bookRecordInfo"
      ///收藏表
    internal  static let KCOLLECTION_BOOK_INFO_TABLE = "collectionBookInfo"
    ///论坛表
    internal  static let KFORUM_INFO_TABLE = "forumInfo"
    ///轮播图表
    internal  static let KLOOPCOVER_INFO_TABLE = "loopCovrerInfo"
    ///公共信息表
    internal static let KLNOTICE_INFO_TABLE = "noticeInfo"
}
