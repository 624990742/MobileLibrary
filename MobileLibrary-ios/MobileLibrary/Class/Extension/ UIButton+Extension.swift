//
//   UIButton+Extension.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/3/4.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//
import Foundation
import UIKit


enum  KKButtonEdgeInsetsStyle {
    case top /// image在上，label在下
    case left /// image在左，label在右
    case bottom /// image在下，label在上
    case right /// image在右，label在左
}

//导航返回按钮
extension UIButton {
    convenience init(backTarget: AnyObject?, action: Selector) {
        self.init()
        setImage(UIImage(named:"back"), for: UIControl.State.normal)
        frame = CGRect(x: 0, y: 0, width: 44.0, height: 44.0)
        contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        addTarget(backTarget, action: action, for: UIControl.Event.touchUpInside)
    }
    
    
    ///  type ：image 的位置
    /// Space ：图片文字之间的间距
     func layoutButtonImageEdgeInsets(style: KKButtonEdgeInsetsStyle = .left, space: CGFloat = 5){
        ///图片
        let imgW = self.imageView?.bounds.width ?? 0
        let imgH = self.imageView?.bounds.height ?? 0
        ///标题
        let labelW = self.titleLabel?.intrinsicContentSize.width ?? 0
        let labelH = self.titleLabel?.intrinsicContentSize.height ?? 0
        
        var imageEdgeInsets = UIEdgeInsets.zero
        var labelEdgeInsets = UIEdgeInsets.zero
        var contentEdgeInsets = UIEdgeInsets.zero
        
        let bWidth = self.bounds.width
        let minH = min(imgH, labelH)
        
        switch style {
            
        case .left:
            
            self.contentVerticalAlignment = .center
            imageEdgeInsets = UIEdgeInsets(top: 0,
                                           left: 0,
                                           bottom: 0,
                                           right: 0)
            labelEdgeInsets = UIEdgeInsets(top: 0,
                                           left: space,
                                           bottom: 0,
                                           right: -space)
            contentEdgeInsets = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: space)
            
        case .right:
            
            self.contentVerticalAlignment = .center
            var margin = labelW + space/2
            if (labelW + imgW + space) > bWidth {
                let labelW_f = self.titleLabel?.frame.width ?? 0
                margin = labelW_f + space/2
            }
            imageEdgeInsets = UIEdgeInsets(top: 0,
                                           left: margin,
                                           bottom: 0,
                                           right: -margin)
            labelEdgeInsets = UIEdgeInsets(top: 0,
                                           left: -(imgW + space/2),
                                           bottom: 0,
                                           right: imgW + space/2)
            contentEdgeInsets = UIEdgeInsets(top: 0, left: space/2, bottom: 0, right: space/2.0)
            
        case .top:
            //img在上或者在下 一版按钮是水平垂直居中的
            self.contentHorizontalAlignment = .center
            self.contentVerticalAlignment = .center
            
            var margin = labelW/2.0
            //如果内容宽度大于button宽度 改变计算方式
            if (labelW + imgW + space) > bWidth {
                margin = (bWidth - imgW)/2
            }
            //考虑图片+显示文字宽度大于按钮总宽度的情况
            let labelW_f = self.titleLabel?.frame.width ?? 0
            if (imgW + labelW_f + space) > bWidth {
                margin = (bWidth - imgW)/2
            }
            imageEdgeInsets = UIEdgeInsets(top: -(labelH+space),
                                           left: margin,
                                           bottom: 0,
                                           right: -margin)
            labelEdgeInsets = UIEdgeInsets(top: 0,
                                           left: -imgW,
                                           bottom:-(space+imgH),
                                           right: 0)
            let h_di = (minH+space)/2.0
            contentEdgeInsets = UIEdgeInsets(top:h_di,left: 0,bottom:h_di,right: 0)
        case .bottom:
            //img在上或者在下 一版按钮是水平垂直居中的
            self.contentHorizontalAlignment = .center
            self.contentVerticalAlignment = .center
            var margin = labelW/2
            //如果内容宽度大于button宽度 改变计算方式
            if (labelW+imgW+space) > bWidth{
                margin = (bWidth - imgW)/2
            }
          //考虑图片+显示文字宽度大于按钮总宽度的情况
            let labelW_f = self.titleLabel?.frame.width ?? 0
            if (imgW+labelW_f+space)>bWidth{
                margin = (bWidth - imgW)/2
            }
            imageEdgeInsets = UIEdgeInsets(top: 0,
                                           left: margin,
                                           bottom: -(labelH+space),
                                           right: -margin)
            labelEdgeInsets = UIEdgeInsets(top: -(space+imgH),
                                           left: -imgW,
                                           bottom: 0,
                                           right: 0)
            let h_di = (minH+space)/2.0
            contentEdgeInsets = UIEdgeInsets(top:h_di, left: 0,bottom:h_di,right: 0)
        }
        self.contentEdgeInsets = contentEdgeInsets
        self.titleEdgeInsets = labelEdgeInsets
        self.imageEdgeInsets = imageEdgeInsets
    }
    
    
    
    ///布局button的样式
     func layoutButtonImageEdgeInsetsStyle(style: KKButtonEdgeInsetsStyle, space: CGFloat){
        let imgW = self.imageView?.frame.size.width ?? 0
        let imgH = self.imageView?.frame.size.height ?? 0
        var labelW: CGFloat = 0.0
        var labelH: CGFloat = 0.0
        // 1. 得到imageView和titleLabel的宽、高
        if #available(iOS 8.0, *) {
            // 由于iOS8中titleLabel的size为0，用下面的这种设置
            labelW = self.titleLabel?.intrinsicContentSize.width ?? 0
            labelH = self.titleLabel?.intrinsicContentSize.height ?? 0
        } else {
            labelW = self.titleLabel?.frame.size.width ?? 0
            labelH = self.titleLabel?.frame.size.height ?? 0
        }
        
        // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
           var imageEdgeInsets = UIEdgeInsets.zero
           var labelEdgeInsets = UIEdgeInsets.zero
        // 3. 根据style和space得到imageEdgeInsets和labelEdgeInsets的值
        switch style {
        case .top:
            
            imageEdgeInsets = UIEdgeInsets(top: -labelH - space / 2.0 , left: 0 , bottom: 0 , right: -labelW)
            labelEdgeInsets = UIEdgeInsets(top: 0 , left: -imgW , bottom: -imgH - space / 2.0 , right: 0)
            
        case .left:
                   
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -space/2.0, bottom: 0, right: space/2.0)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: space/2.0, bottom: 0, right: -space/2.0)
            
        case .bottom:
            
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: labelH-space/2.0, right: -labelW)
            labelEdgeInsets = UIEdgeInsets(top: -imgH-space/2.0, left: -imgW, bottom: 0, right: 0)
            
        case .right:
            
            imageEdgeInsets = UIEdgeInsets(top: 0, left: labelW+space/2.0, bottom: 0, right: -labelW-space/2.0)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imgW-space/2.0, bottom: 0, right: imgW+space/2.0)
            
        default:
            MLDeugLog(message: "--结束了---")
        }
        
         // 4. 赋值
        self.titleEdgeInsets = labelEdgeInsets;
        self.imageEdgeInsets = imageEdgeInsets;
    }

}
