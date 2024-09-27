//
//  MLHomeController.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/3/4.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import UIKit

class MLHomeController: MLBaseController {

    var  homeItemArr: Array<Any>!
    var hotListArr: [MLBookInfoModel] =  [MLBookInfoModel]()
    lazy var searBarView: MLSearchBarView = {
        let searBar = MLSearchBarView()
        return searBar
    }()
    
   lazy var tableView: UITableView = {
       let table = UITableView(frame: .zero, style: .plain)
       table.dataSource = self
       table.delegate = self
       table.delegate = self
       table.dataSource = self
       table.separatorStyle = .none

       if #available(iOS 15.0, *) {
           table.sectionHeaderTopPadding = 0
       }
       if #available(iOS 11.0, *) {
           table.contentInsetAdjustmentBehavior = .never
       } else {
           self.automaticallyAdjustsScrollViewInsets = false
       }
   
       table.register(MLHomeBannerCell.self, forCellReuseIdentifier: MLHomeBannerCell.kCellID)
       table.register(UINib(nibName: MLHotCell.kCellID, bundle: nil), forCellReuseIdentifier: MLHotCell.kCellID)
       table.register(UINib(nibName: MLTodayHotCell.kCellID, bundle: nil), forCellReuseIdentifier: MLTodayHotCell.kCellID)
       return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.refreshData()
        self.tableView.reloadData()
        
        searBarView.tapAction = { [weak self] textField in
            let searchVC = MLBookSearchController.init()
            self?.navigationController?.pushViewController(searchVC, animated: true)
        }
    }

    func setupUI(){
        self.setNavTitle(title: "推荐")
//        self.gk_navRightBarButtonItem = self.saoMaItem
        
        self.view.addSubview(searBarView)
        searBarView.snp.makeConstraints { make in
            make.top.equalTo(self.gk_navigationBar.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(60.0)
        }
        
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints {
            $0.top.equalTo(self.searBarView.snp.bottom)
            $0.left.right.bottom.equalTo(self.view)
        }
        
        // 创建顶部刷新控件实例
        let header = MJRefreshNormalHeader()
        // 设置代理，通常是视图控制器本身
        header.refreshingTarget = self
        header.refreshingAction = #selector(refreshData)
        // 添加到表格或滚动视图的头部
        self.tableView.mj_header = header // 或 yourCollectionView.mj_header、yourScrollView.mj_header
    }
  
    
    @objc func refreshData(){
        
        let bookCateList = MLPublickTool.getPlistData(fileName: "bookCategroyList") as? Array<Any>
        var homeArr = Array<Any>()
        bookCateList?.forEach { obj in
         let temp = obj as? Dictionary<String, Any>
         let model = MLHomeModel.deserialize(from: temp)
          homeArr.append(model ?? MLHomeModel.init())
            self.homeItemArr = homeArr
            self.tableView.reloadData()
        }

        MLNetManager.loadNetData(API: MLNetAPI.self, target: .hotBookList(userId: "")) { code, dict, msg in
            
            guard let dict = dict as? [String: Any],
                  let result = dict["Data"] as? Array<Any> else {
                MLDeugLog(message: "无法解析响应结果")
                return
            }
            if result.isEmpty {
                MLDeugLog(message: "无法解析响应结果")
                return
            }
            self.hotListArr = [MLBookInfoModel].deserialize(from: result) as? [MLBookInfoModel] ?? [MLBookInfoModel]()
            self.tableView.reloadData()
            self.endRefreshing()
        } failure: { code, msg in
            self.endRefreshing()
            MLAlert.show(type: MLAlert.AlertType.error, text: msg)
        }
        
    }
    
    func endRefreshing(){
        if ((self.tableView.mj_header?.isRefreshing) != nil) {
            tableView.mj_header?.endRefreshing()
        }
    }
    
    
    @objc func saoAction(btn: UIButton){
        
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

extension MLHomeController: UITableViewDelegate, UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 2 {
            return self.hotListArr.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
  
        let sec = indexPath.section
        if sec == 0 {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: MLHomeBannerCell.kCellID , for: indexPath) as! MLHomeBannerCell
                cell.selectionStyle = UITableViewCell.SelectionStyle.none
         
            return cell
        } else if sec == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: MLHotCell.kCellID , for: indexPath) as! MLHotCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.itemArr = self.homeItemArr
            cell.categorySelectBlock = {[weak self]  item  in
                self?.jumpBookCategoryVC()
            }
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MLTodayHotCell.kCellID , for: indexPath) as! MLTodayHotCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
//        cell.model = self.hotListArr[indexPath.row] as! MLHomeModel
        
        cell.model = self.hotListArr[indexPath.row]
        return cell

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      
        var rowHeight = 0.0
        let sectionIndex = indexPath.section
        switch sectionIndex {
        case 0:
            rowHeight = MLiPhoneHalf(200)
        case 1:
            rowHeight = MLiPhoneHalf(240)
        case 2:
            rowHeight = MLiPhoneHalf(120)
        default:
            MLDeugLog(message: "-- 000000 ---")
        }
        return rowHeight
    }
        
    
     
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
      
        if section == 1 || section == 2{
            return MLiPhoneHalf(40)
        }
        return CGFLOAT_MIN
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headView  = MLTodayHotTitleView.loadFromNib("MLTodayHotTitleView")
        headView.tableView = self.tableView
        headView.senction = section
        if section == 1 || section == 2 {
            headView.setupTitleWithSection(sec: MLHomeSenctionType(rawValue: section)!)
            headView.moreBtnActionBlcok = {[weak self]   in
                if section == 1 {
                    self?.jumpBookCategoryVC()
                }else{
                    self?.jumpBookListVC()
                }
            }
            return headView
        }
        return UIView.init()
    }
    
    
   
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
      
        return CGFLOAT_MIN
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        if MLHelper.isLogin() {
            if self.hotListArr.isEmpty {
                return
            }
            self.jumpBookDetail(model: self.hotListArr[indexPath.row])
        }else{
            MLHelper.isLoginState {}
        }
            
        
    }
    
    
    ///跳转图列表界面
    func jumpBookListVC()  {
        let vc = MLHotBookListController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    ///跳转详情界面
    func jumpBookDetail(model: MLBookInfoModel) {
        let vc = MLBookDetailController.init()
        vc.book = model
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    ///跳转图书分类
    func jumpBookCategoryVC()  {
        let vc = MLBookCategoryController.init()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
 
}
























