//
//  MLMineCell.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/3/6.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import UIKit

class MLMineCell: UITableViewCell {
    static let KCellID = "MLMineCell"
    @IBOutlet weak var mineTileLabel: UILabel!
    @IBOutlet weak var jianTouImgeView: UIImageView!
    @IBOutlet weak var versionLabel: UILabel!
    
    func setupUIData(title: String){
        self.mineTileLabel.text = title
        
        if title == MLMeContrller.KSystemVersion {
            jianTouImgeView.isHidden = true
            versionLabel.isHidden = false
        }else{
            jianTouImgeView.isHidden = false
            versionLabel.isHidden = true
        }
        
        let appBuildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
        print("当前项目的构建版本号: \(appBuildNumber ?? "未知")")
        
        versionLabel.textColor = ML_TwoTitleColor
        versionLabel.text = "V" + (appBuildNumber ?? "0.1")
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
