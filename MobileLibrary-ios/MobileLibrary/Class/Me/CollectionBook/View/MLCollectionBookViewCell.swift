//
//  MLCollectionBookViewCell.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/5/15.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import UIKit

class MLCollectionBookViewCell: UITableViewCell {

    static let kCellID = "MLCollectionBookViewCell"
    
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var bookPressLabel: UILabel!
    @IBOutlet weak var collectionTimeLabel: UILabel!

    
    func setupUI(item: MLMeCollectionModel){
        bookTitleLabel.text = item.bookTitle
        authorLabel.text = item.bookAuthor
        bookPressLabel.text = item.bookPress
        collectionTimeLabel.text = item.collectionTime
        
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
