//
//  MLBookHotHeaderView.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/4/6.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import UIKit

class MLBookHotHeaderView: UIView ,MLNibLoadElement {
    @IBOutlet weak var bookCoverImageView: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var authourLabel: UILabel!
    @IBOutlet weak var bookTypeLabel: UILabel!
    @IBOutlet weak var numLabel: UILabel!

    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }

    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
