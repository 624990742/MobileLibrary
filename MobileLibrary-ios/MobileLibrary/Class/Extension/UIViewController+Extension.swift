//
//  UIViewController+Extension.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/4/18.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAccountDeletionAlert(title: String, message: String, confirmationButtonTitle: String, confirmationAction: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        // 添加取消按钮
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        // 添加确认按钮并关联操作
        let confirmAction = UIAlertAction(title: confirmationButtonTitle, style: .destructive) {  _ in
            confirmationAction?()
        }
        alertController.addAction(confirmAction)
        

        // 显示警示对话框
        present(alertController, animated: true, completion: nil)
    }
    
    
    func addTableView() -> UITableView {
            let tableView = UITableView(frame: view.bounds, style: .plain)
            tableView.backgroundColor = UIColor.white
            tableView.tableFooterView = UIView()
            tableView.frame = view.bounds
            tableView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
            tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
            self.view.addSubview(tableView)
            return tableView
        }
    

    
    
}


