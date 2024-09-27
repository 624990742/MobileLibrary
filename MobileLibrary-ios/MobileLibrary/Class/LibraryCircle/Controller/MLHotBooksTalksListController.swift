//
//  MLHotBooksTalksBaseController.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/5/6.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//


import UIKit
import MJRefresh


class MLHotBooksTalksListController: UIViewController {
 
    var showTableView = true
    var tableView:UITableView = UITableView.init(frame: CGRect.zero, style: .plain)
    var contentStr: String!
    typealias scrollViewEndDragClosure =  (_ isScrollToTop:Bool)-> Void
    var scrollViewEndDragBlock:scrollViewEndDragClosure?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(red: CGFloat(arc4random()%256)/255.0, green: CGFloat(arc4random()%256)/255.0, blue: CGFloat(arc4random()%256)/255.0, alpha: 1)
        if showTableView == true {
            initTableView()
        }
    }
}

extension MLHotBooksTalksListController {
    convenience init(title:String,contentStr:String) {
        self.init()
        self.title = title
        self.contentStr = contentStr
    }
    
    func initTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        view.addSubview(tableView)

        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
            tableView.estimatedRowHeight = 0
            tableView.estimatedSectionHeaderHeight = 0
            tableView.estimatedSectionFooterHeight = 0
        } else {
            // Fallback on earlier versions
            automaticallyAdjustsScrollViewInsets = false
        }
        tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(headRefreshAction))
    }
    
    @objc func headRefreshAction(){
        if tableView.mj_header?.isRefreshing == true {
            DispatchQueue.main.asyncAfter(deadline: .now()+1.5, execute:{ [weak self] in
                self?.tableView.mj_header?.endRefreshing()
            })
        }
    }

}

extension MLHotBooksTalksListController:UITableViewDelegate,UITableViewDataSource{
    //列表
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = self.contentStr
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 150
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        scrollViewEndDragBlock?(velocity.y > 0)
    }
}



