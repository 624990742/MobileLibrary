import Foundation
import UIKit
import Photos

class MLImagePickerManager: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    typealias ImageCompletion = (UIImage?) -> Void
    
    private var picker: UIImagePickerController?
    private var imageCompletion: ImageCompletion?
    
    func presentImagePicker(from viewController: UIViewController, sourceView: UIView) {
        let alertVc = UIAlertController(title: "添加图片", message: "选择打开方式", preferredStyle: .actionSheet)
        
        let libraryAction = UIAlertAction(title: "相册", style: .default) { _ in
            self.openLibrary(from: viewController)
        }
        
        let cameraAction = UIAlertAction(title: "相机", style: .default) { _ in
            self.openCamera(from: viewController)
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel)
        
        alertVc.addAction(libraryAction)
        alertVc.addAction(cameraAction)
        alertVc.addAction(cancelAction)
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            alertVc.popoverPresentationController?.sourceView = sourceView
            alertVc.popoverPresentationController?.sourceRect = sourceView.bounds
            alertVc.popoverPresentationController?.permittedArrowDirections = .any
        }
        
        viewController.present(alertVc, animated: true)
    }
    
    private func openLibrary(from viewController: UIViewController) {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            return
        }
        
        PHPhotoLibrary.requestAuthorization { status in
            DispatchQueue.main.async {
                switch status {
                case .authorized:
                    self.showImagePicker(sourceType: .photoLibrary, from: viewController)
                default:
                    self.showSettingsAlert(from: viewController)
                }
            }
        }
    }
    
    private func openCamera(from viewController: UIViewController) {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            return
        }
        
        AVCaptureDevice.requestAccess(for: .video) { granted in
            DispatchQueue.main.async {
                if granted {
                    self.showImagePicker(sourceType: .camera, from: viewController)
                } else {
                    self.showSettingsAlert(from: viewController)
                }
            }
        }
    }
    
    private func showImagePicker(sourceType: UIImagePickerController.SourceType, from viewController: UIViewController) {
        picker = UIImagePickerController()
        picker?.delegate = self
        picker?.sourceType = sourceType
        viewController.present(picker!, animated: true)
    }
    
    private func showSettingsAlert(from viewController: UIViewController) {
        let alertController = UIAlertController(title: "去设置", message: "设置-》通用-》", preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: "去开启权限", style: .default) { _ in
            if let settingsURL = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(settingsURL) {
                UIApplication.shared.open(settingsURL)
            }
        }
        alertController.addAction(settingsAction)
        viewController.present(alertController, animated: true)
    }
    

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            dismissPickerAndCallCompletion(nil)
            return
        }
        dismissPickerAndCallCompletion(image)
    }
    
    private func dismissPickerAndCallCompletion(_ image: UIImage?) {
        picker?.dismiss(animated: true) {
            self.imageCompletion?(image)
        }
    }
    
    func pickImage(completion: @escaping ImageCompletion) {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) || UIImagePickerController.isSourceTypeAvailable(.camera) else {
            completion(nil)
            return
        }
        imageCompletion = completion
    }
}

