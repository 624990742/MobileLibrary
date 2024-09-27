//
//  MLWorkController.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/3/4.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import UIKit

class MLWorkController: MLBaseController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
   
    ///model
    var workPateArr: [MLWorkModel] = [MLWorkModel]()
    private let kSentionTitleHeight = MLiPhoneHalf(46.0)
    private let kItemHeight = MLiPhoneHalf(100.0)
    
    let collectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 10
            layout.minimumLineSpacing = 10
            layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10) // 设置上下左右间距

            let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
            cv.backgroundColor = .white
            cv.register(UINib(nibName: MLWorkPateCell.KMLCellId, bundle: nil), forCellWithReuseIdentifier: MLWorkPateCell.KMLCellId)
           cv.register(UINib(nibName: MLSentionTitleView.kMLSentionTitleID, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MLSentionTitleView.kMLSentionTitleID)
            return cv
        }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupSentionTitleData()
    }


    func setupUI(){
        self.setNavTitle(title: "工作台")
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(self.view)
            make.top.equalTo(self.gk_navigationBar.snp.bottom)
        }
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.backgroundColor = .clear
        self.view.backgroundColor = ML_F7F8Color
    }
    
    
    // MARK: - UICollectionViewDelegate
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.workPateArr.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if self.workPateArr.isEmpty {
            return 0
        }
        let model = self.workPateArr[section]
        return model.child.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: floor((ML_ScreenWidth - 40)/2.0), height: kItemHeight)
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MLWorkPateCell = collectionView.dequeueReusableCell(withReuseIdentifier:  MLWorkPateCell.KMLCellId, for: indexPath) as! MLWorkPateCell
        if self.workPateArr.isEmpty == false {
            let model = self.workPateArr[indexPath.section]
            if  model.child.count > 0 {
                let item = model.child[indexPath.item]
                cell.model = item
            }
        }
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind ==  UICollectionView.elementKindSectionHeader {
            let headerView: MLSentionTitleView =  collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MLSentionTitleView.kMLSentionTitleID, for: indexPath) as! MLSentionTitleView
               
            if self.workPateArr.isEmpty == false {
             let model = self.workPateArr[indexPath.section]
                headerView.lineTitleLabel.text = model.name
            }
            return headerView
        }
       return UICollectionReusableView()
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: kSentionTitleHeight)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sec = indexPath.section
        let index = indexPath.item
  
        switch sec {
        case 0:
            
            var vc = UIViewController()
            if index == 1 {
                vc = MLBookStorageController.init()
            }else{
                vc = MLBookSearchController.init()
            }
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 1:
            let roleType: MLPeopleRoleListType = index == 1 ? MLPeopleRoleListType.MLPeopleRole_manager : MLPeopleRoleListType.MLPeopleRole_reader
               let vc = MLPeopleRoleController.init(nibName: "MLPeopleRoleController", bundle: nil)
                   vc.roleType = roleType
               self.navigationController?.pushViewController(vc, animated: true)
            break
        case 2:
            let type: MLBookOptionType = index == 1 ? MLBookOptionType.jieYueType : MLBookOptionType.guiHuanType
            let vc = MLBorrowBooksListController.init(nibName: "MLBorrowBooksListController", bundle: nil)
            vc.oprtionType = type
            self.navigationController?.pushViewController(vc, animated: true)
    
            break
        default:
            MLDeugLog(message: "测试数据")
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


extension MLWorkController{

    func setupSentionTitleData(){
        if let path = Bundle.main.path(forResource: "WorkPowerInfoList", ofType: "plist") {
            if let array = NSArray(contentsOfFile: path) as? [[String: Any]] {
                array.forEach { obj in
                    let model = MLWorkModel.deserialize(from: obj)
                    workPateArr.append(model ?? MLWorkModel.init())
                }
                
                MLDeugLog(message: "无法读取 plist 文件内容")
            } else {
                MLDeugLog(message: "无法读取 plist 文件内容")
            }
        } else {
            MLDeugLog(message: "找不到 plist 文件")
        }
    }

}
