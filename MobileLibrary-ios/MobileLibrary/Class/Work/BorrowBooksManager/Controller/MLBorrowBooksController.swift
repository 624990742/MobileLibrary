//
//  MLBorrowBooksController.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/3/30.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import UIKit


class MLBorrowBooksController: MLBaseController {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewTop: NSLayoutConstraint!
    
    
    @IBOutlet weak var borrowBookBtn: UIButton!
    
    var oprtionType:MLBookOptionType = .jieYueType
    var book: MLBookInfoModel!
    var recordModel: MLBookRecordInfoModel!
    var dataSource: [Array] = [Array<Any>]()
    
    
    lazy var backItem: UIBarButtonItem = {
            let btn = UIButton()
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
            btn.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
            btn.setTitle("驳回", for: .normal)
            btn.setTitleColor(.white, for: .normal)
            btn.addTarget(self, action: #selector(backItemAction), for: .touchUpInside)
            btn.layoutButtonImageEdgeInsetsStyle(style: KKButtonEdgeInsetsStyle.top, space: 3)
            return UIBarButtonItem(customView: btn)
        }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (book != nil) {
            book.bookInsideCode = ""
        }
        
        setupUIData()
        setupUI()
    }
    func setupUI() {
        
        self.tableViewTop.constant = self.navBarHeight
        if #available(iOS 15.0, *) {
            self.tableView.sectionHeaderTopPadding = 0
        }
        if #available(iOS 11.0, *) {
            self.tableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        self.tableView.register(UINib(nibName: MLBorrowBooksCell.kCellId, bundle: nil), forCellReuseIdentifier: MLBorrowBooksCell.kCellId)

    
        switch self.oprtionType {
        
        case .bookDetailType:
            self.setNavTitle(title: "借阅操作")
            break
            
        case .jieYueGuanLiEditType:
            self.setNavTitle(title: "借阅信息修改")
            self.gk_navRightBarButtonItem = self.backItem
            break
            
        default:
            MLDeugLog(message: "-- 未知错误 -- ")
        }
    }
    
   
    
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
    
    
    func setupUIData() {
        if self.dataSource.isEmpty == false {
            self.dataSource.removeAll()
        }
        var bookTitle = ""
        var bookAuthor = ""
        var bookPress = ""
        var bookISBN = ""
        var userName = ""
        var userIphone = ""
        var borrowBookTime = ""
        var endTime = ""
        var bookInsideCode = ""

        
        switch self.oprtionType {
        case .bookDetailType:
            
            bookTitle = book.bookTitle
            bookAuthor = book.bookAuthor
            bookPress = book.bookPress
            bookISBN = book.bookISBN
            userName = MLUserInfoManager.userName ?? ""
            userIphone = MLUserInfoManager.userIphone ?? ""
            borrowBookTime = String.getCurrentDateFormattedToHour()
            bookInsideCode = book.bookInsideCode
            break
    
        case .jieYueGuanLiEditType:
            
            bookTitle = recordModel.recordBookTitle
            bookAuthor = recordModel.recordBookAuthor
            bookPress = recordModel.recordBookPress
            bookISBN = recordModel.recordBookISBN
            userName = recordModel.recordBorrower
            userIphone = recordModel.userIphone
            borrowBookTime = recordModel.recordBorrowerTime
            endTime = recordModel.recordBackTime
            bookInsideCode = recordModel.bookInsideCode
            
            break
            
        default:
            MLDeugLog(message: "-- 未知错误 -- ")
        }
        
        
        
        
        let firtsArr = [createItem(sec:0,row:0,title: "图书名称", titleValue: bookTitle),
                   createItem(sec:0,row:1,title: "作者", titleValue: bookAuthor),
                   createItem(sec:0,row:2,title: "出版社", titleValue: bookPress),
                   createItem(sec:0,row:3,title: "ISBN书本编码", titleValue: bookISBN),
                    createItem(sec:0,row:4,title: "图书编码", titleValue: bookInsideCode)]
        
        let secondArr = [createItem(sec:1,row:0,title: "借阅人", titleValue: userName),
                         createItem(sec:1,row:1,title: "联系电话", titleValue: userIphone),
                         createItem(sec:1,row:2,title: "借阅时间", titleValue: borrowBookTime),
                         createItem(sec:1,row:3,title: "预计归还时间", titleValue: endTime)]
        
        self.dataSource.append(firtsArr)
        self.dataSource.append(secondArr)
      
    }
    
    func createItem(sec: Int,row: Int,title: String,titleValue:String) -> MLBorrowBooksModel {
        let model = MLBorrowBooksModel.init()
        model.sec = sec
        model.row = row
        model.title = title
        model.titleValue = titleValue
        return model
    }
    
    @IBAction func bottomBtnAction(_ sender: UIButton) {
        
        switch self.oprtionType {
        case .bookDetailType:
            self.borrowBookRecord()
            break
        case .jieYueGuanLiEditType:
            self.dealUpdateBorrowBookInfo()
            break
        
        default:
        MLDeugLog(message: "---  未知错误  ---")
        }

    }
    
    
    @objc func backItemAction(){
        
        guard recordModel != nil else {
            MLAlert.show(type: MLAlert.AlertType.warning, text: "驳回条件不能为空")
            return
        }
        
        MLNetManager.loadNetData(API: MLNetAPI.self, target: .backBook(userId: recordModel.userId, recordId: recordModel.recordId)) { code, dict, msg in
            if code == 200 {
                MLAlert.show(type: MLAlert.AlertType.success, text: "驳回成功")
                self.navigationController?.popViewController(animated: true)
                NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: ML_BRORROW_BOOKS_LIST), object: nil)
                return
            }
        } failure: { code, msg in
            MLAlert.show(type: MLAlert.AlertType.error, text: msg)
            self.tableView.mj_header?.endRefreshing()
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

extension MLBorrowBooksController: UITableViewDelegate, UITableViewDataSource {//CalendarPickerDelegate

    
   
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let arr = dataSource[section]
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  
        let cell = tableView.dequeueReusableCell(withIdentifier: MLBorrowBooksCell.kCellId , for: indexPath) as! MLBorrowBooksCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.setupUIData(item: dataSource[indexPath.section][indexPath.row] as? MLBorrowBooksModel ?? MLBorrowBooksModel())
        cell.backActionBlock = {
            self.saoMa()
        }
        return cell

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

     return 50
    }

    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
     return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
      let header = MLBorrowBooksHeaderView()
        
        header.titleLabel.text = section == 1 ? "借阅人基本信息" : "图书基本信息"
        return header
        
    }
    
    
  
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {

        
        let footerView = UIView()
        footerView.backgroundColor = .clear
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
       
        return CGFLOAT_MIN
    }
    
    

    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        let arr = dataSource[indexPath.section]
        let model = arr[indexPath.row] as! MLBorrowBooksModel
        let sec = indexPath.section
        let row = indexPath.row
        
        
        switch self.oprtionType {
        case .bookDetailType:
            dealDetailGoIntoCellDidSelectLogic(sec: sec, row: row, model: model)
            break
        case .jieYueGuanLiEditType:
            dealBorrowListGoIntoCellDidSelectLogic(sec: sec, row: row, model: model)
            break
        default:
            MLDeugLog(message: "-- 未知 -- ")
        }
    }

    
    
    func saoMa(){
        /// 创建二维码扫描
        let vc = MLScanCodeController()

        //设置标题、颜色、扫描样式（线条、网格）、提示文字
        vc.setupScanner("微信扫一扫", .green, .default, "将二维码/条码放入框内，即可自动扫描") { (code) in
        //扫描回调方法
        //关闭扫描页面
        self.navigationController?.popViewController(animated: true)
        }
        vc.backActionBlock = { code in
            MLDeugLog(message: "code:\(code)")
            
            if self.oprtionType == .bookDetailType {
            self.book.bookInsideCode = code
            }else if self.oprtionType == .jieYueGuanLiEditType {
                self.recordModel.bookInsideCode = code
            }
        self.setupUIData()
        self.tableView.reloadData()
        }
        
        //push到扫描页面
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}



// MARK: -  借阅操作界面进入
extension MLBorrowBooksController {
    
    func dealBorrowListGoIntoCellDidSelectLogic(sec: Int,row: Int,model: MLBorrowBooksModel) {
        
        if sec == 1 && row == 3 {
            let alertyVC = MLCustomTimePickerControllerViewController()
            alertyVC.onDateSelected = { [weak self] selectedDate in
                guard let self = self else { return }
                let  endDateStr  = MLPublickTool.formatDateAsYYYYMMDD(date: selectedDate!)
                model.titleValue = endDateStr
                self.tableView.reloadData()
            }
            alertyVC.show(above: self)
        }else{
            
            let vc = MLInputInfoController.init()
            vc.addSec = sec
            vc.addRow = row
            vc.goIntoType = .borrowInformationModification
            vc.backActionBlock = {[weak self] text,sec,row in
                let arr = self?.dataSource[sec]
                let model  = arr?[row] as! MLBorrowBooksModel
                model.titleValue = text
                self?.tableView.reloadData()
            }
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }
    
}




// MARK: -  借阅操作数据更新
extension MLBorrowBooksController {
    
    
    func dealUpdateBorrowBookInfo(){
        
        
        let firstArr = self.dataSource.first as! [MLBorrowBooksModel]
        let lastArr = self.dataSource.last as! [MLBorrowBooksModel]
        
        for (index, model) in firstArr.enumerated() {
            switch index {
            case 0:
                recordModel.recordBookTitle = model.titleValue
            case 1:
                recordModel.recordBookAuthor = model.titleValue
            case 2:
                recordModel.recordBookPress = model.titleValue
            case 3:
                recordModel.recordBookISBN = model.titleValue
            case 4:
                recordModel.bookInsideCode = model.titleValue
            default:
                MLDeugLog(message: "-- 未赋值 --")
            }
        }
        
        for (index, model) in lastArr.enumerated() {
            switch index {
            case 0:
                recordModel.recordBorrower = model.titleValue
            case 1:
                recordModel.userIphone = model.titleValue
            case 2:
                recordModel.recordBorrowerTime = model.titleValue
            case 3:
                recordModel.recordBackTime = model.titleValue
            default:
                MLDeugLog(message: "-- 未赋值 --")
            }
        }
        
        
        MLNetManager.loadNetData(API: MLNetAPI.self, target: .updateBorrowInfo(userId: recordModel.userId, recordBookTitle: recordModel.recordBookTitle, recordBookAuthor: recordModel.recordBookAuthor, recordBookPress: recordModel.recordBookPress, recordBookISBN: recordModel.recordBookISBN, userName: recordModel.recordBorrower, userIphone: recordModel.userIphone, recordBorrowerTime: recordModel.recordBackTime, recordBackTime: recordModel.recordBackTime, bookType: recordModel.bookType, updateTime: recordModel.updateTime,recordId: recordModel.recordId,bookInsideCode: recordModel.bookInsideCode)) { code, dict, msg in
            if code != 200 {
                MLAlert.show(type: MLAlert.AlertType.error, text: msg)
                return
            }
            MLAlert.show(type: MLAlert.AlertType.success, text: "更新成功")
            self.navigationController?.popViewController(animated: true)
            NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: ML_BRORROW_BOOKS_LIST), object: nil)
        } failure: { code, msg in
            MLAlert.show(type: MLAlert.AlertType.error, text: msg)
        }
        
    }
}



// MARK: -  详情界面进入的处理逻辑
    extension MLBorrowBooksController {
        
        
        
        func dealDetailGoIntoCellDidSelectLogic(sec: Int,row: Int,model: MLBorrowBooksModel) {
            
            if sec == 0 {
                return
            }
            if row < 3{
                return
            }
            let alertyVC = MLCustomTimePickerControllerViewController()
            alertyVC.onDateSelected = { [weak self] selectedDate in
                guard let self = self else { return }
                let  endDateStr  = MLPublickTool.formatDateAsYYYYMMDD(date: selectedDate!)
                model.titleValue = endDateStr
                self.tableView.reloadData()
            }
            alertyVC.show(above: self)
        }
        
        
        
        
        
        
        ///书本详情页进入处理逻辑
        func borrowBookRecord(){
            if self.dataSource.isEmpty{
                return
            }
            
            let model = self.dataSource[1].last as! MLBorrowBooksModel
            
            let userId = MLUserInfoManager.userId ?? ""
            let bookTitle = book.bookTitle
            let bookAuthor = book.bookAuthor
            let bookPress = book.bookPress
            let bookISBN  = book.bookISBN
            let userName = MLUserInfoManager.userName ?? "nikc"
            let userIphone = MLUserInfoManager.userIphone ?? "0"
            let currentDate = String.getCurrentDateFormattedToHour()
            let endDate = model.titleValue
            let bookType = book.bookType
            let currentTime = String.getCurrentDateFormattedToHour()
            let bookInsideCode = book.bookInsideCode;
            
            if userId.isEmpty || bookTitle.isEmpty || bookAuthor.isEmpty ||
                bookPress.isEmpty || bookISBN.isEmpty || userName.isEmpty ||
                userIphone.isEmpty || currentDate.isEmpty || endDate.isEmpty || bookInsideCode.isEmpty {
                MLAlert.show(type: .warning, text: "请检查内容")
                return
            }
            
            MLNetManager.loadNetData(API: MLNetAPI.self, target: .applyForBorrow(userId:userId, recordBookTitle:bookTitle, recordBookAuthor: bookAuthor, recordBookPress: bookPress, recordBookISBN: bookISBN, userName: userName, userIphone: userIphone, recordBorrowerTime: currentTime, recordBackTime: endDate,bookType: bookType,updateTime: endDate,bookInsideCode: bookInsideCode)) { code, dict, msg in
                if code == 200 {
                    self.navigationController?.popViewController(animated: false)
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: ML_BOOTDETAIL_UPDATE), object: nil)
                }else{
                    MLAlert.show(type: .warning, text: msg)
                }
            } failure: { code, msg in
                MLAlert.show(type: .error, text: msg)
            }
        }
}
