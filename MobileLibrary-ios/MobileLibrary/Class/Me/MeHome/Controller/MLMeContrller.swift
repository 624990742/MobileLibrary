//
//  MLMeContrller.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/3/4.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import UIKit


class MLMeContrller: MLBaseController {
       
     static let KLMineyMsg = "个人资料"
     static let KBindingCard = "借阅证"
     static let KLibraryMsg = "图书馆公告"
     static let KGuanYuWoMen = "关于我们"
     static let KSystemVersion = "系统版本"
     static let KCollectionBook = "我的收藏"
    
    var tableView: UITableView!
    var titleArray: [Any] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTitleData()
        NotificationCenter.default.addObserver(self, selector: #selector(logout), name: NSNotification.Name.init(rawValue: MLNOTIFICATION_LOGOUT), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(logout), name: NSNotification.Name.init(rawValue: ML_LOGIN_SUCCESS), object: nil)
    }
    


   deinit {
    NotificationCenter.default.removeObserver(self)
   }

    @objc func logout() {
    DispatchQueue.main.async {
        self.setupTitleData()
        self.tableView.reloadData()
    }
}
    
    @objc func login() {
        DispatchQueue.main.async {
            self.setupTitleData()
            self.tableView.reloadData()
        }
    }
    
    
    
    
    
    func setupUI(){
        self.setNavTitle(title: "我的")
        
        self.tableView = UITableView(frame: .zero, style: .plain)
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
        if #available(iOS 11.0, *) {
            self.tableView?.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        self.view.addSubview(self.tableView!)
        self.tableView!.snp.makeConstraints {
            $0.left.right.bottom.equalTo(self.view)
            $0.top.equalTo(self.gk_navigationBar.snp.bottom)
        }
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 200
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none

        if #available(iOS 15.0, *) {
            self.tableView.sectionHeaderTopPadding = 0
        }
        if #available(iOS 11.0, *) {
            self.tableView?.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        self.tableView.register(UINib.init(nibName: "MLMineHeaderCell", bundle: nil), forCellReuseIdentifier: MLMineHeaderCell.KCellID)
        self.tableView.register(UINib.init(nibName: "MLMineCell", bundle: nil), forCellReuseIdentifier: MLMineCell.KCellID)
        self.tableView.reloadData()
    }
    
     func setupTitleData() {
         
         guard let _ = MLUserInfoManager.userId else {
             titleArray = [MLMeContrller.KGuanYuWoMen,
                           MLMeContrller.KSystemVersion]
             return
         }
         
         if MLUserInfoManager.userRole == MLPublickTool.kSupeManager ||  MLUserInfoManager.userRole == MLPublickTool.kManager {
             titleArray = [MLMeContrller.KLMineyMsg,
                            MLMeContrller.KBindingCard,
                           MLMeContrller.KLibraryMsg,
                           MLMeContrller.KGuanYuWoMen];
         }else{
             titleArray = [MLMeContrller.KLMineyMsg,
                            MLMeContrller.KBindingCard,
                           MLMeContrller.KCollectionBook,
                           MLMeContrller.KLibraryMsg,
                           MLMeContrller.KGuanYuWoMen];
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

extension MLMeContrller: UITableViewDelegate, UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let sec = indexPath.section
        if sec == 0 {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: MLMineHeaderCell.KCellID , for: indexPath) as! MLMineHeaderCell
                cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.setupBtn.addTarget(self, action: #selector(setupBtnClick(btn:)), for: UIControl.Event.touchUpInside)
            cell.setupData()
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MLMineCell.KCellID , for: indexPath) as! MLMineCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
        let row = indexPath.row
        
        cell .setupUIData(title: titleArray[row] as? String ?? "")
            return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1{
            return 50.0
        }
        return UITableView.automaticDimension
    }
        
    
     
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
      
        return CGFLOAT_MIN
    }
    
   
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
      
        return CGFLOAT_MIN
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        let title = titleArray[indexPath.row] as! String
        if title == MLMeContrller.KSystemVersion {
              return
          }
        
       let loginState = MLHelper.isLoginState {
           self.setupTitleData()
           self.tableView.reloadData()
      }
        if !loginState {
            
            return
        }
        var vc = UIViewController()
        switch title {
        case MLMeContrller.KLMineyMsg:
            vc = MLPersonCenterController.init()
        case MLMeContrller.KGuanYuWoMen:
            vc = MLAboutUsVC.init()
        case MLMeContrller.KLibraryMsg:
            vc = MLBookAnnouncementController.init()
        case MLMeContrller.KBindingCard:
            vc = MLCardIDController.init()
        case MLMeContrller.KCollectionBook:
            vc = MLCollectionBookController.init()
        default:
            MLDeugLog(message: "-- 测试 --")
        }
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    @objc func setupBtnClick(btn: UIButton){
        
        
       let loginState = MLHelper.isLoginState {
           self.setupTitleData()
           self.tableView.reloadData()
      }
        
        if loginState {
            let setupVC = MLSystemSetUpVC.init()
            setupVC.backActionBlock = { [weak self] in
                DispatchQueue.main.async {
                    self?.setupTitleData()
                    self?.tableView.reloadData()
                }
            }
            self.navigationController?.pushViewController(setupVC, animated: true)
        }
    }
    
}
