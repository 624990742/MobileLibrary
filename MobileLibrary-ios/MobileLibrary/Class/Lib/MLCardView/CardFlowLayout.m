//
//  CardFlowLayout.m
//  卡片转场1
//
//  Created by Mac on 2018/1/26.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "CardFlowLayout.h"
#import "MobileLibrary-Swift.h"
#define kScreenHeight  [MLOCBridgingSwiftMacro ml_screenHeight]
#define kScreenWidth   [MLOCBridgingSwiftMacro ml_screenWidth]
#define ItemHeight (kScreenHeight * (6.0 / 9))
#define ItemWidth (kScreenWidth * (4.0 / 5))

@implementation CardFlowLayout

- (instancetype)init
{
    if (self = [super init]) {
        
        self.itemSize = CGSizeMake(ItemWidth, ItemHeight);
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;   //水平方向
        self.sectionInset = UIEdgeInsetsMake(0, kScreenWidth/2 - ItemWidth/2, 0, kScreenWidth/2 - ItemWidth/2);   //设置组边距
        
        self.minimumLineSpacing = (kScreenWidth - ItemWidth)/4;
    }
    
    return self;
}


- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    //这样就拿到了所有的布局属性
    //[super layoutAttributesForElementsInRect:rect].copy;
    NSArray<UICollectionViewLayoutAttributes *> *arr = [self getCopyOfAttributes:[super layoutAttributesForElementsInRect:rect]];

    //这样就通过遍历每个属性对其进行修改来达到预期的效果
    
    //获取屏幕中线
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width / 2.0;
    //拿到每个属性
    for (UICollectionViewLayoutAttributes *attr in arr) {
       
        //布局属性与中线的距离
        CGFloat distance = fabs(attr.center.x - centerX);
        //距离与屏幕宽的比例（为了计算缩放的比例）
        CGFloat disScale = distance / self.collectionView.bounds.size.width;
        //确定缩放的大小
        CGFloat scale = fabs(cos(disScale * M_PI / 4));
        
        //对布局属性进行缩放变换
        attr.transform = CGAffineTransformMakeScale(1.0, scale);
        
        //同时也利用这个比例对透明度进行一下更改，显得自然
        attr.alpha = scale;
    
    }
    
    return arr;
}


- (NSArray<UICollectionViewLayoutAttributes *> *)getCopyOfAttributes:(NSArray *)attributes {
    NSMutableArray *copyArr = [NSMutableArray new];
    for (UICollectionViewLayoutAttributes *attribute in attributes) {
        [copyArr addObject:[attribute copy]];
    }
    return copyArr;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return true;
}

@end
