//
//  MLTodayHotCell.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/3/10.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import UIKit

class MLTodayHotCell: UITableViewCell {
    
    static let kCellID = "MLTodayHotCell"
    
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var bookTitle: UILabel!
    
    @IBOutlet weak var pressLabel: UILabel!
    
    
    @IBOutlet weak var bookAuthorLabel: UILabel!
    //    var model =  MLHomeModel(){
//            didSet{
//                iconImageView.image = UIImage(named: model.icon)
//                bookTitle.text = model.name
//            }
    //    }
    
    var model = MLBookInfoModel(){
        didSet{
            iconImageView.image = UIImage(named: model.bookCover)
            bookTitle.text = model.bookTitle
            pressLabel.text = model.bookPress
            bookAuthorLabel.text = model.bookAuthor
        }
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
