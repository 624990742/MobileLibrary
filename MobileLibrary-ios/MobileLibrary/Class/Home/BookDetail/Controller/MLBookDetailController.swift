//
//  MLBookDetailController.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/4/6.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import UIKit

class MLBookDetailController: MLBaseController {
    @IBOutlet weak var tableViewTop: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomToolView: UIView!
    @IBOutlet weak var optionLabel: UILabel!
    @IBOutlet weak var numLabel: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var bottomViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var bottomToolBtn: UIButton!
    
    var book: MLBookInfoModel!
    var isHaveRecord: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(upadteData), name: NSNotification.Name.init(rawValue: ML_BOOTDETAIL_UPDATE), object: nil)
        setupUI()
        getData()

    }
    
    func setupUI(){
        self.tableViewTop.constant = self.navBarHeight
        self.gk_navTitle = "图书信息"
        
        let  headView  = MLBookHeaderView.loadFromNib("MLBookHeaderView")
        var headerHeight = 340.0
        if book != nil {
            headView.setupData(item: book)
            //            headerHeight = 260
            headerHeight = headView.getHeaderHeight()
        }
        MLDeugLog(message: "高度:\(headerHeight)")
        headView.frame = CGRect(x: 0, y: 0, width: Int(ML_ScreenWidth), height: Int(headerHeight))
        headView.backgroundColor = ML_AppThemeColor
        self.tableView.tableHeaderView = headView
        
        self.tableView.register(UINib(nibName: MLBookDetailCell.kcellId, bundle: nil), forCellReuseIdentifier: MLBookDetailCell.kcellId)
        self.bottomToolView.layer.cornerRadius = 30
        self.bottomToolView.layer.masksToBounds = true
        self.bottomView.setupShadow()
    }
    
    
    
    func getData(){
        
        
        
        guard let item = book else {
            MLDeugLog(message: "--- 未知错误 -- ")
            return
        }
        let userId = MLUserInfoManager.userId ?? ""
        let recordBookISBN = book.bookISBN
        MLNetManager.loadNetData(API: MLNetAPI.self, target: .getBookRecordState(userId: userId, recordBookISBN: recordBookISBN)) { code, dict, msg in
            if code != 200 {///成功
                MLAlert.show(type: MLAlert.AlertType.error, text: msg)
                return
            }
            
            guard let dict = dict as? [String: Any],
                  let result = dict["Data"] as? [String: Any] else {
                MLDeugLog(message: "无法解析响应结果")
                return
            }
            if result.isEmpty {
                MLAlert.show(type: MLAlert.AlertType.error, text: msg)
                return
            }

            let isHaveRecord = result["isHaveRecord"] as? Int ?? 0
            self.showBootom(isHaveRecord: isHaveRecord)
        } failure: { code, msg in
            MLAlert.show(type: MLAlert.AlertType.error, text: msg)
        }

    }
    
    
    func showBootom(isHaveRecord: Int){
        self.isHaveRecord = isHaveRecord
        if MLUserInfoManager.userRole == MLPublickTool.kSupeManager ||  MLUserInfoManager.userRole == MLPublickTool.kManager {
            self.bottomView.isHidden = true
            self.bottomViewHeight.constant = 0
        }else{
            self.bottomView.isHidden = false
            self.bottomViewHeight.constant = 110
        }

    
        if isHaveRecord == 2 {
            self.bottomToolView.backgroundColor = UIColor(hexString: "0xF5C266")
            self.optionLabel.text = "您已借阅"
        }else if isHaveRecord == 1 {
            
            self.bottomToolView.backgroundColor = UIColor(hexString: "0xF5C266")
            self.optionLabel.text = "已借阅,待管理员审核!"
        } else{
            self.bottomToolView.backgroundColor = ML_AppThemeColor
            self.optionLabel.text = "申请借阅"
        }
        
        self.tableView.reloadData()
    }
    
    
    
    
    
    @IBAction func optionBtnAction(_ sender: UIButton) {
    
        if isHaveRecord > 0 {
            MLAlert.show(type: MLAlert.AlertType.warning, text: "这本书您已经借阅过啦！")
           return
        }
        let vc = MLBorrowBooksController.init()
        vc.oprtionType = .bookDetailType
        vc.book = self.book
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    @objc func upadteData() {
    DispatchQueue.main.async {
        self.getData()
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

extension MLBookDetailController: UITableViewDelegate, UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: MLBookDetailCell.kcellId , for: indexPath) as! MLBookDetailCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.setupUI(model: self.book)
        return cell

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      
        return 140
    }
        
    
     
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
     
        return 4
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor =  UIColor(hexString: "0xF7F7F7")
        return header
    }
    
    
   
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
      
        return CGFLOAT_MIN
    }
    
 
}


