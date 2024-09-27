//
//  MBProgressHUD+TProgressHUD.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/4/6.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import Foundation
import UIKit



extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}

public class MLProgressHUD {
    
    static var hud : MBProgressHUD?
    
    ///展示
    public  class func show() {
        if let window = UIWindow.key {
            if hud != nil {
                hud?.hide(animated: false)
                hud = nil
            }
            hud = MBProgressHUD.showAdded(to: window, animated: true)
            hud?.mode = .indeterminate
        }
    }
    
    
    
    ///隐藏
    public class func hide() {
        if UIWindow.key != nil {
            hud?.hide(animated: true)
            hud = nil
        }
    }
    
    
    ///展示详细信息
    public  class func showWithMessage(message :String?) {
        if let window = UIWindow.key {
            if hud != nil {
                hud?.hide(animated: false)
                hud = nil
            }
            hud = MBProgressHUD.showAdded(to: window, animated: true)
            hud?.mode = .indeterminate
            hud?.label.text = message
            hud?.label.numberOfLines = 0
            
        }
    }
    
    
    ///展示进度条
    public   class func showNetworkWithProgress(progress :Float,message :String?) -> Void {
        if let window = UIWindow.key {
            if hud == nil {
                hud = MBProgressHUD.showAdded(to: window, animated: true)
            }
            hud?.mode = .determinateHorizontalBar
//            hud?.label.numberOfLines = 0
            hud?.label.text = message
            hud?.progress = progress
        }
    }
}
