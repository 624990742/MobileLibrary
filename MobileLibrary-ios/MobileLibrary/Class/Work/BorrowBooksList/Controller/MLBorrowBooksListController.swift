//
//  MLBorrowBooksListController.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/3/31.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import UIKit


enum MLRecordBookStateType: Int {
    case zero = 0 ///未申请
    case one = 1 /// 已申请，等待管理员审核
    case two = 2 ///已借阅成功,管理员已经批准
}

class MLBorrowBooksListController: MLBaseController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navViewTop: NSLayoutConstraint!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var textField: UITextField!
    
    
    
    var oprtionType:MLBookOptionType = .jieYueType
    var dataSource: [MLBookRecordInfoModel] = [MLBookRecordInfoModel]()
    lazy var addItem: UIBarButtonItem = {
            let btn = UIButton()
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
            btn.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
            btn.setTitle("新增", for: .normal)
            btn.setTitleColor(.white, for: .normal)
            btn.addTarget(self, action: #selector(addAction), for: .touchUpInside)
            btn.layoutButtonImageEdgeInsetsStyle(style: KKButtonEdgeInsetsStyle.top, space: 3)
            return UIBarButtonItem(customView: btn)
        }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        let header = MJRefreshNormalHeader()
        header.refreshingTarget = self
        header.refreshingAction = #selector(refreshData)
        self.tableView.mj_header = header
        NotificationCenter.default.addObserver(self, selector: #selector(upadteData), name: NSNotification.Name.init(rawValue: ML_BOOTDETAIL_UPDATE), object: nil)
        refreshData()
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self)
    }

    func setupUI() {

        let title = self.oprtionType == .guiHuanType ? "归还管理" : "借阅管理"
        self.setNavTitle(title: title)
        self.navViewTop.constant = self.navBarHeight
        
        if self.oprtionType == .jieYueType {
            self.gk_navRightBarButtonItem = self.addItem
        }
        
        
        if #available(iOS 15.0, *) {
            self.tableView.sectionHeaderTopPadding = 0
        }
        if #available(iOS 11.0, *) {
            self.tableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
   
        let cellId = self.oprtionType == .jieYueType ? MLBrrowBookListCell.kCellId : MLBackBooksListCell.kCellId
        self.tableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
    }
    
    
    @objc func addAction(){
        let vc = MLBorrowBooksController.init(nibName: "MLBorrowBooksController", bundle: nil)
        vc.oprtionType = self.oprtionType
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
   @objc func refreshData() {
        if self.oprtionType == .guiHuanType {
            getBorrowBooksListData(reacordBookState: MLRecordBookStateType.two)
            
        }else{
            getBorrowBooksListData(reacordBookState: MLRecordBookStateType.one)
        }
    }
    
    
    @IBAction func searchBtnAction(_ sender: UIButton) {
       
      
        guard let text = textField.text  else {
                MLAlert.show(type: .warning, text: "请检查输入的条件内容")
            return
        }
        
        
        var userIphone = ""
        var userName = ""
        if text.isMobile() {
            userIphone = text
        }
        if text.isNickname() {
            userName = text
        }
        
        if userIphone.isEmpty && userName.isEmpty {
            MLAlert.show(type: .warning, text: "请检查输入的条件内容")
            return
        }
        
        let userId = MLUserInfoManager.userId ?? ""
        
        MLNetManager.loadNetData(API: MLNetAPI.self, target: .searchBookRecord(userId:userId, userName: userName, userIphone: userIphone)) { code, dict, msg in
            
            guard let dict = dict as? [String: Any],
                  let result = dict["Data"] as? Array<Any> else {
                MLDeugLog(message: "无法解析响应结果")
                return
            }
            
            if self.dataSource.count > 0 {
                self.dataSource.removeAll()
            }
            
            self.dataSource = [MLBookRecordInfoModel].deserialize(from: result)  as? [MLBookRecordInfoModel]  ?? [MLBookRecordInfoModel]()
            
            self.tableView.reloadData()
        } failure: { code, msg in
            MLAlert.show(type: MLAlert.AlertType.error, text: msg)
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

extension MLBorrowBooksListController: UITableViewDelegate, UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
  
        if self.oprtionType == .guiHuanType  {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: MLBackBooksListCell.kCellId , for: indexPath) as! MLBackBooksListCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.row = indexPath.row
            let model = self.dataSource[indexPath.row]
            cell.setupUI(item: model)
            cell.btnClickBlock = { type  in
                self.backBookRecordData(userId: model.userId,recordId: model.recordId)
            }
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MLBrrowBookListCell.kCellId , for: indexPath) as! MLBrrowBookListCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.row = indexPath.row
        let model = self.dataSource[indexPath.row]
        cell.setupUI(item: model)
        cell.btnClickBlock = { type in
            if type == .jieYueType {///借阅审批
             self.updateBorrowBooksInfo(recordId: model.recordId)
                
            }else{//编辑
                let vc = MLBorrowBooksController.init(nibName: "MLBorrowBooksController", bundle: nil)
                vc.oprtionType = .jieYueGuanLiEditType
                vc.recordModel = model
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        return cell

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if self.oprtionType == .guiHuanType  {
            return 280
        }
     return 360
    }

    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
    }
 
}


//MARK: - 网络

extension MLBorrowBooksListController {
    
    @objc func upadteData() {
        DispatchQueue.main.async {
            self.refreshData()
        }
    }

    func backBookRecordData(userId: String,recordId: Int){
        
        MLNetManager.loadNetData(API: MLNetAPI.self, target: .backBook(userId: userId, recordId: recordId)) { code, dict, msg in
            if code == 200 {
                MLAlert.show(type: MLAlert.AlertType.success, text: "归还成功")
                self.getBorrowBooksListData(reacordBookState: MLRecordBookStateType.two)
                return
            }
        } failure: { code, msg in
            MLAlert.show(type: MLAlert.AlertType.error, text: msg)
            self.tableView.mj_header?.endRefreshing()
        }

    }
    
    
    
    
    ///管理员点击借阅之后，意味着已经同意用户借阅
    func updateBorrowBooksInfo(recordId: Int) {
        let userId = MLUserInfoManager.userId ?? ""
        MLNetManager.loadNetData(API: MLNetAPI.self, target: .updateBorrowBookRecordState(userId: userId, recordId: recordId)) { code, dict, msg in
            if code == 200 {
                MLAlert.show(type: MLAlert.AlertType.success, text: "借阅审批成功，请让用户取走对应的借阅书籍！")
                self.getBorrowBooksListData(reacordBookState: MLRecordBookStateType.one)
                self.tableView.mj_header?.endRefreshing()
            }else{
                self.tableView.mj_header?.endRefreshing()
            }
            
        } failure: { code, msg in
            MLAlert.show(type: MLAlert.AlertType.error, text: msg)
            self.tableView.mj_header?.endRefreshing()
        }

    }
    
    
    
    
    ///获取需要管理员审核的借阅记录
    func getBorrowBooksListData(reacordBookState: MLRecordBookStateType) {
        
        let userId = MLUserInfoManager.userId ?? ""
        MLNetManager.loadNetData(API: MLNetAPI.self, target: .allBookRecordStateInfo(userId: userId, reacordBookState: reacordBookState.rawValue)) { code, dict, msg in
           
            self.tableView.mj_header?.endRefreshing()
            guard let dict = dict as? [String: Any],
                  let result = dict["Data"] as? Array<Any> else {
                MLAlert.show(type: MLAlert.AlertType.warning, text: "暂无记录")
                return
            }
            if result.isEmpty {
                MLAlert.show(type: MLAlert.AlertType.warning, text: "无法解析响应结果")
                return
            }
            
            self.dataSource = [MLBookRecordInfoModel].deserialize(from: result)  as? [MLBookRecordInfoModel]  ?? [MLBookRecordInfoModel]()

            self.tableView.reloadData()
            
            
        } failure: { code, msg in
            MLAlert.show(type: MLAlert.AlertType.error, text: msg)
            self.tableView.mj_header?.endRefreshing()
        }

    }
    
    
    
}
