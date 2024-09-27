//
//  MLSystemSetUpVC.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/3/4.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import UIKit


class MLSystemSetUpVC: MLBaseController, UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate{
  
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var tableViewTop: NSLayoutConstraint!
  
    typealias BackBlock = () -> Void
    @objc var backActionBlock: BackBlock?
    
    
    ///标题
    private lazy var titlesArr: [String] = {
        
        var arr = [String]()
            arr = ["修改密码",
                    "注销账号",
                   "退出登录"]
          return arr
      }()
 
    
    
    ///MARK: - lify
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }


   
    ///MARK: - 通知


    ///MARK: - UI
    func setupUI(){

        self.setNavTitle(title: "设置")
        self.view.backgroundColor = .white
        self.tableViewTop.constant = navBarHeight
        self.tableView.register(UINib.init(nibName: "MLMineCell", bundle: nil), forCellReuseIdentifier: MLMineCell.KCellID)
        self.tableView.contentInset = UIEdgeInsets(top: 0,left: 0,bottom: 20,right: 0)
        self.tableView.backgroundColor = .clear
        self.tableView.bounces = false
        if #available(iOS 11.0, *) {
            self.tableView.sectionHeaderHeight = 0;
            self.tableView.sectionFooterHeight = 0;
        }
         if #available(iOS 15.0, *) {
                self.tableView.sectionHeaderTopPadding = 0
            } else {
                // Fallback on earlier versions
            };
        self.tableView.reloadData()
    }

 
    
    //MARK: - UITableViewDelegate, UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return self.titlesArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: MLMineCell.KCellID , for: indexPath) as! MLMineCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
        let row = indexPath.row
        cell.mineTileLabel.text = self.titlesArr[row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader = UIView()
        sectionHeader.backgroundColor = ML_F7F8Color
        return sectionHeader
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0://修改密码
      
            let regiseterVC = MLRegisterController.init()
            regiseterVC.optionType = .modifyPasswordTyope
            if (self.backActionBlock != nil){
                self.backActionBlock?()
            }
            self.navigationController?.pushViewController(regiseterVC, animated: true)
        
        case 1://注销登录
            let logoutVC = MLLogoutController.init()
            self.navigationController?.pushViewController(logoutVC, animated: true)
            
            break
        case 2://退出
            MLUserInfoManager.logout { [weak self] in
                self?.navigationController?.popViewController(animated: false)
                if (self?.backActionBlock != nil){
                    self?.backActionBlock?()
                }
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: MLNOTIFICATION_LOGOUT), object: nil)
            } failure: { msg in
                
            }
            
        default:
            MLDeugLog(message: "--测试--")
        }
        
        
        
    }
    
  
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
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
