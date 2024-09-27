//
//  MLLibraryCircleController.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/3/4.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import UIKit

enum MLLibCircleSelectedSegmentStyle: Int{
    case  MLBookShareStyle = 1///书摘分享
    case  MLHotBookSayStyle = 2///热书畅谈
}

class MLLibraryCircleController: MLBaseController {

    var tableView: UITableView!
    var segmentStyle: MLLibCircleSelectedSegmentStyle = .MLBookShareStyle
    var bookListArr: Array<MLLibraryCircleModel?> = []
//    lazy var tableView: UITableView = {
//        let table = UITableView(frame: .zero, style: .plain)
//        table.dataSource = self
//        table.delegate = self
//        table.separatorStyle = .none
//        if #available(iOS 15.0, *) {
//            table.sectionHeaderTopPadding = 0
//        }
//        if #available(iOS 11.0, *) {
//            table.contentInsetAdjustmentBehavior = .never
//        } else {
//            self.automaticallyAdjustsScrollViewInsets = false
//        }
//        table.estimatedRowHeight = 300
//        table.rowHeight = UITableView.automaticDimension
//        table.register(UINib(nibName: MLHotBookSayCell.kCellID, bundle: nil), forCellReuseIdentifier: MLHotBookSayCell.kCellID)
//        table.register(UINib(nibName:  MLBookShareCell.CellID, bundle: nil), forCellReuseIdentifier: MLBookShareCell.CellID)
//        return table
//     }()
//
//    
    override func viewDidLoad() {
        super.viewDidLoad()
            self.setNavTitle(title: "圈子")
            self.setupSeg()
            self.setupTableView()
            self.setupData()
    }
    
    
    func setupData(){
   
        guard let filePath = Bundle.main.path(forResource: "LibraryCircleBook", ofType: "json") else {
            fatalError("Failed to locate the JSON file.")
        }
        
        do {
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: filePath))
            
            let jsonString = String(data: jsonData, encoding: .utf8)
            
            if let bookList = [MLLibraryCircleModel].deserialize(from: jsonString) {
                self.bookListArr = bookList
            }
        } catch {
            MLDeugLog(message: "Error loading and/or parsing JSON: \(error)")
        }
        self.tableView.reloadData()
    }
    
    
    
    func setupTableView(){
        let table = UITableView(frame: .zero, style: .plain)
        table.separatorStyle = .none
        if #available(iOS 15.0, *) {
            table.sectionHeaderTopPadding = 0
        }
        if #available(iOS 11.0, *) {
            table.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        table.estimatedRowHeight = 300
        table.rowHeight = UITableView.automaticDimension
        table.register(UINib(nibName: MLHotBookSayCell.kCellID, bundle: nil), forCellReuseIdentifier: MLHotBookSayCell.kCellID)
        table.register(UINib(nibName:  MLBookShareCell.CellID, bundle: nil), forCellReuseIdentifier: MLBookShareCell.CellID)
        table.dataSource = self
        table.delegate = self
        self.view.addSubview(table)
        self.tableView = table
        self.tableView.snp.makeConstraints {
            $0.top.equalTo(self.gk_navigationBar.snp.bottom)
            $0.left.right.bottom.equalTo(self.view)
        }
    
    }
    
    func setupSeg() {
        let seg = UISegmentedControl(items: ["书摘分享","热书畅谈"])
        seg.apportionsSegmentWidthsByContent = true
        
        seg.selectedSegmentIndex = 0
        seg.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        seg.ML_Width = 80
        
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: ML_F7F8Color, // 正常状态下的标题颜色
            .font: UIFont.systemFont(ofSize: 16) // 字体大小
        ]
          
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: ML_8A9199Color, // 选中状态下的标题颜色
            .font: UIFont.boldSystemFont(ofSize: 16) // 字体大小和样式
        ]
          
        seg.setTitleTextAttributes(normalAttributes, for: .normal)
        seg.setTitleTextAttributes(selectedAttributes, for: .selected)
        
        self.gk_navTitleView = seg
    }
    
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        
        if (self.tableView != nil) {
            self.tableView.removeFromSuperview()
        }

        self.setupTableView()
        let selectedIndex = sender.selectedSegmentIndex
        switch selectedIndex {
        case 0:
            self.segmentStyle = .MLBookShareStyle
            self.tableView.estimatedRowHeight = 300
            self.tableView.rowHeight = UITableView.automaticDimension
        case 1:
            self.segmentStyle = .MLHotBookSayStyle
            self.tableView.estimatedRowHeight = 0
            self.tableView.rowHeight = 0
        default:
            break
        }
        self.tableView.reloadData()
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

extension MLLibraryCircleController: UITableViewDelegate, UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if self.segmentStyle == .MLHotBookSayStyle {
            return self.bookListArr.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var num = 0
        if self.segmentStyle == .MLHotBookSayStyle {
            num = 1
        }else{
            num = self.bookListArr.count
        }
        return num
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
  
        if self.segmentStyle == .MLBookShareStyle  {

            let cell = tableView.dequeueReusableCell(withIdentifier: MLBookShareCell.CellID , for: indexPath) as! MLBookShareCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.setupData(item: self.bookListArr[indexPath.row])
            cell.backActionBlock = {
                let cardVC = MLCardController.init()
                self.navigationController?.pushViewController(cardVC, animated: true)
            }
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: MLHotBookSayCell.kCellID , for: indexPath) as! MLHotBookSayCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.setupCellStyle(item:self.bookListArr[indexPath.section])
        return cell

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

    if self.segmentStyle == .MLBookShareStyle  {
        return UITableView.automaticDimension
    }
     return 140
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
        if self.segmentStyle == .MLHotBookSayStyle  {
            return 20
        }
        return CGFLOAT_MIN
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if self.segmentStyle == .MLHotBookSayStyle {
            
             let model = self.bookListArr[indexPath.row]
            let vc = MLHotBooksTalksController.init()
            vc.model = model
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
 
}
