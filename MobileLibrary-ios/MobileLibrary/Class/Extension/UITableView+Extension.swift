//
//  UITableView+Extension.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/4/26.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

extension UITableView {
    func showDataCount(count: Int) {
        if count > 0 {
            self.backgroundView = nil
            return
        }

        let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height))
        self.backgroundView = backgroundView

        let showImageView = UIImageView()
        showImageView.contentMode = .scaleAspectFill
        backgroundView.addSubview(showImageView)

        let tipLabel = UILabel()
        tipLabel.font = UIFont.systemFont(ofSize: 22)
        tipLabel.textColor = UIColor(named: "kColor999999") ?? .gray
        tipLabel.textAlignment = .center
        backgroundView.addSubview(tipLabel)

        if let image = UIImage(named: "ml_image_noData") {
            showImageView.image = image
        }
        tipLabel.text = "暂无数据"

        showImageView.snp.makeConstraints { make in
            make.centerX.equalTo(backgroundView.snp.centerX)
            make.top.equalTo(backgroundView.snp.top).offset(180)
            make.size.equalTo(CGSize(width: 120, height: 120))
        }

        tipLabel.snp.makeConstraints { make in
            make.centerX.equalTo(backgroundView.snp.centerX)
            make.top.equalTo(showImageView.snp.bottom).offset(30)
        }
    }
}
