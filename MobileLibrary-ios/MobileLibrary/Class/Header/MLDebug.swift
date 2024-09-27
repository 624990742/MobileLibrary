//
//  File.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/3/4.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import Foundation
// 调试lo该日志输出
// - parameter message:  日志消息
// - parameter logError: 错误标记，默认是 false，如果是 true，发布时仍然会输出
// - parameter file:     文件名
// - parameter method:   方法名
// - parameter line:     代码行数
func MLDeugLog<T>(message: T,
              logError: Bool = false,
              file: String = #file,
              method: String = #function,
              line: Int = #line)
{
    if logError {
        print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
    } else {
        #if DEBUG
          if message is Dictionary<String, Any> {
              guard let dict = message as? Dictionary<String, Any> else {
                  print("-- DEBUG调试日志出错 --")
                  return
              }
              var str = String.dicValueString(dict) ?? ""
              if str.isEmpty {
                 let dd  = dict as NSDictionary
//                  str = dd.mj_JSONString() ?? ""
                  do {
                      let jsonData = try JSONSerialization.data(withJSONObject: dd, options: .prettyPrinted)
                      if let jsonString = String(data: jsonData, encoding: .utf8) {
                          print(jsonString)
                          str = jsonString
                      }
                  } catch {
                      print("JSON serialization failed: \(error)")
                  }
                  
              }
            let logMessage = "DEBUG调试日志：" + str
            print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(logMessage)")
          } else {
              var str = ""
              if message is NSNumber {
                  str = String(describing: message)
              }else{
                   str = message as? String ?? ""
              }
              let logMessage = "DEBUG调试日志：" + str
              print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(logMessage)")
          }
        #endif
    }
}
