//
//  MLPublickTool.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/3/28.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import Foundation
import CommonCrypto

class MLPublickTool {
    
    class func getPlistData(fileName: String) -> Any? {
        var tempArr: Array = Array<Any>()
        if let path = Bundle.main.path(forResource: fileName, ofType: "plist") {
            if let array = NSArray(contentsOfFile: path) as? [[String: Any]] {
                tempArr = array
            }
        } else {
            MLDeugLog(message: "找不到 plist 文件")
        }
        return tempArr
    }
    
    class func getJosnFileData(fileName: String) -> Any? {
        var tempArr: Array = Array<Any>()
        
        return tempArr
    }
    
    
  class  func getJsonString(fileName: String) -> String{

           var jsonStr = ""
             guard let filePath = Bundle.main.path(forResource: fileName, ofType: "json") else {
                 fatalError("获取json数据失败.")
             }
             
             do {
                 let jsonData = try Data(contentsOf: URL(fileURLWithPath: filePath))
                 
                 let jsonString = String(data: jsonData, encoding: .utf8)
                 jsonStr = jsonString ?? ""
             } catch {
                 MLDeugLog(message: "Error loading and/or parsing JSON: \(error)")
             }
        return jsonStr
    }
    
    /// md5
   static func MD5(_ str: String) -> String {
        let cStr = str.cString(using: String.Encoding.utf8);
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: 16)
        CC_MD5(cStr!,(CC_LONG)(strlen(cStr!)), buffer)
        let md5String = NSMutableString()
        for i in 0 ..< 16{
            md5String.appendFormat("%02x", buffer[i])
        }
        free(buffer)
        return md5String as String
    }

}




extension MLPublickTool {
    
    /// Data转JSON(数组和字典)
    public  static  func dataToJSONObject(data: Data) -> Any? {
        do {
            return try JSONSerialization.jsonObject(with: data , options: .mutableContainers) as AnyObject;
        } catch {
            MLDeugLog(message: "error:\(error)")
        }
        return nil
     }

    
    class func save(path: String, data: Data) {
        let pathURL = handlePathUrl(path)
        //拿到一个本地文件的URL
        let manager = FileManager.default
        var url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        url?.appendPathComponent("cache/")
        if let urlStr = url?.absoluteString, manager.isExecutableFile(atPath: urlStr) == false {
            try? manager.createDirectory(at: url!, withIntermediateDirectories: true, attributes: nil)
        }
        url?.appendPathComponent(pathURL)
        do {
            try data.write(to: url!)
            MLDeugLog(message: "保存到本地\(pathURL)")
        } catch {
            MLDeugLog(message:"保存到本地文件失败")
        }
    }
    
    class func read(path: String) -> Data? {
        let pathURL = handlePathUrl(path)
        let manager = FileManager.default
        var url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        url?.appendPathComponent("cache/\(pathURL)")
        if let dataRead = try? Data(contentsOf: url!) {
        
            MLDeugLog(message: "读取本地文件成功")
            return dataRead
        } else {
            MLDeugLog(message:"文件不存在，读取本地文件失败")
        }
        return nil
    }
    
    class func clearCache() {
        // 取出cache文件夹目录 缓存文件都在这个目录下
        let manager = FileManager.default
        var url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        url?.appendPathComponent("cache")
        do {
            try? manager.removeItem(at: url!)
        }
    }
    class func handlePathUrl(_ url: String) -> String {
        return url.replacingOccurrences(of: "/", with: "")
    }
    
    
    class func compareDates(dateString1: String, dateString2: String) -> ComparisonResult {
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "yyyy-MM-dd"

         guard let date1 = dateFormatter.date(from: dateString1),
               let date2 = dateFormatter.date(from: dateString2) else {
             fatalError("无法解析输入的日期字符串")
         }

         return date1.compare(date2)
     }
     
    class  func formatDateAsYYYYMMDD(date: Date) -> String {
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "yyyy-MM-dd"
         return dateFormatter.string(from: date)
     }
}



class MLCountDownBtn: UIButton {
    
    /// 开始倒计时
    ///
    /// - Parameter second: 倒计时时间 秒
    func startWithSeconds(second : Int) -> Void {
        
        var last = second
        var codeTime :DispatchSourceTimer? = DispatchSource.makeTimerSource(flags: .init(rawValue: 0), queue: DispatchQueue.global())
        codeTime?.schedule(deadline: .now(), repeating: Double(1))
        codeTime?.setEventHandler {
            last -= 1
            DispatchQueue.main.async {
                self.isEnabled = false
            }
            if last <= 0 {
                codeTime?.cancel()
                codeTime = nil
                DispatchQueue.main.async {
                    self.isEnabled = true
                    self.setTitle("重新发送", for: .normal)
                }
                return
            }
            DispatchQueue.main.async {
                self.setTitle("\(last)s", for: .normal)
            }
        }
        codeTime?.activate()
    }

}


extension MLPublickTool {
    static let kSupeManager = "superAdmin"
    static let kManager = "admin"
    static let kReader = "reader"
    static let kSupeManagerName = "超级管理员"
    static let kManagerName = "管理员"
    static let kReaderName = "读者"
    static let kUserIcons = ["userIcon1",
                            "userIcon2",
                            "userIcon3",
                            "userIcon4",
                            "userIcon5"]

    static let kUSERIPHONE = "userIphone"
    static let kREADCARDID = "readCardId"
    static let kUSERPASSWOED = "userPassword"
    
}
