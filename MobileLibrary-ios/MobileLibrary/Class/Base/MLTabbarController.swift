//
//  MLTabbarController.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/3/4.
//
import UIKit
class MLTabbarController: UITabBarController,UITabBarControllerDelegate {
    var customTabBarBgImg:UIImageView?
    var customTabBarBgImgSelected:UIImageView?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpAllChildViewController()
        self.baseSetup()
        NotificationCenter.default.addObserver(self, selector: #selector(logout), name: NSNotification.Name.init(rawValue: MLNOTIFICATION_LOGOUT), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(login), name: NSNotification.Name.init(rawValue: ML_LOGIN_SUCCESS), object: nil)
    }
    func setUpAllChildViewController() {
                
        var newViewControllers: [UIViewController] = []

        let nav1 = self.setUpOneChildViewController(viewController: MLHomeController() , image: UIImage.init(named: "ic_home_no")!, selectedImage: UIImage.init(named: "ic_home_sel")!, title: "推荐")
        newViewControllers.append(nav1)
        
        let nav2 = self.setUpOneChildViewController(viewController: MLLibraryCircleController(), image: UIImage.init(named: "luntai_no")!, selectedImage: UIImage.init(named: "luntai_sel")!, title: "圈子")
        newViewControllers.append(nav2)

        if MLHelper.isLogin() && (MLUserInfoManager.userRole == MLPublickTool.kManager || MLUserInfoManager.userRole == MLPublickTool.kSupeManager) {
           let  nav3 = self.setUpOneChildViewController(viewController: MLWorkController(), image: UIImage.init(named: "ic_work_no")!, selectedImage: UIImage.init(named: "ic_work_sel")!, title: "工作台")
            newViewControllers.append(nav3)
        }
        
       let nav4 = self.setUpOneChildViewController(viewController: MLMeContrller(), image: UIImage.init(named: "mine_no")!, selectedImage: UIImage.init(named: "mine_sel")!, title: "我的")
        newViewControllers.append(nav4)
        
        setViewControllers(newViewControllers, animated: false)
    }

    func setUpOneChildViewController(viewController: UIViewController, image: UIImage, selectedImage: UIImage, title: NSString) -> MLBaseNavgationController {
    let navVC = MLBaseNavgationController.init(rootViewController: viewController)
    let  barItem  = UITabBarItem.init(title: title as String, image: image, selectedImage: selectedImage.withRenderingMode(.alwaysOriginal))
        barItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.orange], for: .selected)
        if #available(iOS 13.0, *) {
            let uitabApp:UITabBarAppearance = UITabBarAppearance()
            uitabApp.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor(hexString: "0x9ca4ab")]
            uitabApp.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor(hexString: "0x30b5ff")]
            barItem.standardAppearance = uitabApp
        } else {
            // Fallback on earlier versions
        }
        navVC.tabBarItem = barItem
//        self.addChild(navVC)
        return navVC
    }
    
    func baseSetup() {
    let  tabBarAppearance = UITabBar.appearance()
    tabBarAppearance.backgroundImage = UIImage.initImageWithColor(color: .white)
      tabBarAppearance.shadowImage = UIImage.initImageWithColor(color: UIColor(r: 247, g: 247, b: 247))
    self.tabBar.unselectedItemTintColor = UIColor(r: 51, g: 51, b: 51)
    self.tabBar.layer.shadowColor = UIColor.black.cgColor;
    self.tabBar.layer.shadowOffset = CGSize(width: 0, height: -5);
    self.tabBar.layer.shadowOpacity = 0.05;
    self.tabBar.backgroundColor = .white
    self.view.backgroundColor = .white
        self.delegate = self
    }
    
    
    
    //MARK: - 切换控制器
 
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        if ((MLUserInfoManager.userId?.isEmpty) != nil) {
            return
        }
        
        if tabBarController.selectedIndex  ==  1 || tabBarController.selectedIndex == 2 {
            MLHelper.isLoginState {}
            tabBarController.selectedIndex = 0
        }
    }
    
    //MARK: - 通知
    @objc func logout(_ notification : NSNotification) -> Void {
        
        if ((MLUserInfoManager.userId?.isEmpty) != nil) {
            return
        }
        if self.viewControllers?.count ?? 0 > 3 {
            self.viewControllers?.remove(at: 2)
        }
        DispatchQueue.main.async {
            self.tabBarController?.selectedIndex = 0
        }
    }
    

//
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    @objc func login(_ notification : NSNotification) -> Void {
        
        self.setUpAllChildViewController()
        MLDeugLog(message: "\(String(describing: self.viewControllers))")
    }
    
   
}

