//
//  MLTodayHotTitleView.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/3/10.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import UIKit

class MLPersonCenterHeaderView: UIView , MLNibLoadElement {

    @IBOutlet weak var headerImageView: UIImageView!
    
    @IBOutlet weak var imageBtnAction: UIButton!
    
    typealias HeaderImageBlock = () -> Void
    @objc var headerImageBlock: HeaderImageBlock?
    
    override  func awakeFromNib() {
        super.awakeFromNib()
        let suerIcon = MLUserInfoManager.userIcon ?? "useerIcon1"
        self.headerImageView.image = UIImage(named: suerIcon)
    }
    
    
    
    @IBAction func headerImageBtnAction(_ sender: UIButton) {
        if (self.headerImageBlock != nil){
            self.headerImageBlock?()
        }
    }
    
}
