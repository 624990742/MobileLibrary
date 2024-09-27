//
//  MLTodayHotTitleView.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/3/10.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import UIKit

enum MLHomeSenctionType: Int {
    case MLHomeBookCategoryType = 1///图书分类
    case MLHomeSelectBook = 2///精选图书
}
class MLTodayHotTitleView: UIView , MLNibLoadElement {

    @IBOutlet weak var secTitleLabel: UILabel!
    @IBOutlet weak var moreBtn: UIButton!
    weak var tableView:UITableView!
    var senction: Int!
    var row: Int!
    typealias MoreBtnBlcok = () -> Void
    @objc var moreBtnActionBlcok: MoreBtnBlcok?
    
    
    func setupTitleWithSection(sec: MLHomeSenctionType)  {
        
        if sec == MLHomeSenctionType.MLHomeBookCategoryType {
            secTitleLabel.text = "图书分类"
            secTitleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        } else if sec == MLHomeSenctionType.MLHomeSelectBook {
            secTitleLabel.font = UIFont.boldSystemFont(ofSize: 22)
            secTitleLabel.text = "精选图书"
        }
    }

    override var frame: CGRect {
        didSet {
            if tableView != nil {
                super.frame = tableView.rectForHeader(inSection: self.senction)
            }
        }
    }
    
    
    @IBAction func moreBtnAction(_ sender: UIButton) {
        if (self.moreBtnActionBlcok != nil){
            self.moreBtnActionBlcok?()
        }
    }
    
}
