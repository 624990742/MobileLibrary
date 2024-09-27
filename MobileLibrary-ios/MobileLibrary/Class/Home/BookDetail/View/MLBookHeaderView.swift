//
//  MLBookHeaderView.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/4/6.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import UIKit

class MLBookHeaderView: UIView ,MLNibLoadElement {
    @IBOutlet weak var bookCoverImageView: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var authourLabel: UILabel!
    @IBOutlet weak var bookTypeLabel: UILabel!
    @IBOutlet weak var numLabel: UILabel!
    @IBOutlet weak var bookBrifeView: UIView!
    @IBOutlet weak var bookBfireContentLabel: UILabel!
    @IBOutlet weak var collectionBtn: UIButton!
    @IBOutlet weak var stateLabel: UILabel!
    
    
    var isCollection: Bool = false
    
    var book: MLBookInfoModel!
    func setupData(item: MLBookInfoModel) {
        book = item
        self.bookCoverImageView.image = UIImage(named: book.bookCover)
        self.bookTitleLabel.text = book.bookTitle
        self.authourLabel.text = book.bookAuthor
        self.bookTypeLabel.text = book.bookCategory
        self.numLabel.text = "\(book.bookLibTotal)"
        self.bookBfireContentLabel.text = book.bookBrief
        
        if book.bookLibTotal > 0 {
            stateLabel.text = "状态：有库存"
        }else{
            stateLabel.text = "状态：已借完"
        }
        
        
        let sqlParams: [String : Any] = ["bookISBN":book.bookISBN]
        let result = MLDataManager.shareManager.searchData(tableName: MLDataManager.KCOLLECTION_BOOK_INFO_TABLE, isAnd: false, conditions: sqlParams)
        if result?.count ?? 0 > 0 {
            collectionBtn.setTitle("已收藏", for: UIControl.State.normal)
            isCollection = true
        }else{
            collectionBtn.setTitle("收藏", for: UIControl.State.normal)
            isCollection = false
        }
    }
    
    override  func awakeFromNib() {
        super.awakeFromNib()
        collectionBtn.layer.cornerRadius = 10.0
        collectionBtn.layer.masksToBounds = true
        collectionBtn.layer.borderWidth = 1.0
        if MLUserInfoManager.userRole == MLPublickTool.kSupeManager || MLUserInfoManager.userRole == MLPublickTool.kManager {
            collectionBtn.isHidden = true
        }else{
            collectionBtn.isHidden = false
        }
    }
    
      func getHeaderHeight() -> CGFloat {
          let headerH = self.bookBfireContentLabel.sizeThatFits(CGSize(width: ML_ScreenWidth - 40.0, height: CGFloat.max)).height + 300
        return headerH
    }
    

    @IBAction func collectionBtnAction(_ sender: UIButton) {
        
        if isCollection  {
            MLAlert.show(type: .warning, text: "已收藏的图书取消需要去“我的收藏！”")
            return
        }
        
        if MLUserInfoManager.userRole == MLPublickTool.kSupeManager || MLUserInfoManager.userRole == MLPublickTool.kManager {
            return
        }
        
        if book.bookISBN.isEmpty {
            return
        }
        
        
        let dict = ["bookId":book.bookId,
                    "bookTitle":book.bookTitle,
                    "bookISBN":book.bookISBN,
                    "bookPress":book.bookPress,
                    "bookAuthor":book.bookAuthor,
                    "collectionTime":String.getCurrentDateFormattedToHour(),
        ] as [String : Any]
        
        let state = MLDataManager.shareManager.insertData(tableName: MLDataManager.KCOLLECTION_BOOK_INFO_TABLE, dict: dict)
        if state {
            isCollection = true
            collectionBtn.setTitle("已收藏", for: UIControl.State.normal)
            MLAlert.show(type: .success, text: "添加成功")
        }else{
            MLAlert.show(type: .error, text: "添加失败")
            collectionBtn.setTitle("收藏", for: UIControl.State.normal)
            isCollection = false
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
