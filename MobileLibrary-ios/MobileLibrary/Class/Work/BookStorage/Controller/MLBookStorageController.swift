//
//  MLBookStorageController.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/4/5.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import UIKit
import Photos
import SwiftScanner
class MLBookStorageController: MLBaseController {

    @IBOutlet weak var scrollViewTop: NSLayoutConstraint!
    ///简介
    @IBOutlet weak var bookBrifeTextView: UITextView!
    ///书本封面
    @IBOutlet weak var bookImageView: UIImageView!
    var bookCoverImage: UIImage!
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var bookAuthourTextField: UITextField!
    @IBOutlet weak var bookPressTextField: UITextField!
    @IBOutlet weak var bookTypeTextFiled: UITextField!
    @IBOutlet weak var bookISBNTextField: UITextField!
    @IBOutlet weak var bookBerifTextView: UITextView!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var totalLibNumTextField: UITextField!
    @IBOutlet weak var totalPageTextField: UITextField!
    
    
    
    lazy var saoMaItem: UIBarButtonItem = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        btn.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        btn.setTitle("扫一扫", for: .normal)
        btn.setImage(UIImage(named: "ic_saoma"), for: UIControl.State.normal)
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(saoAction), for: .touchUpInside)
        btn.layoutButtonImageEdgeInsetsStyle(style: KKButtonEdgeInsetsStyle.top, space: 3)
        return UIBarButtonItem(customView: btn)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollViewTop.constant = self.navBarHeight
        self.gk_navTitle = "新书录入"
        self.gk_navRightBarButtonItem = self.saoMaItem
    }

    
    @IBAction func bookCoverImageBtnAction(_ sender: UIButton) {
        
        let imagePickerManager = MLImagePickerManager()
        imagePickerManager.presentImagePicker(from: self, sourceView: self.bookImageView)
        imagePickerManager.pickImage { image in
            if let image = image {
                // Use the picked image
                self.bookImageView.image = image
            } else {
                // Handle the case when image picking failed
                MLProgressHUD.showWithMessage(message: "获取图片失败")
            }
        }

    }
    

    ///扫一扫结果
    @objc func saoAction(sender: UIButton){
        
        /// 创建二维码扫描
        let vc = MLScanCodeController()

        //设置标题、颜色、扫描样式（线条、网格）、提示文字
        vc.setupScanner("微信扫一扫", .green, .default, "将二维码/条码放入框内，即可自动扫描") { (code) in
        //扫描回调方法
        

        //关闭扫描页面
        self.navigationController?.popViewController(animated: true)
        }

        //push到扫描页面
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    @IBAction func sureBtnAction(_ sender: UIButton) {
        let bookTitle = bookTitleTextField.text
        let authour = bookAuthourTextField.text
        let bookType = bookTypeTextFiled.text
        let isbn = bookISBNTextField.text
        let brife = bookBrifeTextView.text
        let price =  priceTextField.text
        let totalNum = totalLibNumTextField.text
        let totalPage = totalPageTextField.text
        let bookPress = bookPressTextField.text
        
        if ((bookTitle?.isEmpty) != nil) || ((authour?.isEmpty) != nil) || ((bookType?.isEmpty) != nil) || ((isbn?.isEmpty) != nil) ||
            ((brife?.isEmpty) != nil) || ((price?.isEmpty) != nil) || ((totalNum?.isEmpty) != nil) || ((totalPage?.isEmpty) != nil) {
            MLAlert.show(type: MLAlert.AlertType.warning, text: "请检查输入的内容！")
            return
        }
        
        MLNetManager.loadNetData(API: MLNetAPI.self, target: .addBook(userId: MLUserInfoManager.userId ?? "", bookTitle: bookTitle!, bookISBN: isbn!, bookPress: bookPress!, bookAuthor: authour!, bookPrice: Double(price!) ?? 0.0, bookTotalPage: Int(Double(totalPage!) ?? 0.0), bookUploadTime: String.getCurrentDateFormattedToHour(), bookState: 0, bookBrief: brife!, bookType: 1, bookCover: "book1", bookLibTotal: Int(totalNum!) ?? 0, bookBackTotal: 100, bookCategory: "")) { code, dict, msg in
            if code != 200 {
                MLAlert.show(type: MLAlert.AlertType.warning, text: msg)
                return
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

