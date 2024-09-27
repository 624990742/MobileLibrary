//
//  MLBaseController.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/3/4.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import UIKit
import GKNavigationBarSwift
class MLBaseController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        baseSetup()
    }
    
    func baseSetup(){
        self.setNavTitle(title: "")
        self.gk_statusBarStyle = .lightContent
    }
    
    func setNavTitle(title: String,
                     titleColor: UIColor = .white,
                     navBackGroudColor: UIColor = ML_AppThemeColor,
                     currentViewBgColor: UIColor = ML_F7F8Color) {
        self.gk_navTitle = title
        self.gk_navTitleColor = titleColor
        self.gk_navBackgroundColor = navBackGroudColor
        self.gk_backImage = UIImage(named: "jiantou_bai")
        self.view.backgroundColor = currentViewBgColor
    }
  
    ///导航高度
    var navBarHeight: CGFloat {
        return GKDevice.navBarHeight()
    }
    
    
    
    
    
    override var prefersStatusBarHidden: Bool {
        return self.gk_statusBarHidden
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.gk_statusBarStyle
    }
    
    func removeStackController(ofClass classObj: AnyClass) {
        guard let navigationController = self.navigationController else {
            print("Navigation controller is not available.")
            return
        }

        var viewControllers = navigationController.viewControllers

        for (index, vc) in viewControllers.enumerated() {
            if vc.isKind(of: classObj) {
                viewControllers.remove(at: index)
                break
            }
        }

        navigationController.viewControllers = viewControllers
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
