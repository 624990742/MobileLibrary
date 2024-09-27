//
//  MLBookShareCell.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/3/27.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import UIKit

class MLBookShareCell: UITableViewCell {
    static let CellID = "MLBookShareCell"
    var model: MLLibraryCircleModel?
    
    @IBOutlet weak var bookCoverImageView: UIImageView!
    
    @IBOutlet weak var bookTitleLabel: UILabel!
    
    @IBOutlet weak var bookAuthorLabel: UILabel!
    
    @IBOutlet weak var bookPressLabel: UILabel!

    @IBOutlet weak var bookBrifeLabel: UILabel!
    
    @IBOutlet weak var moreBtn: UIButton!
    
    typealias BackBlock = () -> Void
    @objc var backActionBlock: BackBlock?
    
    
    
    
    func setupData(item: MLLibraryCircleModel?) {
        model = item
        
        self.bookCoverImageView.image = UIImage(named: item?.bookCover ?? "")
        self.bookTitleLabel.text  = "书名：" + (item?.bookTitle ?? "测试")
        self.bookAuthorLabel.text  = "作者：" + (item?.bookAuthor ?? "测试")
        self.bookPressLabel.text  = "出版社" + (item?.bookPress ??  "测试")
        self.bookBrifeLabel.text  = item?.bookBrief ?? "测试"
        
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.moreBtn.layer.cornerRadius = 5
        self.moreBtn.layer.masksToBounds = true
        self.moreBtn.backgroundColor = ML_AppThemeColor
    }

    
    
    @IBAction func moreBtnAction(_ sender: UIButton) {
        if (self.backActionBlock != nil){
            self.backActionBlock?()
        }

    }
    
    
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
