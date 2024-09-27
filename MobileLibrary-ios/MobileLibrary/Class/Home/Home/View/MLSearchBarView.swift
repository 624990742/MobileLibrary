//
//  MLSearchBarView.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/3/10.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import UIKit

class MLSearchBarView: UIView, UITextFieldDelegate {
    
    typealias  SearBarBlock = (_ textField: UITextField) -> Void
     @objc var   tapAction: SearBarBlock?
    
    lazy var searBar: UITextField = {
        let font16 = UIFont.systemFont(ofSize: 16)
        let textField = UITextField()
        textField.tintColor = .black
//        textField.delegate = self
        textField.returnKeyType = .search
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.attributedPlaceholder = NSAttributedString(string: "请输入搜索内容", attributes: [NSAttributedString.Key.foregroundColor: ML_B8C2CColor, NSAttributedString.Key.font: font16])
        textField.font = font16
        textField.clearButtonMode = .always
        textField.backgroundColor = ML_F7F8Color
        textField.layer.cornerRadius = 17.0
        return textField
    }()
    
    @objc func textFiledAction(sener: UITextField){
        guard let tapAction = tapAction else {
              return
          }
        tapAction(sener)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
        self.searBar.addTarget(self, action: #selector(textFiledAction), for: UIControl.Event.editingDidBegin)
    }
    
    
    func setupUI(){
        self.backgroundColor = .white
        // 设置左边的图标
        let searchIcon = UIImageView(frame: CGRect(x: 9, y: 0, width: 24, height: 24))
        searchIcon.image = UIImage(named: "ic_search")
        searchIcon.tintColor = ML_8A9199Color
        searchIcon.contentMode = .center
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 24 + 12, height: 24))
        leftView.addSubview(searchIcon)
        
//        // 设置右边的图标
//        let takePhotos = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
//        takePhotos.image = UIImage(named: "ic_search")
//        takePhotos.tintColor = ML_8A9199Color
//        takePhotos.contentMode = .center
//        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 24 + 12, height: 24))
//        rightView.addSubview(takePhotos)
//        self.searBar.rightView = rightView
//        self.searBar.rightViewMode = .always
        
        self.searBar.leftView = leftView
        self.searBar.leftViewMode = .always
      
        self.addSubview(self.searBar)
        self.searBar.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(20)
            make.left.equalTo(self.snp.left).offset(20)
            make.right.equalTo(self.snp.right).offset(-20)
            make.bottom.equalTo(self)
        }

    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
