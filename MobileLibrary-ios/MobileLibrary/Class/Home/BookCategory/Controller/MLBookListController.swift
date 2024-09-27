//
//  MLBookListController.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/4/6.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import UIKit

class MLBookListController: UITableViewController {
    var typeString: String = ""
    weak var naviController: UINavigationController?
//    private var dataSource = [String]()
    private var dataSource :[MLBookInfoModel] = []
    private var isDataLoaded = false
    private var isRequesting = false

    override func viewDidLoad() {
        super.viewDidLoad()

        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Loading...", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])
        refreshControl?.addTarget(self, action: #selector(headerRefresh), for: .valueChanged)
        self.tableView.register(UINib(nibName: MLBookListCell.kCellId, bundle: nil), forCellReuseIdentifier: MLBookListCell.kCellId)
    
    }

    func loadDataForFirst() {
        if !isDataLoaded {
            tableView.setContentOffset(CGPoint(x: 0, y: -refreshControl!.bounds.size.height), animated: true)
            headerRefresh()
        }
    }

    @objc func headerRefresh() {
        guard !isRequesting else {
            return
        }

        isRequesting = true
        refreshControl?.beginRefreshing()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.seconds(1)) {
            self.refreshControl?.endRefreshing()
            self.dataSource.removeAll()
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "HH:mm:ss"
//            let dateString = dateFormatter.string(from: Date())
//            for index in 0..<20 {
//                self.dataSource.append(String(format: "%@ 时间：%@ index:%d", self.typeString, dateString, index))
//            }
            
            let result = MLDataManager.shareManager.searchData(tableName: MLDataManager.KBOOK_INFO_TABLE, isAnd: true, conditions: [:])
             let arr = [MLBookInfoModel].deserialize(from: result) as? [MLBookInfoModel]
            self.dataSource  = arr ?? [MLBookInfoModel]()
            self.isDataLoaded = true
            self.isRequesting = false
            self.tableView.reloadData()
        }
    }

    //MARK: - UITableViewDataSource & UITableViewDelegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MLBookListCell.kCellId, for: indexPath) as! MLBookListCell
        if dataSource.count > 0 {
            cell.setupUI(item: dataSource[indexPath.row])
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MLBookDetailController.init()
        vc.book = self.dataSource[indexPath.row]
        self.currentNav().pushViewController(vc, animated: true)
    }
    
    func currentNav() -> MLBaseNavgationController {
        if self.navigationController == nil {
            return self.naviController as! MLBaseNavgationController
        }
        return self.navigationController as! MLBaseNavgationController
    }
    
    
}
