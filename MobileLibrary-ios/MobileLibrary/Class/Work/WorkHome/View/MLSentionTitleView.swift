//
//  MLSentionTitleView.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/3/9.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import UIKit

class MLSentionTitleView: UICollectionReusableView {
   static let kMLSentionTitleID = "MLSentionTitleView"
    @IBOutlet weak var line: UIView!
    @IBOutlet weak var lineTitleLabel: UILabel!
    
    @IBOutlet weak var bgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bgView.backgroundColor = ML_F7F8Color
        self.line.layer.cornerRadius = 2.0
        self.line.layer.masksToBounds = true
    }
    
   
    
}
