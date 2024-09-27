//
//  MLSwiftBridgingOCMacro.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/3/6.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//
/**
 说明：该类为swift与oc的桥接文件，如果oc要调用swift的方法可以把对应的方法
     封装到该类中，然后提供给oc调用。
 */

import Foundation

@objc(MLOCBridgingSwiftMacro)
public class MLOCBridgingSwiftMacro: NSObject {
  
    @objc public class func ml_appThemeColor() -> UIColor {
        return ML_AppThemeColor
    }
    
    @objc public class func ml_f7f8Color() -> UIColor {
        return ML_F7F8Color
    }
    
    @objc public class func ml_twoTitleColor() -> UIColor {
        return ML_TwoTitleColor
    }
    
    @objc public class func ml_8A9199Color() -> UIColor {
        return ML_8A9199Color
    }
    
    @objc public class func ml_B8C2CColor() -> UIColor {
        return ML_B8C2CColor
    }
    
    @objc public class func ml_statusBarHeight() -> CGFloat {
        return ML_StatusBarHeight
    }
    
    @objc public class func ml_navgationHeight() -> CGFloat {
        return ML_NavigationHeight
    }
    
    @objc public class func ml_screenWidth() -> CGFloat {
        return ML_ScreenWidth
    }
    
    @objc public class func ml_screenHeight() -> CGFloat {
        return ML_ScreenHeight
    }
    
    @objc public class func ml_margin() -> CGFloat {
        return ML_Margin
    }
 
    @objc public class func ml_iPhoneHalf(a: CGFloat) -> CGFloat {
        return MLiPhoneHalf(a)
    }
 
//-----搜索-----//
    
    //标题
    @objc public class func ML_Search_tagTitleHeighT() -> CGFloat {
        return MLSearch_tagTitleHeighT
    }
    //清除tip文本
    @objc public class func ML_Search_deleteTipT() -> String {
        return MLSearch_deleteTip
    }
    //key
    @objc public class func ML_Search_kHistroySearchData() -> String {
        return MLSearch_kHistroySearchData
    }
    //最大历史搜索条数
    @objc public class func ML_Search_kMaxHistroyNum() -> Int {
        return MLSearch_kMaxHistroyNum
    }



    @objc static func loadModelsAsDictionaries(name: String, type: String, completion: @escaping ([[String: Any]]?, Error?) -> Void) {
        guard let filePath = Bundle.main.path(forResource: name, ofType: type) else {
            completion(nil, NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to locate the \(type) file named: \(name)"]))
            return
        }
        
        do {
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: filePath))
            if let jsonDictArray = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [[String: Any]] {
                completion(jsonDictArray, nil)
            } else {
                completion(nil, NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to deserialize JSON to dictionary array."]))
            }
        } catch {
            completion(nil, error)
        }
    }


    
    
}



