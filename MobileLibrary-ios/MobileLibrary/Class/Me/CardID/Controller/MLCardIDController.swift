//
//  MLCardIDController.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/4/5.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import UIKit

class MLCardIDController: MLBaseController {

    
    @IBOutlet weak var iconTop: NSLayoutConstraint!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var cardIdLabel: UILabel!
    @IBOutlet weak var adreeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.gk_navTitle = "借阅证"
        self.view.backgroundColor = .white
        self.iconTop.constant = self.navBarHeight + MLiPhoneHalf(50)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
