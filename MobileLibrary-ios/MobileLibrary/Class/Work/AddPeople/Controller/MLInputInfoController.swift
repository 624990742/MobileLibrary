//
//  MLInputInfoController.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/4/9.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import UIKit



public enum MLJoinOptionType {
    case addManagerJoin///添加管理员
    case addReaderJoin///添加读者
    case managerInfo ///
    case readerInfo ///
    case personCenter///个人中心
    case borrowInformationModification
}

/////从哪一个入口进入的
//public enum MLGoIntoType{
//    ///个人中心
//    case personCenter
//}


class MLInputInfoController: MLBaseController,UITextViewDelegate {

    private let kMinHeight = 100.0
    private let kMaxHeight = 330.0
    
    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var suerBtn: UIButton!
    var addSec: Int!
    var addRow: Int!
     
    @IBOutlet weak var textViewHeight: NSLayoutConstraint!
    typealias BackBlock = (_ text: String, _ sec: Int, _ row: Int) -> Void
    @objc var backActionBlock: BackBlock?
    var  goIntoType: MLJoinOptionType = .personCenter
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.gk_navTitle = "请输入你的内容"
        inputTextView.delegate = self
        textViewHeight.constant = kMinHeight
        inputTextView.layer.cornerRadius = 10.0
        inputTextView.layer.masksToBounds = true
        inputTextView.layer.borderColor = ML_AppThemeColor.cgColor
        inputTextView.layer.borderWidth = 1.0
        
    }

    
    @IBAction func suerBtnAction(_ sender: UIButton) {
        self.dealLogic()
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    func textViewDidChange(_ textView: UITextView) {
        // 禁止滚动，避免影响计算结果
        textView.isScrollEnabled = false
        // 计算适应当前文本内容的新高度
        let newSize = textView.sizeThatFits(CGSize(width: textView.frame.width, height: .greatestFiniteMagnitude))
        let newHeight = max(newSize.height, kMinHeight)
        
        if newHeight <=  kMaxHeight {
            // 更新 UITextView 的高度
             textView.frame.size.height = newHeight
             // 如果需要，更新其他依赖于此高度的视图或布局约束
             textViewHeight.constant = newHeight
         // 恢复滚动能力
         textView.isScrollEnabled = true
        }
            
     }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.inputTextView.resignFirstResponder()
        
    }
    
    
    func dealLogic(){
     
        switch self.goIntoType {
        
        case .personCenter:
            self.dealPersonLogic()
            break
        case .borrowInformationModification:
            if (self.backActionBlock != nil) {
                self.backActionBlock?(self.inputTextView.text ,self.addSec,self.addRow)
            }
         break
        default:
            MLDeugLog(message: "-- 未知错误 --")
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



//MARK: - 个人中心
extension MLInputInfoController {
    
    func dealPersonLogic() {
    
        let text = inputTextView.text ?? ""
        
        var userName = ""
        var iphone = ""
        var userUnit = ""
        switch addRow {
        case 0://昵称
            userName = text
        case 2://手机号
            iphone = text
        case 4://个人简介
            userUnit = text
        default:
            MLDeugLog(message: "-- 异常 --")
        }
        
        let userId = MLUserInfoManager.userId ?? ""
        MLNetManager.loadNetData(API: MLNetAPI.self, target: .updateUserInfo(userId: userId, userName: userName, userSex: 0, iphone: iphone, dateTime: "", userUnit: userUnit)) { code, dict, msg in

            if (self.backActionBlock != nil) {
                self.backActionBlock?(text ,self.addSec,self.addRow)
            }

        } failure: { code, msg in

        }
        
    }
    
}

