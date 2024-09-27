//
//  MLSearchResultTableView.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/4/6.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import UIKit



class MLSearchResultTableView: UITableView {
    
    // 0:历史 1:结果
    var _type: String?
    // 点击cell
    var clickResultBlock: ((String) -> Void)?
    // 清除记录
    var clickDeleteBlock: (() -> Void)?
    
    ///结果点击
    var clickSearchResultBlock: ((_ row: Int) -> Void)?
    
    // 数据源
    var sourceData: NSMutableArray = []
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        delegate = self
        dataSource = self
        keyboardDismissMode = .onDrag
        self.register(UINib(nibName: MLSearchResultCell.kCellId, bundle: nil), forCellReuseIdentifier: MLSearchResultCell.kCellId)
    }
    
    
    var type: String? {
        get {
            return _type
        }
        set {
          _type =  newValue
            
        }
    }

    
    @objc private func deleteAction() {
        clickDeleteBlock?()
    }

    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
}

extension MLSearchResultTableView: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sourceData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MLSearchResultCell.kCellId , for: indexPath) as! MLSearchResultCell
                cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.setupUI(item: self.sourceData[indexPath.row] as! MLBookInfoModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if type == "0" {
            guard let keyword = sourceData[indexPath.row] as? String else { return }

            isUserInteractionEnabled = false

            clickResultBlock?(keyword)
        } else if type == "1" {
            
            if (self.clickSearchResultBlock != nil) {
                self.clickSearchResultBlock?(indexPath.row)
            }
//            print("点击了----:\(sourceData[indexPath.row] as? String ?? "")")
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if #available(iOS 11.0, *) {
            cell.separatorInset = .zero
            cell.layoutMargins = .zero
        } else {
            let insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            cell.separatorInset = insets
            cell.preservesSuperviewLayoutMargins = false
            cell.layoutMargins = insets
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard type == "0" else { return nil }

        guard let originData = UserDefaults.standard.array(forKey: MLSearch_kHistroySearchData) as? [String],
              !originData.isEmpty else { return nil }

        let view = UIView(frame: CGRect(x: 0, y: 0, width: ML_ScreenWidth, height: MLSearch_tagTitleHeighT + 10))
        view.backgroundColor = .white

        let tipLabel = UILabel(frame: CGRect(x: 0, y: 0, width: ML_ScreenWidth, height: MLSearch_tagTitleHeighT))
        tipLabel.text = "   历史搜索"
        tipLabel.backgroundColor = .white
        tipLabel.textColor = UIColor(hexString: "0x646464")
        tipLabel.font = UIFont.boldSystemFont(ofSize: 15)
        view.addSubview(tipLabel)

        let deleteBtn = UIButton(type: .custom)
        deleteBtn.frame = CGRect(x: ML_ScreenWidth - 30, y: 0, width: 20, height: 20)
        deleteBtn.setImage(UIImage(named: "delete_icon"), for: .normal)
        deleteBtn.contentMode = .center
        view.addSubview(deleteBtn)
        deleteBtn.addTarget(self, action: #selector(deleteAction), for: .touchUpInside)

        return view
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let originData = UserDefaults.standard.array(forKey: MLSearch_kHistroySearchData) as? [String] else { return 0.01 }

        return type == "0" ? (originData.isEmpty ? 0.01 : 30) : 0.01
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return MLiPhoneHalf(130)
    }
    
    
    
    
}
