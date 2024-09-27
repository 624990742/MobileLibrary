//
//  MLLoginController.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/3/28.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import UIKit


enum MLLoginStyle {
    case MLLoginStyle_iphone///手机号
    case MLLoginStyle_jieyue///借阅证号
}
class MLLoginController: MLBaseController ,UITextFieldDelegate {

    static let kIphoneMaxLen = 11
    static let kReadCardMaxLen = 5
    static let kPasswordMaxLen = 18
    static let kPasswordMinLen = 6

    @IBOutlet weak var bgViewTop: NSLayoutConstraint!
    @IBOutlet weak var loginTitleLabel: UILabel!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var loginIocnImageView: UIImageView!
    @IBOutlet weak var iphoneTextFiled: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var jieyueBtn: UIButton!
    @IBOutlet weak var forgetBtn: UIButton!
    @IBOutlet weak var signBtn: UIButton!
    @IBOutlet weak var tipLabel: BSLabel!
    @IBOutlet weak var pwdFormatBtn: UIButton!
    
    var maxLength: Int = 0
    var loginStyle:MLLoginStyle = .MLLoginStyle_iphone
    typealias BackBlock = () -> Void
    @objc var backActionBlock: BackBlock?
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.gk_navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.gk_navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerBtn.layer.borderColor = ML_AppThemeColor.cgColor
        self.registerBtn.layer.borderWidth = 1.0
        self.setupTip()
        self.iphoneTextFiled.delegate = self
        self.passwordTextField.delegate = self
    }

    func setupTip(){
  
        let attr1 = "《用户服务协议》"
        let attr2 = "《隐私政策》"
        
        let tipTotalStr = "同意《用户服务协议》和《隐私政策》"
        let tipTotalText = NSMutableAttributedString(string:tipTotalStr)
        let highlight = TextHighlight()
        highlight.color = .white
//        highlight.backgroundBorder = highlightBorder
        highlight.tapAction = { (containerView, text, range, rect) in
            
            
            let web = MLWebController.init()
            if text?.string ?? "nil" == attr1 {
                web.htmltype = .user
            }else{
                web.htmltype = .yinsi
            }
                
            self.navigationController?.pushViewController(web, animated: true)
        }
        
        
        let attrRange1 = ((tipTotalStr as NSString?)?.range(of: attr1))!
        tipTotalText.bs_set(color: ML_AppThemeColor, range: attrRange1)
        tipTotalText.bs_set(font: UIFont.systemFont(ofSize: 14.0), range: attrRange1)
        tipTotalText.bs_set(textHighlight: highlight, range: attrRange1)
        
        
        let attrRange2 = ((tipTotalStr as NSString?)?.range(of: attr2))!
        tipTotalText.bs_set(color: ML_AppThemeColor, range: attrRange2)
        tipTotalText.bs_set(font: UIFont.systemFont(ofSize: 14.0), range: attrRange2)
        tipTotalText.bs_set(textHighlight: highlight, range: attrRange2)
        

        self.tipLabel.attributedText = tipTotalText
        
        self.passwordTextField.isSecureTextEntry = true
        self.pwdFormatBtn.isSelected = false
    }
    
    
    
    
    @IBAction func closeBtnAction(_ sender: UIButton) {
        if (self.backActionBlock != nil){
            self.backActionBlock?()
        }
        self.dismiss(animated: true)
    }
    
    
    
    @IBAction func loginBtnAction(_ sender: UIButton) {
        
        switch self.loginStyle {
        case .MLLoginStyle_iphone:
            self.iphoneLogin()
        case .MLLoginStyle_jieyue:
            self.cardLogin()
        default:
            MLDeugLog(message: "-- 出错了 --")
        }
    }
    

    
    ///设置密码格式
    @IBAction func pwdFormatBtnAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        self.passwordTextField.isSecureTextEntry = !self.passwordTextField.isSecureTextEntry
    }
    
    
    
    func cardLogin(){
        
        
        guard let cardId = iphoneTextFiled.text ,cardId.isCardId() else {
                MLAlert.show(type: .warning, text: "请输入正确的借阅证号")
            return
        }
        guard let password = passwordTextField.text,password.isPassword() else {
                        MLAlert.show(type: .warning, text: "请输入6-15位数字或字母密码")
            return
        }
        
        if self.signBtn.isSelected == false {
            MLAlert.show(type: .warning, text: "请勾选协议")
            return
        }
        
        
        TProgressHUD.show()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            
            let infoArr = MLDataManager.shareManager.queryConditions(tableName: MLDataManager.KUSER_INFO_TABLE, isAnd: true, conditions: [MLPublickTool.kREADCARDID : cardId])
            if infoArr.isEmpty {
                MLAlert.show(type: .warning, text: "请先进行注册")
                TProgressHUD.hide()
                return
            }
            let model = infoArr.first!
            if model.userPassword == password {
                MLUserInfoManager.setupLoginSuccessInfo(infoModel: infoArr.first!) {
                    self.closeBtnAction(self.closeBtn)
                    TProgressHUD.hide()
                }
            }else{
                MLAlert.show(type: .warning, text: "密码错误")
                TProgressHUD.hide()
            }
        }
        dealLogin(readCardId: cardId, passwd: password,loginType: 2)
    }
    
    
    func iphoneLogin(){
        
        if  iphoneTextFiled.text?.length ?? 0 > MLLoginController.kIphoneMaxLen  {
            MLAlert.show(type: .warning, text: "请输入正确的手机号")
            return
        }
        
        guard let mobile = iphoneTextFiled.text ,mobile.isMobile() else {
                MLAlert.show(type: .warning, text: "请输入正确的手机号")
            return
        }
        guard let password = passwordTextField.text,password.isPassword() else {
                        MLAlert.show(type: .warning, text: "请输入6-15位数字或字母密码")
            return
        }
        
        if self.signBtn.isSelected == false {
            MLAlert.show(type: .warning, text: "请勾选协议")
            return
        }
    
        dealLogin(iphone: mobile,passwd: password,loginType: 1)
        
    }
    
    
    @IBAction func registerBtnAction(_ sender: UIButton) {
     
        let regiseterVC = MLRegisterController.init()
        regiseterVC.optionType = .registerType
        regiseterVC.backActionBlock = {[weak self] in
            self?.closeBtnAction(self?.closeBtn ?? UIButton())
        }
        self.navigationController?.pushViewController(regiseterVC, animated: true)
    }
    
    
    
    @IBAction func jieyueBtn(_ sender: UIButton) {
        
        if self.loginStyle == .MLLoginStyle_iphone {
            self.iphoneTextFiled.text = "";
            self.loginTitleLabel.text = "借阅证号密码登录"
            self.jieyueBtn.setTitle("手机号登录", for: UIControl.State.normal)
            self.iphoneTextFiled.placeholder = "请输入借阅证号"
            self.loginStyle = .MLLoginStyle_jieyue
        }else{
            self.iphoneTextFiled.text = "";
            self.loginTitleLabel.text = "手机号密码登录"
            self.iphoneTextFiled.placeholder = "请输入手机号"
            self.jieyueBtn.setTitle("借阅证登录", for: UIControl.State.normal)
            self.loginStyle = .MLLoginStyle_iphone
        }

    }
    
    
    @IBAction func forgetBtn(_ sender: UIButton) {
        let regiseterVC = MLRegisterController.init()
        regiseterVC.optionType = .forgetPassWordType
        regiseterVC.backActionBlock = {[weak self] in
            self?.closeBtnAction(self?.closeBtn ?? UIButton())
        }
        self.navigationController?.pushViewController(regiseterVC, animated: true)
    }
    

    @IBAction func signBtn(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    
    func dealLogin(iphone: String = "", readCardId: String = "",passwd: String = "",loginType: Int = 1){
        
        MLNetManager.loadNetData(API: MLNetAPI.self, target: .login(iphone: iphone, readCardId: readCardId, passwd: passwd, loginType: loginType)) { code, dict , msg in
            
            guard let dict = dict as? [String: Any],
                  let result = dict["Data"] as? String else {
                MLDeugLog(message: "无法解析响应结果")
                return
            }
            if result.isEmpty {
                MLDeugLog(message: "无法解析响应结果")
                return
            }

            let user =  MLUserInfoModel.deserialize(from: result)
            MLDeugLog(message: "成功响应码：\(code)+ 响应结果:\(result)")
            MLUserInfoManager.setupLoginSuccessInfo(infoModel: user ?? MLUserInfoModel() ) {
//               self.closeBtnAction(self.closeBtn)
                self.dismiss(animated: true)
            }
    
        } failure: { code, msg in
            
            MLAlert.show(type: MLAlert.AlertType.error, text:msg)
#if DEBUG
            /*
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                let infoArr = MLDataManager.shareManager.queryConditions(tableName: MLDataManager.KUSER_INFO_TABLE, isAnd: true, conditions: [MLPublickTool.kUSERIPHONE :iphone])
                if infoArr.isEmpty {
                    MLAlert.show(type: .warning, text: "请先进行注册")
                    TProgressHUD.hide()
                    return
                }
                let model = infoArr.first!
                if model.userPassword == passwd {
                    MLUserInfoManager.setupLoginSuccessInfo(infoModel: infoArr.first!) {
                        self.closeBtnAction(self.closeBtn)
                        TProgressHUD.hide()
                    }
                }else{
                    MLAlert.show(type: .warning, text: "密码错误")
                    TProgressHUD.hide()
                }
            }*/
#else
#endif

        }

    
        
//        if self.iphoneTextFiled.text == "18710172063" && self.passwordTextField.text == "123456"{
//
//            MLUserInfoManager.userId = "1189273"
//            let testDict = ["userId":"1189273",
//                            "userIphone":"18710172063",
//                            "userPassword":"123456"] as [String : String]
//            MLUserInfoManager.setupLoginSuccessInfo(entity: testDict) {
//                self.closeBtnAction(self.closeBtn)
//            }
//
//            return///密码正确
//        }
    }
    
    
    //MARK: - 代理
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        switch textField.tag {
        case 100:
            if self.loginStyle == .MLLoginStyle_jieyue {
                self.maxLength = MLLoginController.kReadCardMaxLen
            }else {
                self.maxLength = MLLoginController.kIphoneMaxLen
            }
        case 101:
            self.maxLength = MLLoginController.kPasswordMaxLen
        default:
            MLDeugLog(message: "--测试--")
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return true } // 如果当前文本为空，允许输入

        let proposedText = (currentText as NSString).replacingCharacters(in: range, with: string)
        let maxLength = self.maxLength // 指定的最大位数

        if proposedText.count <= maxLength  {//&& proposedText.filter({ $0.isNumber}).count == proposedText.count
            return true // 允许输入，字符总数未超过最大位数且均为数字
        } else {
            return false // 阻止输入，不符合条件
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
