//
//  MLBookDetailCell.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/4/6.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import UIKit

class MLBookDetailCell: UITableViewCell {
     static let kcellId = "MLBookDetailCell"
    
    @IBOutlet weak var bookPressLabel: UILabel!
    @IBOutlet weak var bookISBNLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var book: MLBookInfoModel!
    func setupUI(model: MLBookInfoModel){
        book = model
        bookPressLabel.text = model.bookPress
        bookISBNLabel.text = model.bookISBN
        dateLabel.text = model.bookUploadTime
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
