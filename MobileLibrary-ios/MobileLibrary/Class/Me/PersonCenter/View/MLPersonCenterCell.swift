//
//  MLPersonCenterCell.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/3/6.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import UIKit

class MLPersonCenterCell: UITableViewCell {
    static let KCellID = "MLPersonCenterCell"
    @IBOutlet weak var mineTileLabel: UILabel!
    @IBOutlet weak var jianTouImgeView: UIImageView!
    @IBOutlet weak var versionLabel: UILabel!
 
    func setupUIData(title: String,row: Int){
        self.mineTileLabel.text = title
        versionLabel.textColor = ML_TwoTitleColor
        
        switch row {
        case 0:
            versionLabel.text = MLUserInfoManager.userName!
            break
        case 1:
            versionLabel.text = MLUserInfoManager.userSex!
            break
        case 2:
            versionLabel.text = MLUserInfoManager.userIphone!
            break
        case 3:
            versionLabel.text = MLUserInfoManager.borrowStartDate!
            break
        case 4:
            versionLabel.text = MLUserInfoManager.userUnit!
            break
            
        default:
            MLDeugLog(message: "-- 测试 --")
        }
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        versionLabel.isHidden = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
