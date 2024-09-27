//
//  MLCollectionBookController.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/5/15.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import UIKit

class MLCollectionBookController: MLBaseController {

    @IBOutlet weak var tableTop: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    var dataSource:[MLMeCollectionModel]!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableTop.constant = self.navBarHeight
        self.tableView.register(UINib(nibName: MLCollectionBookViewCell.kCellID, bundle: nil), forCellReuseIdentifier: MLCollectionBookViewCell.kCellID)
        
        self.setNavTitle(title: "我的收藏")
        self.setupData()
        self.tableView.reloadData()
    }
    
    
    func setupData(){
        let sqlParams: [String : Any] = [:]
        let result = MLDataManager.shareManager.searchData(tableName: MLDataManager.KCOLLECTION_BOOK_INFO_TABLE, isAnd: true, conditions: sqlParams)
        guard let re = result else {
            return
        }
        self.dataSource = [MLMeCollectionModel].deserialize(from: re) as? [MLMeCollectionModel]
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

extension MLCollectionBookController: UITableViewDelegate, UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
            let cell = tableView.dequeueReusableCell(withIdentifier: MLCollectionBookViewCell.kCellID , for: indexPath) as! MLCollectionBookViewCell
                cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.setupUI(item: self.dataSource[indexPath.row])
            return cell

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      
        return MLiPhoneHalf(60)
    }
        
   
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "取消收藏") { [weak self] (action, view, completionHandler) in
            
            let model = self?.dataSource[indexPath.row]
            MLDataManager.shareManager.deleteDataWith(tableName: MLDataManager.KCOLLECTION_BOOK_INFO_TABLE, conditions: ["bookISBN":model?.bookISBN ?? ""])
            self?.setupData()
            self?.tableView.reloadData()
            completionHandler(true)
        }
        deleteAction.backgroundColor = .red // 自定义删除按钮颜色
        deleteAction.backgroundColor = UIColor(hexString: "0xff3b30")
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }

}
