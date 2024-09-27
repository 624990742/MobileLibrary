//
//  MLBookAnnouncementController.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/4/4.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import UIKit

class MLBookAnnouncementController: MLBaseController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var viewTop: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewTop.constant = self.navBarHeight
        self.gk_navTitle = "图书馆公告"
        self.textView.isEditable = false
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
