//
//  MLAddPeopleController.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/3/30.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import UIKit



public enum MLAddPeopleOptionType {
    case addManage///增加管理员，可以编辑
    case addReader///增加读者，可以编辑
    case managerInfo ///只展示管理员信息，不能编辑
    case readerInfo ///只展示读者信息，不能编辑
}
class MLAddPeopleController: MLBaseController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewTop: NSLayoutConstraint!
    @IBOutlet weak var bottomToolView: UIView!
    
    
    @IBOutlet weak var bottomToolHeight: NSLayoutConstraint!
    var oprtionType:MLAddPeopleOptionType = .addManage
    var item: MLUserInfoModel?
    var titlesArr: [[String]] = [[String]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupUI()
    }
    func setupUI() {
                
        switch oprtionType {
        case .addManage:
            self.setNavTitle(title: "新增管理员")
            self.bottomToolView.isHidden = false
            self.item = MLUserInfoModel.init()
            self.bottomToolHeight.constant = MLiPhoneHalf(80)
        case .addReader:
            self.setNavTitle(title: "新增读者")
            self.bottomToolView.isHidden = false
            self.item = MLUserInfoModel.init()
            self.bottomToolHeight.constant = MLiPhoneHalf(80)
        case .managerInfo:
            self.setNavTitle(title: "理员基本信息")
            self.bottomToolView.isHidden = true
            self.bottomToolHeight.constant = 0
        case .readerInfo:
            self.setNavTitle(title: "读者基本信息")
            self.bottomToolView.isHidden = true
            self.bottomToolHeight.constant = 0
        default:
            MLDeugLog(message: "000")
        }
        
        
        self.tableViewTop.constant = self.navBarHeight
        if #available(iOS 15.0, *) {
            self.tableView.sectionHeaderTopPadding = 0
        }
        if #available(iOS 11.0, *) {
            self.tableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        self.tableView.register(UINib(nibName: MLBorrowBooksCell.kCellId, bundle: nil), forCellReuseIdentifier: MLBorrowBooksCell.kCellId)
        
    }
    
    
    func setupData() {
        
        if self.oprtionType == .addManage || self.oprtionType == .managerInfo {
            self.titlesArr = [["姓名","性别","年龄","角色","管理位置","员工号","身份证号"]
                       ,["手机号","邮箱号","借阅证号","注册时间"]]
        }else{
            self.titlesArr = [["姓名","性别","年龄","角色","身份证号"]
                      ,["手机号","邮箱号","借阅证号","注册时间"]]
        }
    }

    
    
    @IBAction func sureBtnAction(_ sender: UIButton) {
       
        
        guard let model = self.item else {
            MLAlert.show(type: .warning, text: "请检查数据")
            return
        }
        
        if model.userName.isEmpty == false
            && model.userIphone.isEmpty == false
            && model.cardId.isEmpty == false
        {
            guard let dict  = model.toJSON() else {
                return
            }
           let state  = MLDataManager.shareManager.insertData(tableName: MLDataManager.KUSER_INFO_TABLE, dict: dict)
            if state {
                MLAlert.show(type: .success, text: "添加成功")
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: ML_LOGIN_SUCCESS), object: nil)
                self.navigationController?.popViewController(animated: true)
            }else{
                MLAlert.show(type: .error, text: "添加失败，请检查数据")
            }
        }else{
            MLAlert.show(type: .warning, text: "请检查数据")
        }

    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
// MARK: -  UITableViewDelegate, UITableViewDataSource

extension MLAddPeopleController: UITableViewDelegate, UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return titlesArr.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let arr = titlesArr[section]
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
  
        let cell = tableView.dequeueReusableCell(withIdentifier: MLBorrowBooksCell.kCellId , for: indexPath) as! MLBorrowBooksCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.oprtionType = self.oprtionType
        cell.name = titlesArr[indexPath.section][indexPath.row]
        
        switch self.oprtionType {
        case .managerInfo,.addManage:
            cell.setupUI(item: self.item ?? MLUserInfoModel.init(),sec: indexPath.section,row: indexPath.row)
            
        case .readerInfo, .addReader:
            cell.setupReaderUI(item: self.item ?? MLUserInfoModel.init(), sec: indexPath.section, row: indexPath.row)
        
        default:
            MLDeugLog(message: "-- --")
        }
        
        return cell

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

     return 50
    }

    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
     return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
      let header = MLBorrowBooksHeaderView()
        
        header.titleLabel.text = section == 1 ? "其他信息" : "人员基本信息"
        return header
        
    }
    
    
  
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {

        
        let footerView = UIView()
        footerView.backgroundColor = .clear
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
       
        return CGFLOAT_MIN
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if self.oprtionType == .addManage || self.oprtionType == .addReader {
            let vc = MLInputInfoController.init()
            vc.addSec = indexPath.section
            vc.addRow = indexPath.row
            vc.backActionBlock = {[weak self] txt, sec, row  in
                self?.dealData(txt: txt, sec: sec, row: row)
                self?.tableView.reloadData()
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func dealData(txt: String,sec: Int, row: Int) {
    
        
        if self.oprtionType == .addReader {
            
            if sec == 0 {
                
                  switch row {
                  case 0:///姓名
                      item?.userName = txt
                  case 1:///性别
                      item?.userSex = Int(txt) ?? 1
                  case 2:///年龄
                      item?.userAge = txt
                  case 3:///角色
                      item?.userRole = txt
                  case 4:
                      item?.cardId = txt
                  default:
                      MLDeugLog(message: "--  错误 --")
                  }
                
            } else {
                
                
                switch row {
                case 0:
                    item?.userIphone  = txt
                case 1:
                    item?.userEmail = txt
                case 2:
                    item?.readCardId = txt
                case 3:
                    item?.borrowStartDate = txt
                    
                default:
                    MLDeugLog(message: "-- 错误 --")
                }
            }
        }
        
        
        if self.oprtionType == .addManage {
            
            if sec == 0 {///人员基本信息
                switch row {
                case 0:///姓名
                    item?.userName = txt
                case 1:///性别
                    item?.userSex = Int(txt) ?? 1
                case 2:///年龄
                    item?.userAge = txt
                case 3:///角色
                    item?.userRole = txt
                case 4:
                    item?.adminLevel = Int(txt) ?? 1
                case 5:
                    item?.employeeId = txt
                case 6:
                    item?.cardId = txt
                default:
                    MLDeugLog(message: "--  错误 --")
                }
                
            } else {///联系方式
              
                switch row {
                case 0:
                    item?.userIphone = txt
                case 1:
                    item?.userEmail = txt
                case 2:
                    item?.readCardId = txt
                case 3:
                    item?.borrowStartDate = txt
                    
                default:
                    MLDeugLog(message: "-- 错误 --")
                }

            }

        }
        
        
        
        
        
    }
    
    
    
    
    
    
    
}
