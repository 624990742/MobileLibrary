//
//  MLRegisterController.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/3/28.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import UIKit


enum MLAccountOptionType {
    case registerType///注册
    case forgetPassWordType///忘记密码
    case modifyPasswordTyope///修改密码
}

class MLRegisterController: MLBaseController,UITextFieldDelegate {
    
    @IBOutlet weak var bgViewTop: NSLayoutConstraint!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var twoTextField: UITextField!
    @IBOutlet weak var threeTextField: UITextField!
    @IBOutlet weak var fourTextField: UITextField!
    @IBOutlet weak var codeBtn: MLCountDownBtn!
    var optionType: MLAccountOptionType = .registerType
    var maxLength: Int = 8
    
    typealias BackBlock = () -> Void
    @objc var backActionBlock: BackBlock?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    func setupUI(){
        if self.optionType == .registerType {
            self.gk_navTitle = "注册账号"
            self.loginBtn.setTitle("注册", for: UIControl.State.normal)
        }else if self.optionType == .forgetPassWordType {
            self.gk_navTitle = "找回密码"
            self.loginBtn.setTitle("确定", for: UIControl.State.normal)
        }else if self.optionType == .modifyPasswordTyope{
            self.gk_navTitle = "修改密码"
            self.loginBtn.setTitle("确定", for: UIControl.State.normal)
            self.fourTextField.placeholder = "请输入新密码"
        }
        
        self.codeBtn.layer.borderColor = ML_AppThemeColor.cgColor
        self.codeBtn.layer.masksToBounds = true
        self.codeBtn.layer.borderWidth = 1.0
        self.codeBtn.layer.cornerRadius = 5.0
        self.firstTextField.delegate = self
        self.twoTextField.delegate = self
        self.threeTextField.delegate = self
        self.fourTextField.delegate = self
    }
    
    
    
    
    
    
    @IBAction func loginBtnAction(_ sender: UIButton) {
        
        guard let readCardId = firstTextField.text ,readCardId.isCardId() else {
            MLAlert.show(type: .warning, text: "请输入正确的借阅证号")
            return
        }
        
        guard let mobile = twoTextField.text,mobile.isMobile() else {
            MLAlert.show(type: .warning, text: "请输入11位手机号")
            return
        }
        
        guard let password = fourTextField.text,password.isPassword() else {
            MLAlert.show(type: .warning, text: "请输入6-15位数字或字母密码")
            return
        }
        
        let textLen = threeTextField.text?.length ?? 0
        if textLen > 4 || textLen < 4 {
            MLAlert.show(type: .warning, text: "请输入4位验证码")
            return
        }
  
    
        if self.optionType == .registerType || self.optionType == .forgetPassWordType {
            
            self.dealRegister(iphone: mobile, readCardId: readCardId, passwd: password)
            
        } else {//修改密码
            self.dealUpdatePassWord(iphone: mobile, readCardId: readCardId, passwd: password)
        }
        
    }
    
    
    

    
    
    @IBAction func codeBtnAction(_ sender: MLCountDownBtn) {
        MLAlert.show(type: .success, text: "验证码发送成功")
        sender.startWithSeconds(second: 60)
    }
    

    
    
    
    //MARK: - 代理
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        switch textField.tag {
        case 100://借阅证号
            self.maxLength = 8
        case 101://手机号
            self.maxLength = 11
        case 102://验证码
            self.maxLength = 4
        case 103://密码
            self.maxLength = 18
        default:
            MLDeugLog(message: "--测试--")
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return true } // 如果当前文本为空，允许输入
        let proposedText = (currentText as NSString).replacingCharacters(in: range, with: string)
        let maxLength = self.maxLength // 指定的最大位数
        
        let tag = textField.tag
        if tag == 102 || tag == 101 {
            if proposedText.count <= maxLength && proposedText.filter({ $0.isNumber }).count == proposedText.count {
                return true
            }else{
                return false
            }
            
        }else if tag == 100 || tag == 103 {
            if proposedText.count <= maxLength {
                return true
            }
        }
        
        return false
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


//MARK: - 处理网络
extension MLRegisterController {
    
    
    ///修改密码
    func dealUpdatePassWord(iphone: String,readCardId: String, passwd:String){
     
        MLNetManager.loadNetData(API: MLNetAPI.self, target: .updateUser(iphone: iphone, readCardId: readCardId, passwd: passwd)) { code, dict, msg in
            if code == 200 {
                MLAlert.show(type: MLAlert.AlertType.success, text:msg)
                ///密码更新成功，账号自动退出，重新登录
                
                MLUserInfoManager.logout { [weak self] in
                    self?.navigationController?.popToRootViewController(animated: false)
                    if (self?.backActionBlock != nil){
                        self?.backActionBlock?()
                    }
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: MLNOTIFICATION_LOGOUT), object: nil)
                } failure: { msg in
                    MLDeugLog(message: "退出失败:\(msg)")
                }
            }else{
                MLAlert.show(type: MLAlert.AlertType.error, text:msg)
            }
        } failure: { code, msg in
            MLAlert.show(type: MLAlert.AlertType.error, text:msg)
        }

    }
    
    
    ///注册
    func dealRegister(iphone: String,readCardId: String, passwd:String){
        MLNetManager.loadNetData(API: MLNetAPI.self, target: .regisetr(iphone: iphone, readCardId: readCardId, passwd: passwd)) { code, dict, msg in
            
            guard let dict = dict as? [String: Any],
                  let result = dict["Data"] as? String else {
                MLDeugLog(message: "无法解析响应结果")
                return
            }

//            let user =  MLUserInfoModel.deserialize(from: result)
            MLDeugLog(message: "成功响应码：\(code)+ 响应结果:\(result)")
            MLAlert.show(type: MLAlert.AlertType.success, text:"注册成功")
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.navigationController?.popViewController(animated: true)
            }
    
        } failure: { code, msg in
            
            MLAlert.show(type: MLAlert.AlertType.error, text:msg)
#if DEBUG
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                self.regiseterUserSaveLocal(cardId: readCardId)
//            }
#else
#endif

        }
    }
    
    
    
    
    
}


//MARK: - 处理本地数据
extension MLRegisterController {
    
    func forgetPassWord(cardIdStr: String){
        
        let infoArr = MLDataManager.shareManager.queryConditions(tableName: MLDataManager.KUSER_INFO_TABLE, isAnd: true, conditions: [MLPublickTool.kUSERIPHONE :twoTextField.text!])
        if infoArr.isEmpty {
//            self.regiseterUser(cardId: cardIdStr)
            self.regiseterUserSaveLocal(cardId: cardIdStr)
        }else{
            let model = infoArr.first!
            model.userPassword = fourTextField.text!
            let state = MLDataManager.shareManager.updateData(tableName: MLDataManager.KUSER_INFO_TABLE,
                                                  primaryKeyColumn: MLPublickTool.kUSERIPHONE,
                                                  primaryKeyValue: twoTextField.text!,
                                                  updates: [MLPublickTool.kUSERPASSWOED: fourTextField.text!])
            if state {
                MLUserInfoManager.setupLoginSuccessInfo(infoModel: model) {
                    MLAlert.show(type: .success, text: self.getTitle() )
                    self.navigationController?.popViewController(animated: false)
                    if (self.backActionBlock != nil){
                        self.backActionBlock?()
                    }
                }
            }
        }
    }
    
    
    
    func regiseterUserSaveLocal(cardId: String){
        let model = MLUserInfoModel()
          model.userId = String.generateUUID()
          model.userIphone = twoTextField.text!
          model.userPassword = fourTextField.text!
          model.readCardId = cardId
          model.userRole = MLPublickTool.kReader
          guard let json = model.toJSON() else {
              return
          }
        let state = MLDataManager.shareManager.insertData(tableName: MLDataManager.KUSER_INFO_TABLE, dict: json)
          if state {
              MLUserInfoManager.setupLoginSuccessInfo(infoModel: model) {
                  MLAlert.show(type: .success, text: self.getTitle() )
                  self.navigationController?.popViewController(animated: false)
                  if (self.backActionBlock != nil){
                      self.backActionBlock?()
                  }
              }
          }else{
              MLAlert.show(type: .error, text: self.getTitle() )
          }
    }
    
    
    
    //        MLUserInfoManager.userId = "1189273"
    //        let testDict = ["userId":"1189273",
    //                        "userIphone":"187117263",
    //                        "userPassword":"123456",
    //                        "userSex":"1",
    //                        "userRole":"superAdmin"] as [String : String]
    //        MLUserInfoManager.setupLoginSuccessInfo(entity: testDict) { [weak self] in
    //            MLAlert.show(type: .success, text: self?.getTitle() ?? "成功")
    //            self?.navigationController?.popViewController(animated: false)
//                    if (self?.backActionBlock != nil){
//                        self?.backActionBlock?()
//                    }
    //        }
}



//MARK: - 自定义方法
extension MLRegisterController {
    
    func getTitle() -> String {
        var tipStr = ""
        switch self.optionType {
        case .registerType:
            tipStr = "注册成功"
        case .forgetPassWordType:
            tipStr = "找回密码成功"
        case .modifyPasswordTyope:
            tipStr = "修改密码成功"
        default:
            MLDeugLog(message: "---出错---")
        }
        return tipStr
    }
}
