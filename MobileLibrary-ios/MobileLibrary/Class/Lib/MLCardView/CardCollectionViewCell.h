//
//  CardCollectionViewCell.h
//  卡片转场1
//
//  Created by Mac on 2018/1/26.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardStartsView.h"
#import "CardUsersView.h"
#import "CardModel.h"
@interface CardCollectionViewCell : UICollectionViewCell

///卡片控件大背景
@property (nonatomic, strong) UIView *bgView;
///图片视图
@property (nonatomic, strong) UIImageView *coverImageView;
///文本视图
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *authourLabel;
@property (nonatomic, strong) UILabel *pressLabel;
@property (nonatomic, strong) UIImageView *bookCoverImageView;
@property (nonatomic, strong) UILabel *contentLabel;

///用来传递索引（不用tag，避免冲突）
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, copy) void (^tapCoverImageBlock)(NSInteger index);

- (void)loadData:(CardModel *)model;


@end
