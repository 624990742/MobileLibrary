//
//  MLLogoutController.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/4/4.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import UIKit

class MLLogoutController: MLBaseController {

    @IBOutlet weak var iPhoneLabel: UILabel!

    @IBOutlet weak var viewTop: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewTop.constant = self.navBarHeight
        self.gk_navTitle = "注销账号"
   
    }

    
    
    ///取消
    @IBAction func cancelBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    ///确定
    @IBAction func sureBtnAction(_ sender: UIButton) {
     
        showAccountDeletionAlert(
            title: "注销账号",
            message: "确认要继续下一步的操作吗？",
            confirmationButtonTitle: "确认",
            confirmationAction: {
                self.deleteAccount()
            }
        )
    }
    
    
    func deleteAccount(){
        
        
        if MLUserInfoManager.userRole == MLPublickTool.kSupeManager || MLUserInfoManager.userRole == MLPublickTool.kManager {
         
            MLAlert.show(type: MLAlert.AlertType.error, text: "管理员不允许删除")
            return
        }
        
        let iphone = MLUserInfoManager.userIphone ?? ""
        let readCard = MLUserInfoManager.readCardId ?? ""
        MLNetManager.loadNetData(API: MLNetAPI.self, target: .logout(iphone: iphone, readCardId: readCard)) { code, dict, msg in
            if code == 200 {
                MLAlert.show(type: .success, text: "注销成功")
                MLUserInfoManager.logout { [weak self] in
                    self?.navigationController?.popToRootViewController(animated: true)
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: MLNOTIFICATION_LOGOUT), object: nil)
                } failure: { msg in
                    MLAlert.show(type: MLAlert.AlertType.error, text: msg)
                }
            }else{
                MLAlert.show(type: MLAlert.AlertType.error, text: msg)
            }
            
        } failure: { code, msg in
            MLAlert.show(type: MLAlert.AlertType.error, text: msg)
        }

    
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
