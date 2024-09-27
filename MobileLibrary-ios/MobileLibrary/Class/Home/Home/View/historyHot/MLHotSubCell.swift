//
//  MLHotSubCell.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/3/10.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import UIKit

class MLHotSubCell: UICollectionViewCell {
    static let kCellID = "MLHotSubCell"
    var model: MLHomeModel!
    
    @IBOutlet weak var bookCoverImageView: UIImageView!
    @IBOutlet weak var bookTitleLbael: UILabel!
    
    func setupData(item: MLHomeModel) {
        self.model = item
        self.bookTitleLbael.text = item.name
        self.bookCoverImageView.image = UIImage(named: item.icon)
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
