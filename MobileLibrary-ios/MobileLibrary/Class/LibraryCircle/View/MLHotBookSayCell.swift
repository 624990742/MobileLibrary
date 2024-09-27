//
//  MLHotBookSayCell.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/3/27.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//
/*
 c5a88d
 969c92
 a6b2b5
 a9a4aa
 */
import UIKit

class MLHotBookSayCell: UITableViewCell {
    static let kCellID = "MLHotBookSayCell"
    
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var bgImgView: UIImageView!
    
    @IBOutlet weak var hotBgView: UIView!
    
    @IBOutlet weak var hotBgViewWidth: NSLayoutConstraint!
    
    @IBOutlet weak var bookImageView: UIImageView!
    
    @IBOutlet weak var bookTitleLabel: UILabel!
    
    
    @IBOutlet weak var bookAuthorLabel: UILabel!
    
    
    var model: MLLibraryCircleModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.bgImgView.layer.cornerRadius = 10
        self.bgImgView.layer.masksToBounds = true
        self.bgView.layer.cornerRadius = 10
        self.bgView.layer.masksToBounds = true
        
        self.hotBgView.layer.cornerRadius = self.hotBgViewWidth.constant * 0.5
        self.hotBgView.layer.masksToBounds = true
        
        
        ///先这么处理会有把颜色值放到model中就不会有复用的现象了
        self.bgView.backgroundColor = self.getRandomColor()
    }
    
    func setupCellStyle(item: MLLibraryCircleModel?) {
        model = item
        self.bookImageView.image = UIImage(named: item?.bookCover ?? "")
        self.bookTitleLabel.text  = "书名：" + (item?.bookTitle ?? "测试")
        self.bookAuthorLabel.text  = "作者：" + (item?.bookAuthor ?? "测试")

        self.bgView.backgroundColor = getRandomColor()        
    }
    
   
    func getRandomColor() -> UIColor {
        let colors = ["c5a88d", "969c92", "a6b2b5", "a9a4aa","a57873"]

        // 获取一个随机索引
        let randomIndex = Int.random(in: 0..<colors.count)

        // 使用随机索引获取一个随机颜色
        let randomColor = colors[randomIndex]

        // 使用这个颜色，例如设置视图背景色
        return UIColor(hexString: randomColor)
    }
      
    
    override func layoutSubviews() {
        super.layoutSubviews()
   
    }
    
    
    
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
