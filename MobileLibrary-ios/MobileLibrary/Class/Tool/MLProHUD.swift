//
//  MLProHUD.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/3/28.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//弹窗提示
import Foundation

class MLAlert: NSObject {
    enum AlertType {
        case success
        case info
        case error
        case warning
    }
    
    class func show(type: AlertType, text: String,hideAfterDelay :CGFloat = 0.6) {
    
        if let window = MLHelper.getCurrentSceneWindow() {
            var image: UIImage
            switch type {
            case .success:
                image = #imageLiteral(resourceName: "Alert_success")
            case .info:
                image = #imageLiteral(resourceName: "Alert_info")
            case .error:
                image = #imageLiteral(resourceName: "Alert_error")
            case .warning:
                image = #imageLiteral(resourceName: "Alert_warning")
            }
            let hud = MBProgressHUD.showAdded(to: window, animated: true)
            hud.backgroundColor = UIColor.clear
            hud.mode = .customView
            hud.customView = UIImageView(image:image)
            hud.label.text = text
            hud.label.numberOfLines = 0
            hud.hide(animated: true, afterDelay: TimeInterval(hideAfterDelay))
        }
    }
}

class TProgressHUD {
    static var hud : MBProgressHUD?
    
    class func show() {
        if let window = MLHelper.getCurrentSceneWindow() {
            if hud != nil {
                hud?.hide(animated: false)
                hud = nil
            }
            hud = MBProgressHUD.showAdded(to: window, animated: true)
            hud?.mode = .indeterminate
        }
    }
    
    class func hide() {
        if MLHelper.getCurrentSceneWindow() != nil {
            hud?.hide(animated: true)
            hud = nil
        }
    }
    
    
    class func showWithMessage(message :String?) {
        if let window = MLHelper.getCurrentSceneWindow() {
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
    
    class func showNetworkWithProgress(progress :Float,message :String?) -> Void {
        if let window = MLHelper.getCurrentSceneWindow() {
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
