//
//  MLBookListCell.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/4/6.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import UIKit

class MLBookListCell: UITableViewCell {
static let kCellId = "MLBookListCell"
    
    @IBOutlet weak var bookCoverImageView: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var authourLabel: UILabel!
    @IBOutlet weak var pressLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var model: MLBookInfoModel!
    
    func setupUI(item: MLBookInfoModel){
        model = item
        self.bookTitleLabel.text = model.bookTitle
        self.bookCoverImageView.image = UIImage(named: model.bookCover)
        self.authourLabel.text = model.bookAuthor
        self.pressLabel.text = model.bookPress
        self.timeLabel.text = model.bookUploadTime
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
