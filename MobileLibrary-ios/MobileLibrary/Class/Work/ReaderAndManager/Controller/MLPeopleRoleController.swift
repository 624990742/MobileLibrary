//
//  MLPeopleRoleController.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/3/30.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import UIKit


enum  MLPeopleRoleListType: Int {
    case   MLPeopleRole_reader = 0///读者
    case   MLPeopleRole_manager = 1///管理者
}

class MLPeopleRoleController: MLBaseController, UITextFieldDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchSuperTop: NSLayoutConstraint!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var searchBtn: UIButton!
    var roleType: MLPeopleRoleListType = .MLPeopleRole_manager
//    var peopleList: [MLReaderAndManagerPeopleInfoModel] = [MLReaderAndManagerPeopleInfoModel]()
    var peopleList: [MLUserInfoModel] = [MLUserInfoModel]()
    var allList: [MLUserInfoModel] = [MLUserInfoModel]()
    
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
         setupData()
        self.tableView.reloadData()
    }

    
    func setupData(){
//        let jsonStr = MLPublickTool.getJsonString(fileName: "PeopleInfoList")
//        let peoples = [MLReaderAndManagerPeopleInfoModel].deserialize(from: jsonStr)
//        let userRole = self.roleType == .MLPeopleRole_manager ? "admin": "reader"
//        self.peopleList =  peoples?.filter({$0?.userRole == userRole}) as! [MLReaderAndManagerPeopleInfoModel]
        self.peopleList.removeAll()
        self.allList.removeAll()
        if self.roleType == .MLPeopleRole_manager {
             self.allList = MLDataManager.shareManager.fetchAllData(tableName: MLDataManager.KUSER_INFO_TABLE,role: MLPublickTool.kManager)
        } else {
             self.allList = MLDataManager.shareManager.fetchAllData(tableName: MLDataManager.KUSER_INFO_TABLE,role: MLPublickTool.kReader)
        }
        self.peopleList = self.allList
    
    }
        
        
    
    
    func setupUI() {
        let navTitle = self.roleType == .MLPeopleRole_manager ? "员工管理" : "读者管理"
        let textFieldPlaceholder = self.roleType == .MLPeopleRole_manager ? "请输入姓名或员工号进行搜索": "请输入姓名或借阅证号进行搜索"
        self.setNavTitle(title:navTitle)
        self.inputTextField.placeholder = textFieldPlaceholder
        
        self.searchSuperTop.constant = GKDevice.navBarHeight()
        
        if #available(iOS 15.0, *) {
            self.tableView.sectionHeaderTopPadding = 0
        }
        if #available(iOS 11.0, *) {
            self.tableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        self.tableView.register(UINib(nibName: MLPeopleRoleCell.kcellId, bundle: nil), forCellReuseIdentifier: MLPeopleRoleCell.kcellId)
        
        self.gk_navRightBarButtonItem = self.addItem
        
//        inputTextField.delegate = self
        inputTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        inputTextField.addTarget(self, action: #selector(textFieldDidEnd(_:)), for: .editingDidEnd)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateListData), name: NSNotification.Name.init(rawValue: ML_UPDATE_PEOPLE_SUCCESS), object: nil)
    }
    

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    @objc func updateListData () {
        self.setupData()
        self.tableView.reloadData()
    }
    
    
    @objc func addAction(){

        let vc = MLAddPeopleController.init()
        if self.roleType == .MLPeopleRole_manager {
            vc.oprtionType = .addManage
        }else{
            vc.oprtionType = .addReader
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func searchBtnAction(_ sender: UIButton) {
        
        let tt = inputTextField.text ?? ""
        
    
        if tt.isNickname() {
            let conditions = ["userRole": tt] as [String : String]
            self.peopleList =  MLDataManager.shareManager.queryConditions(tableName: MLDataManager.KUSER_INFO_TABLE,isAnd: false,conditions: conditions as [String : Any])
            
        }
        
        if tt.isPureNumer() {
            let conditions = ["employeeId": tt] as [String : String]
            self.peopleList =  MLDataManager.shareManager.queryConditions(tableName: MLDataManager.KUSER_INFO_TABLE,isAnd: false,conditions: conditions as [String : Any])
            
        }
        
    
        self.tableView.reloadData()

    }
    
    
    @objc func textFieldDidChange(_ textField: UITextField){
        
        MLDeugLog(message: "\(String(describing: textField.text))")
        
     if ((textField.text?.isEmpty) != nil) {
            self.peopleList = self.allList
         self.tableView.reloadData()
        }
    }
    
    
    @objc func textFieldDidEnd(_ textField: UITextField){
            
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

extension MLPeopleRoleController: UITableViewDelegate, UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.peopleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
  
        let cell = tableView.dequeueReusableCell(withIdentifier: MLPeopleRoleCell.kcellId , for: indexPath) as! MLPeopleRoleCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.setupData(item: self.peopleList[indexPath.row])
        cell.backActionBlock = {[weak self] item in
            let vc = MLAddPeopleController.init()
            
            if self?.roleType == .MLPeopleRole_manager {
                vc.oprtionType = .managerInfo
            }else{
                vc.oprtionType = .readerInfo
            }

            vc.item = item
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        return cell

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

     return 125
    }


    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
     return CGFLOAT_MIN
    }
  
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {

        
        let footerView = UIView()
        footerView.backgroundColor = .clear
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
       
        return CGFLOAT_MIN
    }
    

    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "删除") { [weak self] (action, view, completionHandler) in
            
            
            let model = self?.peopleList[indexPath.row]
            
            MLDataManager.shareManager.deleteDataWith(tableName: MLDataManager.KUSER_INFO_TABLE, conditions: ["userId":model?.userId ?? ""])
            
            self?.setupData()
            self?.tableView.reloadData()
            
            
            completionHandler(true)
        }
        deleteAction.backgroundColor = .red // 自定义删除按钮颜色

        let modifyAction = UIContextualAction(style: .normal, title: "修改") { [weak self] (action, view, completionHandler) in
            
            
            let model = self?.peopleList[indexPath.row]
            model?.employeeId = "003"
            
            MLDataManager.shareManager.updateData(tableName: MLDataManager.KUSER_INFO_TABLE, primaryKeyColumn: "userId", primaryKeyValue: model?.userId ?? "", updates: ["employeeId":model?.employeeId ?? ""])
            self?.setupData()
            self?.tableView.reloadData()
            
            completionHandler(true)
        }
        modifyAction.backgroundColor = .blue // 自定义修改按钮颜色

        // 设置按钮文字颜色（如果需要）
        deleteAction.backgroundColor = UIColor(hexString: "0xff3b30")
        modifyAction.backgroundColor = .orange

        return UISwipeActionsConfiguration(actions: [deleteAction, modifyAction])
    }
    
    
    
 
}
