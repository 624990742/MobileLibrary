//
//  MLLogoutController.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/4/4.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//


import UIKit

class MLAboutUsHeader: UIView {
    static let HeaderID = "MLAboutUsHeader"
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var appTitleLabel: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var bottomMargin: NSLayoutConstraint!
    
    override  func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.white
        self.bottomMargin.constant = CGFloat(MLiPhoneHalf(173.0) / 6)
        self.versionLabel.text = versionStr()
    }
    
    func versionStr() -> String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
        return "V\(version)版"
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
