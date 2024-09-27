//
//  MLWorkPateCell.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/3/9.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import UIKit

class MLWorkPateCell: UICollectionViewCell {
    static let  KMLCellId =  "MLWorkPateCell"
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    var model = MLWorkModel(){
        didSet {
            iconImageView.image = UIImage(named: model.iconName)
            nameLabel.text = model.name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ///添加阴影
        self.bgView.layer.masksToBounds = false
        self.bgView.layer.shadowColor   =  ML_AppThemeColor.cgColor
        self.bgView.layer.shadowOffset  = CGSizeMake(0,2) //0,0围绕阴影四周  0,2向下有2个像素的偏移
        self.bgView.layer.shadowOpacity = 0.08 //设置阴影透明度
        self.bgView.layer.shadowRadius  = MLiPhoneHalf(8.0) //设置阴影圆角
        self.bgView.layer.cornerRadius = MLiPhoneHalf(10.0)
    }

}
