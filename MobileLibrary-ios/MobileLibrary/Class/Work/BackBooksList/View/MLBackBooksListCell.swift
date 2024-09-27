//
//  MLBrrowBookListCell.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/3/31.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import UIKit


class MLBackBooksListCell: UITableViewCell {
   static let kCellId = "MLBackBooksListCell"
    
    var oprtionType:MLBookOptionType = .jieYueType
    
    typealias ListCellBtnClickBlock = (MLBookOptionType) -> Void
    var btnClickBlock: ListCellBtnClickBlock!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var numLbel: UILabel!
    @IBOutlet weak var bookISBNLabel: UILabel!
    @IBOutlet weak var recordBorrowerLabel: UILabel!
    @IBOutlet weak var borrowerTimeLabel: UILabel!
    @IBOutlet weak var backTimeLabel: UILabel!
    @IBOutlet weak var iphoneLabel: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    var model: MLBookRecordInfoModel!
    var row: Int = 0
    //MARK: -
    func setupUI(item: MLBookRecordInfoModel){
        model = item
        numLbel.text = "\(row + 1)"
        bookTitleLabel.text = model.recordBookTitle
        bookISBNLabel.text = model.recordBookISBN
        recordBorrowerLabel.text = model.recordBorrower
        iphoneLabel.text = model.userIphone
        borrowerTimeLabel.text = model.recordBorrowerTime
        backTimeLabel.text = model.recordBackTime
    }
    
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        btnClickBlock(.guiHuanType)
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
