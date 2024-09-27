//
//  AppDelegate.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/2/17.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            
            MLDataManager.shareManager.option()
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.backgroundColor = UIColor.white
            let tabbarVC = MLTabbarController()
            self.window?.rootViewController = tabbarVC
            self.window?.makeKeyAndVisible()
            ///导航配置
            GKConfigure.setupDefault()
            GKConfigure.awake()
        return true
    }


}

// MARK: UISceneSession Lifecycle
@available(iOS 13.0, *)
extension AppDelegate {

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
