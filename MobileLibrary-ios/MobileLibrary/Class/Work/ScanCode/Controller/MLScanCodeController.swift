//
//  MLScanCodeController.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/4/11.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import UIKit
import SwiftScanner
import GKNavigationBarSwift
class MLScanCodeController: ScannerVC {
    typealias BackBlock = (_ result: String) -> Void
    @objc var backActionBlock: BackBlock?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavTitle(title: "扫一扫")
        self.gk_statusBarStyle = .lightContent
      
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        delayedTaskWithTimer()
    }
    
    
    func delayedTaskWithTimer() {
        // 创建一个定时器，在3秒后执行一次任务
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { (timer) in
            // 这里写你想要延迟执行的任务
            print("任务在4秒后执行")
            if (self.backActionBlock != nil){
                self.backActionBlock?("BL-F1-WX-0001")
            }
                
            self.navigationController?.popViewController(animated: true)
            // 可选：如果不再需要定时器，可以将其invalidate
            timer.invalidate()
        }
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
