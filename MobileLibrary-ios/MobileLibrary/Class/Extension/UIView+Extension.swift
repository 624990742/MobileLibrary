//
//  UIView+E.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/3/6.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import UIKit
extension UIView {
    
    /// x
    var ML_X: CGFloat {
        get {
            return frame.origin.x
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.x    = newValue
            frame                 = tempFrame
        }
    }
    
    /// y
    var ML_Y: CGFloat {
        get {
            return frame.origin.y
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.y    = newValue
            frame                 = tempFrame
        }
    }
    
    /// height
    var ML_Height: CGFloat {
        get {
            return frame.size.height
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.height = newValue
            frame                 = tempFrame
        }
    }
    
    /// width
    var ML_Width: CGFloat {
        get {
            return frame.size.width
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.width = newValue
            frame = tempFrame
        }
    }
    
    /// size
    var ML_Size: CGSize {
        get {
            return frame.size
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size = newValue
            frame = tempFrame
        }
    }
    
    /// centerX
    var ML_CenterX: CGFloat {
        get {
            return center.x
        }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.x = newValue
            center = tempCenter
        }
    }
    
    /// centerY
    var ML_CenterY: CGFloat {
        get {
            return center.y
        }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.y = newValue
            center = tempCenter;
        }
    }
}

//Mark -   加载自定义的xib视图的操作
/// 定义一个协议
protocol MLNibLoadElement {
    /// 具体实现写到 extension 中
}
/// 加载xib
/* Xib 和 类名 同名
* lazy var headerView = HeaderView.loadFromNib()
* Xib 中多个 View 视图 index 为多个视图的索引值
* lazy var sectionView = MLHeaderView.loadFromNib("view",index: 1) */

extension MLNibLoadElement where Self : UIView {
    /// 协议中不能定义class
    static func loadFromNib(_ nibname:String? = nil,index:Int = 0) -> Self { // Self(大写)当前类对象
        /// self(小写)当前对象
        let loadName = nibname == nil ? "\(Self.self)" : nibname!
        return Bundle.main.loadNibNamed(loadName, owner: nil, options: nil)![index] as! Self
    }
}


// MARK: -  类型关联处理
extension UIView {
    
    private struct AssociatedKeys {
          static var mlk_bezierPath = "mlk_bezierPath"
          static var mlk_shapeLayer = "mlk_shapeLayer"
      }
    
    fileprivate var mlk_shapeLayer: CAShapeLayer? {
        get {
            return mlk_getAssociated(associatedKey: &AssociatedKeys.mlk_shapeLayer)
        }
        set {
            mlk_setAssociated(value: newValue, associatedKey: &AssociatedKeys.mlk_shapeLayer)
        }
    }
    
    fileprivate var mlk_bezierPath: UIBezierPath? {
        get {
            return mlk_getAssociated(associatedKey: &AssociatedKeys.mlk_bezierPath)
        }
        set {
            mlk_setAssociated(value: newValue, associatedKey: &AssociatedKeys.mlk_bezierPath)
        }
    }
    
    fileprivate func get_shapeLayer() -> CAShapeLayer {
        let layers = CAShapeLayer()
        layers.frame = self.bounds;
        return layers
    }
    
     //MARK -  public
  
    ///指定方向切圆角
    @objc func mlk_drawCircularAngle(cornerType: UIRectCorner, cornerRadius: CGSize) {
        self.mlk_bezierPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height), byRoundingCorners: cornerType, cornerRadii: CGSize(width: cornerRadius.width, height: cornerRadius.height))
        self.mlk_shapeLayer = self.get_shapeLayer()
        self.mlk_shapeLayer?.path = self.mlk_bezierPath?.cgPath
        self.layer.mask = self.mlk_shapeLayer
    }

    ///上下左右都切圆脚
  @objc  func mlk_drawAllCornerRadius(radius: CGFloat) {
        let size = CGSize(width: self.frame.size.width, height: radius)
        self.mlk_drawCircularAngle(cornerType: .allCorners, cornerRadius: size)
    }
   
    ///设置指定圆角
    @objc func mlk_setAppointRounded(rect: CGRect ,cornerType: UIRectCorner, sizeRadius: CGSize) {
        self.mlk_bezierPath = UIBezierPath(roundedRect: rect, byRoundingCorners: cornerType, cornerRadii: CGSize(width: sizeRadius.width, height: sizeRadius.height))
        self.mlk_shapeLayer = self.get_shapeLayer()
        self.mlk_shapeLayer?.path = self.mlk_bezierPath?.cgPath
        self.layer.mask = self.mlk_shapeLayer
    }
    
    @objc  func setupShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor   = ML_AppThemeColor.cgColor
        self.layer.shadowOffset  = CGSizeMake(0,2)
        self.layer.shadowOpacity = 0.08 //设置阴影透明度
        self.layer.shadowRadius  = 8.0 //设置阴影圆角
//        self.layer.cornerRadius = 20.0
        }
}


//Mark -   NSObject  extension
extension NSObject {
    func mlk_setAssociated<T>(value: T, associatedKey: UnsafeRawPointer, policy: objc_AssociationPolicy = objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC) -> Void {
        objc_setAssociatedObject(self, associatedKey, value, policy)
    }
    
    func mlk_getAssociated<T>(associatedKey: UnsafeRawPointer) -> T? {
        let value = objc_getAssociatedObject(self, associatedKey) as? T
        return value;
    }
    
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }

}

extension CGFloat {
    static let max: CGFloat = CGFloat(Float.greatestFiniteMagnitude)
}
