//
//  MLHotBooksTalksBaseController.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/5/6.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import Foundation
class MLHotBooksTalksBaseController: LLSegmentViewController {
    let lufeiImageViewHeight:CGFloat = 250
    var headerView:MLBookHotHeaderView!
    let customNavBar = UIView()
    let backButtom = UIButton(type: .custom)
    var model: MLLibraryCircleModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutContentView()
        loadCtls()
        setUpSegmentStyle()
        
        segmentCtlView.bottomSeparatorStyle = (0.5,UIColor.black.withAlphaComponent(0.3))
        closeAutomaticallyAdjusts()
    }
    
    func layoutContentView() {
        loadHeaderView()
        
        self.layoutInfo.headView = headerView
        self.layoutInfo.refreshType = .container

        self.layoutInfo.segmentControlPositionType = .top(size: CGSize.init(width: UIScreen.main.bounds.width, height: 50),offset:0)
        self.relayoutSubViews()
    }
    
    func loadCtls() {
        let deatailVC = MLHotBooksTalksListController.init(title: "图书详情",contentStr: model.bookBrief)
        let newCommentVC = MLNewCommentListController.init(title: "最新评论", imageName: "", selectedImageNameStr: "")
        let hotBooksVC = MLHotCommentListController.init(title: "热门评论", imageName: "", selectedImageNameStr: "")
        let ctls =  [deatailVC,newCommentVC,hotBooksVC]
        reloadViewControllers(ctls:ctls)
    }
    
    func setUpSegmentStyle() {
        let contentInset = UIEdgeInsets.init(top: 0, left: 60, bottom: 0, right: 30)
        let itemStyle = LLSegmentItemTitleViewStyle()
        itemStyle.itemWidth = (UIScreen.main.bounds.width - contentInset.left - contentInset.right)/CGFloat(ctls.count)
        itemStyle.titleFontSize = 15
        
        var segmentCtlStyle = LLSegmentedControlStyle()
        segmentCtlStyle.contentInset = contentInset
        segmentCtlStyle.segmentItemViewClass = LLSegmentItemTitleView.self
        segmentCtlStyle.itemViewStyle = itemStyle
        segmentCtlView.reloadData(ctlViewStyle: segmentCtlStyle)
        segmentCtlView.clickAnimation = false
        segmentCtlView.backgroundColor = UIColor.white
        
        segmentCtlView.indicatorView.shapeStyle = .crossBar(widthChangeStyle: .stationary(baseWidth: 10), height: 3)
    }
    
    override func scrollView(scrollView: LLContainerScrollView, dragTop offsetY: CGFloat) {
        var lufeiImageViewFrame = headerView.frame
        let maxY = lufeiImageViewFrame.maxY
        lufeiImageViewFrame.size.height = lufeiImageViewHeight + offsetY
        lufeiImageViewFrame.origin.y = maxY - lufeiImageViewFrame.size.height
        headerView.frame = lufeiImageViewFrame
    }
}



extension MLHotBooksTalksBaseController{
    func loadHeaderView() {
        
        
        headerView = MLBookHotHeaderView.loadFromNib("MLBookHotHeaderView")
        
        headerView.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: lufeiImageViewHeight)
        
    }
    
    func initCustomNavBar() {
        let navHeight:CGFloat = 44
        let topHeight = mTopHeight(mNavBarHeight: navHeight)
        customNavBar.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: topHeight)
        customNavBar.backgroundColor = UIColor.white
        view.addSubview(customNavBar)
        
        let titleLabel = UILabel()
        titleLabel.text = self.title
        titleLabel.sizeToFit()
        titleLabel.center = CGPoint.init(x: customNavBar.bounds.width/2, y: topHeight - navHeight/2)
        customNavBar.addSubview(titleLabel)
        
        let backButtomHeight:CGFloat = 30
        backButtom.contentHorizontalAlignment = .left
        backButtom.setImage(#imageLiteral(resourceName: "jiantou_bai"), for: .normal)
        backButtom.frame = CGRect.init(x: 20, y: topHeight - navHeight/2 - backButtomHeight/2, width: 50, height: backButtomHeight)
        view.addSubview(backButtom)
        backButtom.addTarget(self, action: #selector(backBtnClick), for: .touchUpInside)
    }
    
    @objc func backBtnClick(){
        self.navigationController?.popViewController(animated: true)
    }
}


