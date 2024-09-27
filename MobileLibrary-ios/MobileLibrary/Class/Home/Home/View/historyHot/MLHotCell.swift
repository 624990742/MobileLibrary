//
//  MLHotCell.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/3/10.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import UIKit

class MLHotCell: UITableViewCell {
     static let kCellID = "MLHotCell"
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionLayout: UICollectionViewFlowLayout!
    static private let kItemSpace = MLiPhoneHalf(12.0)
    static private let kItemPadd = MLiPhoneHalf(5.0)
    static private let kItemMargin = MLiPhoneHalf(20.0)
    static private let kItemNum = 3.0 //一排几个item
    var itemCellSize: CGSize!
    var itemArr:Array<Any>!
    typealias CategorySelectBlock = (_ row: Int) -> Void
    @objc var categorySelectBlock: CategorySelectBlock?
    
    
    func setupData(item: Array<Any>)  {
        self.itemArr = item
        self.collectionView.reloadData()
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
      
    }
    
    func setupUI(){
        let margin = MLHotCell.kItemMargin
        let space  = MLHotCell.kItemSpace
        let padding  = MLHotCell.kItemPadd
        let itemNum = MLHotCell.kItemNum
        let itemW  = (ML_ScreenWidth - 2 * margin - 2 * padding * (itemNum - 1.0))/itemNum
        MLDeugLog(message: itemW)
        let itemH  = 120.0
        itemCellSize = CGSize(width: itemW, height: itemH)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: margin, bottom: 0,right: margin)
        self.collectionLayout.scrollDirection = .horizontal
        self.collectionLayout.itemSize = itemCellSize
        self.collectionLayout.minimumLineSpacing = space
        self.collectionLayout.minimumInteritemSpacing = padding
        
        self.collectionView.isScrollEnabled = false
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.isPagingEnabled = false
        self.collectionView.register(UINib.init(nibName: MLHotSubCell.kCellID, bundle: nil), forCellWithReuseIdentifier: MLHotSubCell.kCellID)
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension MLHotCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.itemArr.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return  itemCellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MLHotSubCell.kCellID, for: indexPath) as! MLHotSubCell
        cell.setupData(item: self.itemArr[indexPath.item] as! MLHomeModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (self.categorySelectBlock != nil){
            self.categorySelectBlock?(indexPath.item)
        }
    }

    
}
