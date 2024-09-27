//
//  MLHotBookListController.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/4/11.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import UIKit

class MLHotBookListController: MLBaseController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableTop: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    var dataSource: [MLBookInfoModel]!
    var model:MLBookInfoModel!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.tableTop.constant = self.navBarHeight
        self.setNavTitle(title: "图书列表")
        self.tableView.register(UINib(nibName: MLBookListCell.kCellId, bundle: nil), forCellReuseIdentifier: MLBookListCell.kCellId)
        self.setupData()
        self.tableView.reloadData()
    }

    func setupData() {
        let sqlParams: [String : Any] = [:]
        let result = MLDataManager.shareManager.searchData(tableName: MLDataManager.KBOOK_INFO_TABLE, isAnd: true, conditions: sqlParams)
//        MLDeugLog(message: "json数据为:\(String(describing: result))")
         let arr = [MLBookInfoModel].deserialize(from: result) as? [MLBookInfoModel]
        self.dataSource  = arr
    }
    
    
    
    
    //MARK: - UITableViewDataSource & UITableViewDelegate
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MLBookListCell.kCellId, for: indexPath) as! MLBookListCell
         cell.setupUI(item: self.dataSource[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    
    
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let vc = MLBookDetailController.init()
         vc.book = self.dataSource[indexPath.row]
         self.navigationController?.pushViewController(vc, animated: true)
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
