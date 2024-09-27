//
//  MLMineHeaderCell.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/3/7.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import UIKit

class MLMineHeaderCell: UITableViewCell {
    static let KCellID = "MLMineHeaderCell"
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cardLabel: UILabel!
    @IBOutlet weak var desLabel: UILabel!
    @IBOutlet weak var desBgView: UIImageView!
    @IBOutlet weak var setupBtn: UIButton!
    @IBOutlet weak var loginTipLabel: UILabel!
    
    func setupData(){
        
        guard let _ = MLUserInfoManager.userId else {
            self.iconImageView.image = UIImage(named: "header_defalt")
            self.nameLabel.isHidden = true
            self.cardLabel.isHidden = true
            self.loginTipLabel.isHidden = false
            self.desLabel.text = "登录之后开始你的学习之旅"
            return
        }

        self.loginTipLabel.isHidden = true
        self.iconImageView.image = UIImage(named: MLUserInfoManager.userIcon ?? "header_defalt")
        self.nameLabel.isHidden = false
        self.cardLabel.isHidden = false
        self.nameLabel.text = MLUserInfoManager.userName
        
        

        if MLUserInfoManager.userRole == MLPublickTool.kSupeManager ||  MLUserInfoManager.userRole == MLPublickTool.kManager {
            self.desLabel.text = "尊敬的管理员您好！"
            self.cardLabel.text = "员工号:\(MLUserInfoManager.employeeId ?? "" )"
        }else{
            self.desLabel.text = "亲爱的读者您好！"
            self.cardLabel.text = "借阅证号:\(MLUserInfoManager.readCardId ?? "000000")"
        }
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        desBgView.layer.cornerRadius = 8.0
        desBgView.layer.masksToBounds = true
        self.iconImageView.layer.cornerRadius = self.iconImageView.ML_Width * 0.5
    
    }

    override func layoutSubviews() {
        super.layoutSubviews()
//        desBgView.mlk_drawAllCornerRadius(radius: 2.0)
    }
    


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
