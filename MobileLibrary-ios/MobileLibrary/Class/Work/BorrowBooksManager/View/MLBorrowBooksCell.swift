//
//  MLBorrowBooksCell.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/3/30.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import UIKit

class MLBorrowBooksCell: UITableViewCell {
    static let kCellId = "MLBorrowBooksCell"
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var saoBtn: UIButton!
    @IBOutlet weak var rightImageView: UIImageView!
    typealias BackBlock = () -> Void
    @objc var backActionBlock: BackBlock?
    
    
    
    var model: MLUserInfoModel!
    var oprtionType:MLAddPeopleOptionType = .addManage
    var brrowMdoel: MLBorrowBooksModel!

    
    func setupUIData(item: MLBorrowBooksModel){
        brrowMdoel = item
        nameLabel.text  = item.title
        contentLabel.text = item.titleValue
        if item.title == "图书编码" {
            rightImageView.isHidden = true
            saoBtn.isHidden = false
        }else{
            rightImageView.isHidden = false
            saoBtn.isHidden = true
        }
        
    }
    
    
    
    
    
    var name: String = "" {
        didSet{
            self.nameLabel.text = name
        }
    }
    

    func setupReaderUI(item: MLUserInfoModel,sec: Int,row: Int){
        model = item
        
        if sec == 0 {///人员基本信息
            switch row {
            case 0:///姓名
                contentLabel.text = item.userName
            case 1:///性别
                contentLabel.text = item.userSex == 1 ? "男" : "女"
            case 2:///年龄
                contentLabel.text = item.userAge
            case 3:///角色
                contentLabel.text = item.userRole == MLPublickTool.kReader ? "读者" : "读者"
            case 4:
                contentLabel.text = item.cardId
            default:
                MLDeugLog(message: "--  错误 --")
            }
        } else {
            switch row {
            case 0:
                contentLabel.text = item.userIphone
            case 1:
                contentLabel.text = item.userEmail
            case 2:
                contentLabel.text = item.readCardId
            case 3:
                contentLabel.text = item.borrowStartDate
                
            default:
                MLDeugLog(message: "-- 错误 --")
            }
            
            
        }
    }
    
    
    func setupUI(item: MLUserInfoModel,sec: Int,row: Int){
        model = item
        
        if sec == 0 {///人员基本信息
            switch row {
            case 0:///姓名
                contentLabel.text = item.userName
            case 1:///性别
                if item.userSex == 0 {
                    contentLabel.text = ""
                }else {
                    contentLabel.text = item.userSex == 1 ? "男" : "女"
                }
                
            case 2:///年龄
                contentLabel.text = item.userAge
            case 3:///角色
                if !item.userRole.isEmpty {
                    contentLabel.text = item.userRole == MLPublickTool.kSupeManager ? "超级管理员" : "管理员"
                }else{
                    contentLabel.text = ""
                }
                
            case 4:
                if item.adminLevel == 0 {
                    contentLabel.text = ""
                }else {
                    contentLabel.text = "\(item.adminLevel)楼"
                }
                
            case 5:
                contentLabel.text = item.employeeId
            case 6:
                contentLabel.text = item.cardId
                
            default:
                MLDeugLog(message: "--  错误 --")
            }
            
        } else {///联系方式
          
            switch row {
            case 0:
                contentLabel.text = item.userIphone
            case 1:
                contentLabel.text = item.userEmail
            case 2:
                contentLabel.text = item.readCardId
            case 3:
                contentLabel.text = item.borrowStartDate
                
            default:
                MLDeugLog(message: "-- 错误 --")
            }

        }
    }
    
    
    @IBAction func saoBtnAction(_ sender: UIButton) {
        if (self.backActionBlock != nil){
            self.backActionBlock?()
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
