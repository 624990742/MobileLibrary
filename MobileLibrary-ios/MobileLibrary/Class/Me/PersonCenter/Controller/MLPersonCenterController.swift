//
//  MLPersonCenterController.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/4/4.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import UIKit
import Photos

class MLPersonCenterController: MLBaseController, UINavigationControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewTop: NSLayoutConstraint!
    var iconImage: UIImage = UIImage()
    lazy var titleArr:[String] = {
        let arr = ["昵称","性别","手机号","注册时间","个人简介"]
        return arr
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.gk_navTitle = "个人资料"
        self.tableViewTop.constant = self.navBarHeight
        self.tableView.register(UINib.init(nibName: MLPersonCenterCell.KCellID, bundle: nil), forCellReuseIdentifier: MLPersonCenterCell.KCellID)
        let headeView = MLPersonCenterHeaderView.loadFromNib("MLPersonCenterHeaderView")
        headeView.ML_Height = MLiPhoneHalf(160)
        self.tableView.tableHeaderView = headeView
        headeView.headerImageBlock = {
            self.openLibrary()
        }
    }
    
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
// MARK: -  UITableViewDelegate, UITableViewDataSource

extension MLPersonCenterController: UITableViewDelegate, UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return self.titleArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MLPersonCenterCell.KCellID , for: indexPath) as! MLPersonCenterCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
        let row = indexPath.row
        
        cell.setupUIData(title: titleArr[row],row: indexPath.row)
            return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
 
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        let vc = MLInputInfoController.init()
        vc.addSec = indexPath.section
        vc.addRow = indexPath.row
        vc.backActionBlock = {[weak self] text, sec, row  in
            self?.dealEditeResult(text: text, sec: sec, row: row)
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension MLPersonCenterController {
    
    func dealEditeResult(text: String,sec: Int, row: Int){
        
        if text.isEmpty {
            MLAlert.show(type: MLAlert.AlertType.warning, text: "修改内容不能为空")
            return
        }
        self.tableView.reloadData()
    }
    
}



extension MLPersonCenterController: UIImagePickerControllerDelegate {
    
    func openAlert(_ sender :UIView) -> Void {
        let alertVc = UIAlertController(title: "添加图片", message: "选择打开方式", preferredStyle: .actionSheet)
        let library = UIAlertAction(title: "相册", style: .default) { (action) in
            self.openLibrary()
        }
        let camera = UIAlertAction(title: "相机", style: .default) { (action) in
            self.openCamera()
        }
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        
        alertVc.addAction(library)
        alertVc.addAction(camera)
        alertVc.addAction(cancel)
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad {
            let popVc = alertVc.popoverPresentationController
            popVc?.sourceView = sender
            popVc?.sourceRect = sender.bounds
            popVc?.permittedArrowDirections = UIPopoverArrowDirection.any
            
        }
        
        self.present(alertVc, animated: true, completion: nil)
        
        
    }
    //打开相册
    func openLibrary() -> Void {
        let picker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            PHPhotoLibrary.requestAuthorization{ (status) in
                switch status {
                case .notDetermined:
                    self.gotoSetting()
                case .restricted://此应用程序没有被授权访问的照片数据
                    self.gotoSetting()
                case .denied://用户已经明确否认了这一照片数据的应用程序访问
                    self.gotoSetting()
                case .authorized://已经有权限
                    DispatchQueue.main.async {
                        //跳转到相机或者相册
                        picker.delegate = self
                        picker.allowsEditing = false
                        picker.sourceType = .photoLibrary
                        //                    picker.mediaTypes//默认图片
                        //弹出相册页面或相机
                        self.present(picker, animated: true, completion: {})
                    }
                    return
                default: break
                    
                }
            }
        }
    }
    
    //打开相机
    func openCamera() -> Void {
        
        let picker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            AVCaptureDevice.requestAccess(for: AVMediaType.video) { (ist) in
                let status = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
                if status == .authorized {//允许
                    picker.delegate = self
                    picker.allowsEditing = false
                    picker.sourceType = .camera;
                    //弹出相册页面或相机
                    DispatchQueue.main.async {
                        self.present(picker, animated: true, completion: {})
                    }
                    return
                }else if (status==AVAuthorizationStatus.denied)||(status==AVAuthorizationStatus.restricted) {
                    self.gotoSetting()
                }
            }
        }
    }
    
    //去设置权限
    func gotoSetting(){
        let alertController:UIAlertController=UIAlertController.init(title: "去设置", message: "设置-》通用-》", preferredStyle: UIAlertController.Style.alert)
        let sure:UIAlertAction=UIAlertAction.init(title: "去开启权限", style: UIAlertAction.Style.default) { (ac) in
            let url=URL.init(string: UIApplication.openSettingsURLString)
            if UIApplication.shared.canOpenURL(url!){
                UIApplication.shared.open(url!, options: [:], completionHandler: { (ist) in
                })
            }
        }
        alertController.addAction(sure)
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let tempImage = info[.originalImage] as? UIImage else { return }
        if picker.sourceType == .camera {
            let data = tempImage.pngData()
            guard let ttp = data else {
                TProgressHUD.hide()
                MLAlert.show(type: .error, text: "无法获取图片数据,请重试")
                return }
            MLDeugLog(message: "-- 获取到了图片的data数据 --")
            picker.dismiss(animated: true, completion: nil)
        }else{
            let asss = info[UIImagePickerController.InfoKey.phAsset] as? PHAsset
            guard let tt = asss else {
                MLAlert.show(type: .error, text: "无法获取图片数据,请重试")
                return
            }
            
            if #available(iOS 13.0, *) {
                
                let photoManager = PHImageManager.default()

                let requestOptions = PHImageRequestOptions()
                requestOptions.isSynchronous = false // 根据需要设置同步或异步请求
                requestOptions.deliveryMode = .highQualityFormat // 或选择其他合适的模式
                requestOptions.resizeMode = .exact // 或选择其他合适的缩放模式

                let asset: PHAsset = asss ?? PHAsset.init()// 获取所需的PHAsset对象

                photoManager.requestImageDataAndOrientation(for: asset, options: requestOptions) { (data, dataUTI, orientation, info) in
                    if let imageData = data, let dataUTI = dataUTI {
                        // 使用imageData（图像数据）和dataUTI（数据类型标识符）进行后续处理
                        // orientation（图像方向）可用于旋转图像以正确显示
                        self.iconImage = UIImage(data: imageData) ?? UIImage.init()
                        MLDeugLog(message: "-- 获取到了图片的data数据 --")
                    } else {
                        print("未能获取图像数据")
                    }
                }
            } else{
                let manager = PHCachingImageManager()
                TProgressHUD.showWithMessage(message: "正在获取图片...")
                manager.requestImageData(for: tt, options: nil) { [weak self] (data, dataUTI, orientation, info) in
                    TProgressHUD.hide()
                    guard let ttp = data else {
                        MLAlert.show(type: .error, text: "无法获取图片数据,请重试")
                        return }
                    self?.iconImage = UIImage(data: ttp) ?? UIImage.init()
                    MLDeugLog(message: "-- 获取到了图片的data数据 --")
                    picker.dismiss(animated: true, completion: nil)
                }
            }
            
        }
        
    }
    
}
