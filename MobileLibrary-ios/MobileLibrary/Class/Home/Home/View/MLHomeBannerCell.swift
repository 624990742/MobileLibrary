//
//  MLHomeSearchCell.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/3/10.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import UIKit

class MLHomeBannerCell: UITableViewCell {
    static let kCellID = "MLHomeBannerCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(linearBanner)
        linearBanner.snp.makeConstraints {(maker) in
            maker.top.equalTo(self.snp.top).offset(ML_Margin)
            maker.left.equalTo(self.snp.left).offset(ML_Margin)
            maker.right.equalTo(self.snp.right).offset(-ML_Margin)
            maker.bottom.equalTo(self.snp.bottom).offset(-ML_Margin)
        }
        linearBanner.scrollToIndex(3, animated: false)
    }
    
    lazy var linearBanner: JXBanner = {[weak self] in
        let banner = JXBanner()
        banner.placeholderImgView.image = UIImage(named: "banner_placeholder")
        banner.indentify = "banner"
        banner.delegate = self
        banner.dataSource = self
        return banner
        }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
//MARK:- JXBannerDataSource
extension MLHomeBannerCell: JXBannerDataSource {
    
    func jxBanner(_ banner: JXBannerType)
        -> (JXBannerCellRegister) {
            
            return JXBannerCellRegister(type: JXBannerCell.self,
                                        reuseIdentifier: "JXDefaultVCCell")
    }
    
    func jxBanner(numberOfItems banner: JXBannerType)
        -> Int {
            
        return 5
            
    }
    
    func jxBanner(_ banner: JXBannerType,
                  cellForItemAt index: Int,
                  cell: UICollectionViewCell)
        -> UICollectionViewCell {
            let tempCell = cell as! JXBannerCell
//            tempCell.layer.cornerRadius = 20
//            tempCell.layer.masksToBounds = true
            tempCell.imageView.image = UIImage(named: "\(index).jpg")
          
            return tempCell
    }
    
    func jxBanner(_ banner: JXBannerType,
                  params: JXBannerParams)
        -> JXBannerParams {
            
            return params
                .timeInterval(5)
                .cycleWay(.forward)
                
    }
    
    func jxBanner(_ banner: JXBannerType,
                  layoutParams: JXBannerLayoutParams)
        -> JXBannerLayoutParams {
            
//            return layoutParams
//                .layoutType(JXBannerTransformLinear())
//                .itemSize(CGSize(width: 250, height: 150))
//                .itemSpacing(10)
//                .minimumAlpha(0.8)
            
            return layoutParams
                .itemSize(CGSize(width: MLiPhoneHalf(340), height: MLiPhoneHalf(150)))
                .itemSpacing(ML_Margin)
    }
    
//    func jxBanner(pageControl banner: JXBannerType,
//                  numberOfPages: Int,
//                  coverView: UIView,
//                  builder: JXBannerPageControlBuilder) -> JXBannerPageControlBuilder {
//        let pageControl = JXPageControlScale()
//        pageControl.contentMode = .bottom
//        pageControl.activeSize = CGSize(width: 15, height: 6)
//        pageControl.inactiveSize = CGSize(width: 6, height: 6)
//        pageControl.activeColor = UIColor.red
//        pageControl.inactiveColor = UIColor.lightGray
//        pageControl.columnSpacing = 0
//        pageControl.isAnimation = true
//        builder.pageControl = pageControl
//        builder.layout = {
//            pageControl.snp.makeConstraints { (maker) in
//                maker.left.right.equalTo(coverView)
//                maker.top.equalTo(coverView.snp.bottom).offset(0)
//                maker.height.equalTo(20)
//            }
//        }
//        return builder
//    }
    
}

//MARK:- JXBannerDelegate
extension MLHomeBannerCell: JXBannerDelegate {
    
    public func jxBanner(_ banner: JXBannerType,
                         didSelectItemAt index: Int) {
        
    }
    
    func jxBanner(_ banner: JXBannerType, center index: Int) {
        
    }
}
