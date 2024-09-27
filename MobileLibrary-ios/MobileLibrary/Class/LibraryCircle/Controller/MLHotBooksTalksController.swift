//
//  MLHotBooksTalksController.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/5/6.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import Foundation
class MLHotBooksTalksController: MLHotBooksTalksBaseController, UIGestureRecognizerDelegate {
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCustomNavBar()
        customNavBar.alpha = 0
        headerView.contentMode = .scaleToFill
        
        containerScrView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(refreshControlAction))
        containerScrView.mj_header?.ignoredScrollViewContentInsetTop = lufeiImageViewHeight
    }
    
    //重写方法，不让图片缩放
    override func scrollView(scrollView: LLContainerScrollView, dragTop offsetY: CGFloat) {
        
    }
    
    override func scrollView(scrollView: LLContainerScrollView, dragToMinimumHeight progress: CGFloat) {
        customNavBar.alpha = progress
    }
    
    @objc func refreshControlAction(){
        if containerScrView.mj_header?.isRefreshing == true {
            DispatchQueue.main.asyncAfter(deadline: .now()+1.5, execute:{ [weak self] in
                self?.containerScrView.mj_header?.endRefreshing()
            })
        }
    }
}



extension MLHotBooksTalksController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
}
