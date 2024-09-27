//
//  MLBaseNavgationController.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/3/4.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//
import UIKit
class MLBaseNavgationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navBaseSetup()
    }
    func navBaseSetup() {
      self.interactivePopGestureRecognizer!.delegate = nil;
        let customApperance = UINavigationBar.appearance()
        customApperance.isTranslucent = false

        customApperance.setBackgroundImage(UIImage.imageColor(color:                                                                .clear, size: CGSize.init(width: 1, height: 1)), for: UIBarMetrics.default)
        
        var textAttrs: [NSAttributedString.Key : AnyObject] = Dictionary()
        textAttrs[NSAttributedString.Key.foregroundColor] = UIColor.white
        textAttrs[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 16)
        customApperance.titleTextAttributes = textAttrs
    }
    lazy var backBtn: UIButton = UIButton(backTarget: self, action: #selector(MLBaseNavgationController.backBtnAction))
    @objc func backBtnAction() {
        self.popViewController(animated: true)
    }
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.children.count > 0 {
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    ///把当前控制器从导航栈中移除
    func removeTaskStackController(toClass classObj: AnyClass) {
        if let navigationController = self.navigationController {
            let filteredViewControllers = navigationController.viewControllers.filter { !$0.isKind(of: classObj) }
            navigationController.setViewControllers(filteredViewControllers, animated: false)
        }
    }

}
