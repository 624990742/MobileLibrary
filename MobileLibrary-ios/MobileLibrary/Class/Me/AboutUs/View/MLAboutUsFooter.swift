//
//  MLLogoutController.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/4/4.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import UIKit

class MLAboutUsFooter: UIView {
    static let footerID = "MLAboutUsFooter"
    @IBOutlet weak var netBtn: UIButton!
    @IBOutlet weak var infoLabel1: UILabel!
    @IBOutlet weak var infoLabel2: UILabel!
    @IBOutlet weak var telLabel: UILabel!

    @IBOutlet weak var spaceOne: NSLayoutConstraint!
    @IBOutlet weak var spaceTwo: NSLayoutConstraint!

    
    override  func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.white
     
    }
   

    
    @IBAction func nextBtnAction(_ sender: UIButton) {
        
        
    }
    
    
    /*
     @IBOutlet weak var nextAction: UIButton!
     // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
