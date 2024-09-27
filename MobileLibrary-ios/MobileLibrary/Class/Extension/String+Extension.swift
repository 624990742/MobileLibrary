//
//  String+Extension.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/3/9.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import Foundation
import CryptoKit
extension String {
    /**
      * 生成指定富文本样式的字符串
      * targetStr: 要做区别的字符串( self 必须包含这个字符串 )
      * targetFont: 字体
      * targetColor: 颜色
      * otherFont: 其他的字体
      * otherColor: 其他的颜色
      * Returns: att
      **/
    func changeStringColorFont(taget targetStr :String,targetFont :UIFont? = nil ,otherFont :UIFont? = nil ,targetColor :UIColor? = nil ,otherColor :UIColor? = nil) -> NSMutableAttributedString {
        let att = NSMutableAttributedString(string: self)
        var dict = [NSAttributedString.Key : Any]()
        if otherFont != nil {
            dict[NSAttributedString.Key.font] = otherFont!
        }
        if otherColor != nil {
            dict[NSAttributedString.Key.foregroundColor] = otherColor!
        }
        if dict.keys.count > 0 {
            att.addAttributes(dict, range: NSMakeRange(0, self.count))
        }
        
        let range = (self as NSString).range(of: targetStr)
        var targetAttDict = [NSAttributedString.Key : Any]()
        if targetFont != nil {
            targetAttDict[NSAttributedString.Key.font] = targetFont!
        }
        if targetColor != nil {
            targetAttDict[NSAttributedString.Key.foregroundColor] = targetColor!
        }
        att.addAttributes(targetAttDict, range: range)
        
        return att
    }
    
    ///替换字符串中指定字符<br>
    static func dealSpecialCharacters(meaning: String ,replaceBeforeStr: String,replaceAfterStr: String) -> String {
        
        if meaning.isEmpty {
            return ""
        }
         var mutableMeaning: String  = "\(meaning)"
         if let subRange = Range<String.Index>(NSRange(location: 0, length: meaning.count), in: mutableMeaning) {
             mutableMeaning = mutableMeaning.replacingOccurrences(of: replaceBeforeStr, with: replaceAfterStr, options: [], range: subRange)
         }
        let tempMeaning = mutableMeaning
             .trimmingCharacters(in: .whitespacesAndNewlines)
        return tempMeaning
    }
   
    ///处理特殊字符
    static func dealMeaning(mean: String?) -> String {
         
       return String.dealSpecialCharacters(meaning: mean ?? "", replaceBeforeStr: "<br>", replaceAfterStr: "\n")
    }
    ///返回一个不为nil的数据
    static func dealEmptyString(str: String?) -> String {
        if str != nil {
            return "\(String(describing: str!))"
        }
        return ""
    }
    
    ///计算富文本的size
//   static func getAttributedStringSize(width: CGFloat , height: CGFloat, attr: NSAttributedString) -> CGSize {
//        let layout = YYTextLayout(containerSize: CGSize(width: width, height: height), text: attr)
//        return layout?.textBoundingSize ?? CGSize.zero
//    }
    
    
    // 根据宽度动态计算高度(new)
   static func kk_getLabelHeight(_ label: UILabel, width: CGFloat) -> CGFloat {
        return label.sizeThatFits(CGSize(width:width, height: CGFloat(MAXFLOAT))).height
    }
    
    //根据高度动态计算宽度(new)
   static func kk_getLabelWidth(_ label: UILabel, height: CGFloat) -> CGFloat {
        return label.sizeThatFits(CGSize(width:CGFloat(MAXFLOAT), height: height)).width
    }
 
    ///1.把整数数字转成带小数的字符串
    ///2.返回一个向上取整的数
    static func dealNumber(str: String) -> CGFloat {
       
        let dealStr = str
        var num = 0.0
        
        if dealStr.count > 2 {
            
            let index = dealStr.count - 1
            var tempStr = dealStr.prefix(index)
            tempStr = tempStr + "."
            num = ceil(Double(tempStr) ?? 0.0) * 10
            
        } else {

            var tempStr = ""
            for (idx,t) in str.enumerated() {
                if idx == 0 {
                    tempStr = String(t) + "."
                } else {
                    tempStr = tempStr + String(t)
                }
            }
            num = ceil(Double(tempStr) ?? 0.0) * 10
        }
       return num
    }
    
    
    
    
    ///处理小数的方法
    /// - digit: 小数位（默认2位小数）
    /// 1.RoundingMode  ->  plan
    /// - Parameter numberString: 格式化之前 ->  0.125
    /// - Returns: 格式化之后 -> 0.13
    /// 2. RoundingMode -> down
    /// - Parameter numberString: 格式化之前 -> 0.125
    /// - Returns: 格式化之后 -> 0.12
    static func dealRoundNumberString(digit:Int = 2, numberString : String ,type: NSDecimalNumber.RoundingMode) -> CGFloat {
        if numberString.isEmpty || digit == 0 {
            return 0.0
        }
        let roudingBehavior     = NSDecimalNumberHandler(roundingMode: type, scale: Int16(digit), raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        let deStr                 = NSDecimalNumber(string: numberString)
        let resultDec            = deStr.rounding(accordingToBehavior: roudingBehavior)
        let num = CGFloat(resultDec.doubleValue)
        return num
    }
 
    
    
    
    // MARK: 字典转字符串
    static  func dicValueString(_ dic:[String : Any]) -> String?{
            let data = try? JSONSerialization.data(withJSONObject: dic, options: [])
            let str = String(data: data!, encoding: String.Encoding.utf8)
            return str
        }

    // MARK: 字符串转字典
    static func stringValueDic(_ str: String) -> [String : Any]?{
            let data = str.data(using: String.Encoding.utf8)
            if let dict = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String : Any] {
                return dict
            }
            return nil
        }

    // MARK: 去掉首尾空格
   var removeHeadAndTailSpace:String {
       let whitespace = NSCharacterSet.whitespaces
       return self.trimmingCharacters(in: whitespace)
   }
    
    // MARK: 去掉首尾空格 包括后面的换行
   var removeHeadAndTailSpacePro:String {
       let whitespace = NSCharacterSet.whitespacesAndNewlines
       return self.trimmingCharacters(in: whitespace)
   }
    
    // MARK: 去掉所有空格
   var removeAllSapce: String {
       return self.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
   }
   
    // MARK: 去掉首尾空格 后 指定开头空格数
   func beginSpaceNum(num: Int) -> String {
       var beginSpace = ""
       for _ in 0..<num {
           beginSpace += " "
       }
       return beginSpace + self.removeHeadAndTailSpacePro
   }
   
   //MARK: 处理手机号
   func phoneHide() -> String {
       
       return (self as NSString).replacingCharacters(in: NSMakeRange(3, 4), with: "****")
   }
   //MARK: 是不是邮箱
   func isEmail() -> Bool {
       return MLValidate.email(self).isRight
   }
   //MARK: 是不是手机号
   func isMobile() -> Bool {
       return MLValidate.phoneNum(self).isRight
   }
   //MARK: 是否符合密码
   func isPassword() -> Bool {
       return MLValidate.password(self).isRight
   }
   //MARK: 是不是符合姓名,汉字
   func isNickname() -> Bool {
       return MLValidate.nickname(self).isRight
   }
    
    func isPureNumer() -> Bool {
        return MLValidate.pureNumer(self).isRight
    }
    
    //MARK: 是否是借阅证
    func isCardId() -> Bool{
        return MLValidate.cardIDNum(self).isRight
    }
    /// 生成随机字符串
    ///
    /// - Parameters:
    ///   - count: 生成字符串长度,65-90=A-Z,97-122=a-z,48-57=0-9
    ///   - isLetter: false=大小写字母和数字组成，true=大小写字母组成，默认为false
    /// - Returns: String,
    static func random(_ count: Int, _ isLetter: Bool = false) -> String {

        ///.初始化多加了个1,目的是,swift和c语言转换问题,CChar数组必须以0结束，否则会有不可预料的结果.参考(https://www.cnblogs.com/motoyang/p/4946896.html),要么换种方法,自定义一个字符串,根据随机下标获取字符,拼接字符串
        var ch: [CChar] = Array(repeating: 0, count: count + 1)
        
        for index in 0..<count {
            
            var num = isLetter ? arc4random_uniform(58)+65:arc4random_uniform(75)+48
            
            if num>57 && num<65 && isLetter==false { num = num%57+48 }
                
            else if num>90 && num<97 { num = num%90+65 }
            
            ch[index] = CChar(num)
        }
        var ran = ""
        ch.withUnsafeBufferPointer { pr in
            ran = String(cString: pr.baseAddress!)
        }
        return ran
    }
    
    
    ///uuid 也就是userid
    static  func generateUUID(length: Int = 18) -> String {
      let uuid = UUID().uuidString // 生成完整的UUID字符串
      return String(uuid.prefix(length)) // 截取前length个字符
  }
    
    static func getCurrentDateFormattedToHour() -> String {
            let currentDate = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.string(from: currentDate)
        }
}
