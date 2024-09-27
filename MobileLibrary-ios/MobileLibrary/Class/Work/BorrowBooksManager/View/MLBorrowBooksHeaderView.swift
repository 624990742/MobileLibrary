//
//  MLBorrowBooksHeaderView.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/3/30.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import UIKit

class MLBorrowBooksHeaderView: UIView {

    lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.text = "标题"
        label.font = UIFont.systemFont(ofSize: 16.0)
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = ML_F7F8Color
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(self.snp.left).offset(20)
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
