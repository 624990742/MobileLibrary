//
//  MLBrrowBookListCell.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/3/31.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import UIKit

class MLBrrowBookListCell: UITableViewCell {
   static let kCellId = "MLBrrowBookListCell"
    
    var oprtionType:MLBookOptionType = .jieYueType
    
    typealias ListCellBtnClickBlock = (MLBookOptionType) -> Void
    var btnClickBlock: ListCellBtnClickBlock!
    @IBOutlet weak var numLbel: UILabel!
    
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookAthourLabel: UILabel!
    @IBOutlet weak var bookPressLabel: UILabel!
    @IBOutlet weak var bookISBNLabel: UILabel!
    ///库存数量
    @IBOutlet weak var numLabel: UILabel!
    ///借阅人
    @IBOutlet weak var recordBorrowerLabel: UILabel!
  ///手机号
    @IBOutlet weak var iphoneLabel: UILabel!
    ///借阅时间
    @IBOutlet weak var borrowerTimeLabel: UILabel!
    ///归还时间
    @IBOutlet weak var backTimeLabel: UILabel!
    
    
    var model: MLBookRecordInfoModel!
    var row: Int = 0
    //MARK: - 
    func setupUI(item: MLBookRecordInfoModel){
        model = item
        numLbel.text = "\(row + 1)"
        bookTitleLabel.text = model.recordBookTitle
        bookAthourLabel.text = model.recordBookAuthor
        bookPressLabel.text = model.recordBookPress
        bookISBNLabel.text = model.recordBookISBN
        recordBorrowerLabel.text = model.recordBorrower
        iphoneLabel.text = model.userIphone
        borrowerTimeLabel.text = model.recordBorrowerTime
        backTimeLabel.text = model.recordBackTime
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    @IBAction func editBtnAction(_ sender: UIButton) {
        btnClickBlock(.jieYueGuanLiEditType)
    }
    
    @IBAction func jieyueBtnAction(_ sender: UIButton) {
        btnClickBlock(.jieYueType)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
