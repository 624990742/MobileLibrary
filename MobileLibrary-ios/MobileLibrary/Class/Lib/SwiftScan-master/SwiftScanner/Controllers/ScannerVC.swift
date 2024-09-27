//
//  ScannerVC.swift
//  SwiftScanner
//
//  Created by Jason on 2018/11/30.
//  Copyright © 2018 Jason. All rights reserved.
//

import UIKit
import AVFoundation

open class ScannerVC: UIViewController {
    
    
    open lazy var headerViewController:HeaderVC = .init()
    
    open lazy var cameraViewController:CameraVC = .init()
    
    /// 动画样式
    open var animationStyle:ScanAnimationStyle = .default{
        didSet{
            cameraViewController.animationStyle = animationStyle
        }
    }
    
    // 扫描框颜色
    open var scannerColor:UIColor = .red{
        didSet{
            cameraViewController.scannerColor = scannerColor
        }
    }
    
    open var scannerTips:String = ""{
        didSet{
           cameraViewController.scanView.tips = scannerTips
        }
    }
    
    /// `AVCaptureMetadataOutput` metadata object types.
    open var metadata = AVMetadataObject.ObjectType.metadata {
        didSet{
            cameraViewController.metadata = metadata
        }
    }
    
    open var successBlock:((String)->())?
    
    open var errorBlock:((Error)->())?
    
    
    /// 设置标题
    open override var title: String?{
        
        didSet{
            
            if navigationController == nil {
                headerViewController.title = title
            }
        }
        
    }
    
    
    /// 设置Present模式时关闭按钮的图片
    open var closeImage: UIImage?{
        
        didSet{
            
            if navigationController == nil {
                headerViewController.closeImage = closeImage ?? UIImage()
            }
        }
        
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
    
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        cameraViewController.startCapturing()
    }
    
    
    
    
}




// MARK: - CustomMethod
extension ScannerVC{
    
    func setupUI() {
        
        if title == nil {
            title = "扫一扫"
        }
        
        view.backgroundColor = .black
        
        headerViewController.delegate = self
        
        cameraViewController.metadata = metadata
        
        cameraViewController.animationStyle = animationStyle
        
        cameraViewController.delegate = self
        
        add(cameraViewController)
        
        if navigationController == nil {
            
            add(headerViewController)
            
            view.bringSubviewToFront(headerViewController.view)
            
        }
        
        
    }
    
    
    open func setupScanner(_ title:String? = nil, _ color:UIColor? = nil, _ style:ScanAnimationStyle? = nil, _ tips:String? = nil, _ success:@escaping ((String)->())){
        
        if title != nil {
            self.title = title
        }
        
        if color != nil {
            scannerColor = color!
        }
        
        if style != nil {
            animationStyle = style!
        }
        
        if tips != nil {
            scannerTips = tips!
        }
        
        successBlock = success
        
    }
    
    
}




// MARK: - HeaderViewControllerDelegate
extension ScannerVC:HeaderViewControllerDelegate{
    
    
    /// 点击关闭
    public func didClickedCloseButton() {
        
        dismiss(animated: true, completion: nil)
        
    }
    
}



extension ScannerVC:CameraViewControllerDelegate{
    
    func didOutput(_ code: String) {
        
        successBlock?(code)
        
    }
    
    func didReceiveError(_ error: Error) {
        
        errorBlock?(error)
        
    }
    
}
