//
//  MLSearchResultCell.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/4/6.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import UIKit

class MLSearchResultCell: UITableViewCell {
static let kCellId = "MLSearchResultCell"
var model: MLBookInfoModel!

    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookAuthourLabel: UILabel!
    @IBOutlet weak var bookPressLabel: UILabel!
    @IBOutlet weak var bookTimeLabel: UILabel!
    
    func setupUI(item: MLBookInfoModel) {
        model = item
        self.bookImageView.image = UIImage(named: item.bookCover)
        self.bookTitleLabel.text = item.bookTitle
        self.bookAuthourLabel.text = item.bookAuthor
        self.bookPressLabel.text = item.bookPress
        self.bookTimeLabel.text = "上架时间：\(item.bookUploadTime)"

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
