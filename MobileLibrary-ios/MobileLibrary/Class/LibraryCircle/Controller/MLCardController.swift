//
//  MLCardController.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/5/2.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import Foundation
import UIKit

class MLCardController: MLBaseController,CardScrollViewDelegate {
    
    
    var cardScrollView: CardScrollView!
    
    lazy var shareItem: UIBarButtonItem = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        btn.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        btn.setTitle("分享", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(shareAction), for: .touchUpInside)
        btn.layoutButtonImageEdgeInsetsStyle(style: KKButtonEdgeInsetsStyle.top, space: 3)
        return UIBarButtonItem(customView: btn)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavTitle(title: "分享")
        cardScrollView  = CardScrollView(frame: self.view.bounds)
        cardScrollView.delegate = self
        self.view.addSubview(cardScrollView)
        self.gk_navRightBarButtonItem = self.shareItem
    }
    
    
    func cardScrollViewDelegateDidSelect(at index: Int, imageModel: CardModel!) {
        share()
    }
    
    @objc  func shareAction()  {
        share()
    }

    
    func share() {
        let shareView = DXShareView.init()
        let shareModel = DXShareModel.init()
        shareModel.title = "红楼梦";
        shareModel.descr = "本书具体分析《红楼梦》中的细小的智慧，其中不少智慧具有反而的意义，也即是狡猾之徒和有些人物的阴谋诡计，这亲做的目的不是宣扬、或者教唆心肠坏的人善搞阴谋诡计。";
        shareModel.url = "https://www.baidu.com";
        shareModel.thumbImage = UIImage(named: "book1");
        shareView.show(with: shareModel, shareContentType: DXShareContentType.image)

    }
    
    
}
