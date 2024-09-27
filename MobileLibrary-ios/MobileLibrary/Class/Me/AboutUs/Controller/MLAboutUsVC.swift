//
//  MLLogoutController.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/4/4.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import UIKit

class MLAboutUsVC: MLBaseController, UITableViewDelegate, UITableViewDataSource {
    
    private lazy var dataArr: [String] = {
        let arr = ["用户政策","隐私协议"]
        return arr
    }()
    private lazy var tableView: UITableView = {
        let table = UITableView.init(frame: CGRect.zero, style: UITableView.Style.plain)
        table.backgroundColor = .clear
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        table.backgroundColor = ML_F7F8Color
        table.showsVerticalScrollIndicator = false
        table.showsHorizontalScrollIndicator = false
        if #available(iOS 11.0, *) {
            table.sectionHeaderHeight = 0;
            table.sectionFooterHeight = 0;
            table.contentInsetAdjustmentBehavior = .never
        }
         if #available(iOS 15.0, *) {
             table.sectionHeaderTopPadding = 0
            } else {
                // Fallback on earlier versions
            };
        table.register(UINib.init(nibName: MLMineCell.KCellID, bundle: nil), forCellReuseIdentifier: MLMineCell.KCellID)
        return table
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - UI
    func setupUI(){
        self.gk_navTitle = "关于我们"
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { make in
                make.top.equalTo(self.gk_navigationBar.snp.bottom)
                make.left.equalTo(self.view.snp.left)
                make.right.equalTo(self.view.snp.right)
                make.bottom.equalTo(self.view.snp.bottom)
        }
        self.tableView.layoutIfNeeded()
        
        let h1 = MLiPhoneHalf(173.0)
        let headerView: UIView = Bundle.main.loadNibNamed(MLAboutUsHeader.HeaderID, owner: nil, options: nil)?.last as! UIView
        headerView.frame = CGRect(x: 0, y: 0, width: ML_ScreenWidth, height: h1)
        headerView.layoutIfNeeded()
        
        let footerView: UIView = Bundle.main.loadNibNamed(MLAboutUsFooter.footerID, owner: nil, options: nil)?.last as! UIView
        let footH = ML_ScreenHeight - ML_NavigationHeight - MLiPhoneHalf(57.0) * 4 - h1;
        footerView.frame = CGRect(x: 0, y: 0, width: ML_ScreenWidth, height: max(footH, MLiPhoneHalf(350)))
        footerView.layoutIfNeeded()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.tableView.tableHeaderView = headerView
            self.tableView.tableFooterView = footerView
        }
        
    }
    

    
    // MARK: -  UITableViewDelegate, UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataArr.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MLMineCell.KCellID, for: indexPath) as! MLMineCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.setupUIData(title: self.dataArr[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return MLiPhoneHalf(57)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        let web = MLWebController.init()
        if indexPath.row == 0 {
            web.htmltype = .user
        }else{
            web.htmltype = .yinsi
        }
        self.navigationController?.pushViewController(web, animated: true)
        
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
