//
//  MLHelper.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/4/2.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import Foundation
class MLHelper {
    
    
   static func isLogin() -> Bool {
        guard let _ = MLUserInfoManager.userId else {
            return false
        }
        return true
    }
    
    
    
    
    ///是否已经登录状态
   static func isLoginState(completion: @escaping()->Void) -> Bool{
        guard let _ = MLUserInfoManager.userId else {
            MLHelper.needLogin {
               completion()
            }
            return false
        }
        return true
    }
    
   private static func needLogin(completion: @escaping()->Void){
        if MLUserInfoManager.userId?.isEmpty == false{
            return
        }
        let loginVC = MLLoginController.init(nibName: "MLLoginController", bundle: nil)
        loginVC.modalPresentationStyle = .fullScreen
        loginVC.backActionBlock = completion
        let navVC = MLBaseNavgationController.init(rootViewController: loginVC)
                    navVC.modalPresentationStyle = .fullScreen
        guard let widow = MLHelper.getCurrentSceneWindow() else {
            return
        }
        let rootVC = widow.rootViewController
        rootVC?.modalPresentationStyle = .fullScreen
        rootVC?.present(navVC, animated: true)
    }
    
    
    
    
    static   func getCurrentSceneWindow() -> UIWindow? {
        if #available(iOS 13.0, *) {
            // iOS 13及以上版本，使用UIScene API获取主窗口
            guard let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene else {
                return nil
            }

            if #available(iOS 15.0, *) {
                return scene.keyWindow
            } else {
                // iOS 13至iOS 14版本，遍历所有UIWindow寻找可见且可交互的窗口作为主窗口
                for window in scene.windows {
                    if window.isKeyWindow || window.isHidden == false && window.alpha > 0 && window.isUserInteractionEnabled {
                        return window
                    }
                }
            }
        } else {
            // iOS 12及以下版本，使用UIApplication的keyWindow属性
            return UIApplication.shared.keyWindow
        }
        return UIWindow()
    }
}
