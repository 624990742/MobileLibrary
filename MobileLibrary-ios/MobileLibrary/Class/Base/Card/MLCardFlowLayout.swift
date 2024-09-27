//
//  MLCardFlowLayout.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/5/2.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import Foundation
import UIKit

private  let  ItemHeight  = (ML_ScreenHeight * (6.0 / 9))
private  let  ItemWidth  = (ML_ScreenWidth * (4.0 / 5))

class CardFlowLayout: UICollectionViewFlowLayout {

    override init() {
        super.init()
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }

    private func setupLayout() {
        itemSize = CGSize(width: ML_ScreenWidth * (4.0 / 5), height: ML_ScreenHeight * (6.0 / 9))
        scrollDirection = .horizontal
        sectionInset = UIEdgeInsets(top: 0, left: ML_ScreenWidth/2 - ItemWidth/2, bottom: 0, right: ML_ScreenWidth/2 - ItemWidth/2)
        minimumLineSpacing = (ML_ScreenWidth - ItemWidth) / 4
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
         let attributes = super.layoutAttributesForElements(in: rect)?.map { $0.copy() }

        let centerX = (collectionView?.contentOffset.x)! + (collectionView?.bounds.size.width)! / 2.0
        for attr in attributes {
            let distance = abs(attr.center.x - centerX)
            let disScale = distance / collectionView?.bounds.size.width
            let scale = abs(cos(disScale * Double.pi / 4))

            attr.transform = CGAffineTransform(scaleX: 1.0, y: CGFloat(scale))
            attr.alpha = scale
        }

        return attributes
    }

    private func getCopyOfAttributes(_ attributes: [UICollectionViewLayoutAttributes]) -> [UICollectionViewLayoutAttributes] {
        return attributes.map { $0.copy() as! UICollectionViewLayoutAttributes }
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
