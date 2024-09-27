//
//  CardCollectionViewCell.m
//  卡片转场1
//
//  Created by Mac on 2018/1/26.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "CardCollectionViewCell.h"
@interface CardCollectionViewCell ()

@end

@implementation CardCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
    }
    
    return self;
}


- (void)setupUI
{
    //阴影视图
    UIView *shadowView =  [self createShadowView];
    
    //背景视图
    self.bgView = [self setViewWithColor:[UIColor whiteColor] andCornerRadius:5 andAlpha:0.0];
    
    [shadowView addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(shadowView);
    }];
    
    
    //最上面的图片
    self.coverImageView = [[UIImageView alloc] init];
    self.coverImageView.layer.cornerRadius = 5; //切个小圆角
    self.coverImageView.layer.masksToBounds = YES;
    self.coverImageView.userInteractionEnabled = NO;
    [shadowView addSubview:self.coverImageView];
    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(shadowView);
    }];
    
    
    //文字视图
    self.titleView = [self setViewWithColor:[UIColor whiteColor] andCornerRadius:5 andAlpha:1.0];
    [shadowView addSubview:self.titleView];
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(shadowView.mas_bottom);
        make.left.equalTo(shadowView.mas_left);
        make.right.equalTo(shadowView.mas_right);
        make.height.mas_equalTo(@200);
    }];
    
  
    
    self.bookCoverImageView = [[UIImageView alloc] init];
    self.bookCoverImageView.layer.cornerRadius = 10; //切个小圆角
    self.bookCoverImageView.layer.masksToBounds = YES;
    self.bookCoverImageView.userInteractionEnabled = NO;
    [self.titleView addSubview:self.bookCoverImageView];
    [self.bookCoverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleView.mas_top).mas_offset(15);;
        make.left.equalTo(self.titleView.mas_left).mas_offset(20);
        make.width.mas_equalTo(@80);
        make.height.mas_equalTo(@100);
    }];
    
    
    //标题
    self.title = [UILabel cz_labelWithText:@"" fontSize:16 color:[UIColor blackColor]];
    self.title.numberOfLines = 1;
    [self.titleView addSubview:self.title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleView.mas_top).offset(15);
        make.left.equalTo(self.bookCoverImageView.mas_right).offset(10);
        make.right.equalTo(self.titleView.mas_right).offset(0);
        make.height.mas_equalTo(@20);
    }];
    
    
    
    self.authourLabel = [UILabel cz_labelWithText:@"" fontSize:14 color:[UIColor grayColor]];
    self.authourLabel.textAlignment = NSTextAlignmentLeft;
    [self.titleView addSubview:self.authourLabel];
    [self.authourLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.title.mas_bottom).offset(10);
        make.left.equalTo(self.bookCoverImageView.mas_right).offset(10);
        make.right.equalTo(self.titleView.mas_right).offset(10);
    }];
    
    
    self.pressLabel = [UILabel cz_labelWithText:@"100 comments" fontSize:14 color:[UIColor grayColor]];
    self.pressLabel.textAlignment = NSTextAlignmentLeft;
    [self.titleView addSubview:self.pressLabel];
    [self.pressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.authourLabel.mas_bottom).offset(10);
        make.left.equalTo(self.bookCoverImageView.mas_right).offset(10);
        make.right.equalTo(self.titleView.mas_right).offset(10);
    }];
    
    

    self.contentLabel = [UILabel cz_labelWithText:@"" fontSize:14 color:[UIColor grayColor]];
    self.contentLabel.textAlignment = NSTextAlignmentLeft;
    [self.titleView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bookCoverImageView.mas_bottom).offset(4);
        make.left.equalTo(self.titleView.mas_left).offset(10);
        make.right.equalTo(self.titleView.mas_right).offset(-10);
        make.bottom.equalTo(self.titleView.mas_bottom);
    }];

    
    

    

    //添加点击手势
    UITapGestureRecognizer *tapImage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage)];
    [self addGestureRecognizer:tapImage];
//    [self.coverImageView addGestureRecognizer:tapImage];
}

- (void)tapImage
{
    if (self.tapCoverImageBlock) {
        self.tapCoverImageBlock(self.index);
    }
}

- (void)loadData:(CardModel *)model
{
    self.coverImageView.image = [UIImage imageNamed:model.cardPicName];
    self.bookCoverImageView.image = [UIImage imageNamed:model.bookCover];
    self.title.text = [NSString stringWithFormat:@"书名：%@",model.bookTitle];
    self.authourLabel.text = [NSString stringWithFormat:@"作者:%@",model.bookAuthour];
    self.pressLabel.text = [NSString stringWithFormat:@"出版社:%@",model.bookPress];
    self.contentLabel.text = model.bookContent;
    
}

- (UIView *)setViewWithColor:(UIColor *)color andCornerRadius:(CGFloat)radius andAlpha:(CGFloat)alpha
{
    UIView *view = [[UIView alloc] init];
    view.alpha = alpha;
    view.backgroundColor = color;
    view.layer.cornerRadius = radius;
    view.layer.masksToBounds = YES;
    
    return view;
}

- (UIView *)createShadowView
{
    //阴影视图
    UIView *shadowView = [[UIView alloc] init];
    shadowView.layer.cornerRadius = 5;
    shadowView.clipsToBounds = NO;
    shadowView.layer.shadowColor = [UIColor colorWithRed:138.0/255 green:138.0/255 blue:138.0/255 alpha:1.0].CGColor;
    shadowView.layer.shadowOffset = CGSizeMake(0, 5);
    shadowView.layer.shadowOpacity = 0.8;
    shadowView.layer.shadowRadius = 10;
    
    [self.contentView addSubview:shadowView];
    [shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    return shadowView;
}



@end
