//
//  CardScrollView.h
//  卡片转场1
//
//  Created by Mac on 2018/1/26.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardModel.h"
@protocol CardScrollViewDelegate <NSObject>

- (void)cardScrollViewDelegateDidSelectAtIndex:(NSInteger)index
                                    imageModel:(CardModel *)imageModel;

@end

@interface CardScrollView : UIView

@property (nonatomic, weak) id<CardScrollViewDelegate> delegate;

///collectionView视图
@property (nonatomic, strong) UICollectionView *collectionView;

@end
