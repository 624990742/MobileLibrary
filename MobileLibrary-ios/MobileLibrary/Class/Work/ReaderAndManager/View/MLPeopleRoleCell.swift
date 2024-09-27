//
//  MLManagerPeopleCell.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/3/30.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import UIKit


class MLPeopleRoleCell: UITableViewCell {
    static let kcellId = "MLPeopleRoleCell"
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var cardIdLabel: UILabel!
    @IBOutlet weak var lookBtn: UIButton!
    typealias BackBlock = (_ item: MLUserInfoModel) -> Void
     var backActionBlock: BackBlock?
    
    
//    var model: MLReaderAndManagerPeopleInfoModel!
//    func setupData(item: MLReaderAndManagerPeopleInfoModel?){
    
    var model: MLUserInfoModel!
    func setupData(item: MLUserInfoModel?){
        
        guard let itemModel = item else {
            return
        }
        model = itemModel
        userNameLabel.text = itemModel.userName
        
       switch itemModel.userRole {
        case MLPublickTool.kSupeManager:
            roleLabel.text = MLPublickTool.kSupeManagerName
           stateLabel.text = "在职"
           cardIdLabel.text = itemModel.employeeId
           break
        case MLPublickTool.kManager:
            roleLabel.text = MLPublickTool.kManagerName
           stateLabel.text = "在职"
           cardIdLabel.text = itemModel.employeeId
           break
        case MLPublickTool.kReader:
            roleLabel.text = MLPublickTool.kReader
           stateLabel.text = "正常"
           cardIdLabel.text = itemModel.readCardId
           break
        default:
           roleLabel.text = "未知角色"
            MLDeugLog(message: "-- 出错了 --")
        }
        
        iconImageView.image = UIImage(named: item?.userIcon ?? "suerIcon1")
//        iconImageView.image = UIImage(named: MLPublickTool.kUserIcons.randomElement()!)
//        if itemModel.userRole  == "admin"  {
//            stateLabel.text = "在职"
//            cardIdLabel.text = itemModel.employeeId
//        }else{
//            stateLabel.text = "正常"
//            cardIdLabel.text = itemModel.readCardId
//        }
            
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        self.lookBtn.layer.cornerRadius = 4.0
        self.lookBtn.layer.masksToBounds = true

        
    }

    
    @IBAction func lookBtnAction(_ sender: UIButton) {
        if (self.backActionBlock != nil) {
            self.backActionBlock?(model)
        }
    }
    

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
