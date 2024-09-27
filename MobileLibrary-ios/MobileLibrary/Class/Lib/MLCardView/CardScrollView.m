//
//  CardScrollView.m
//  卡片转场1
//
//  Created by Mac on 2018/1/26.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "CardScrollView.h"
#import "CardModel.h"
#import "CardCollectionViewCell.h"
#import "CardFlowLayout.h"
#import "MobileLibrary-Swift.h"
#define CellId @"CellId"

@interface CardScrollView() <UICollectionViewDataSource, UICollectionViewDelegate>

///背景毛玻璃图片
@property (nonatomic, strong) UIImageView *BgView;

///模型数组
@property (nonatomic, strong) NSArray <CardModel *> *imageArray;


@end

@implementation CardScrollView
{
    CGFloat     _startDragX;        //开始移动的位置
    CGFloat     _endDragX;          //停止移动的位置
    CGFloat     _dragMiniDistance;  //最小移动的临界值
    NSInteger   _currentIndex;      //当前切换到的卡片索引位置
    NSInteger   _maxIndex;          //最大的索引位置
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        __weak typeof(self) weakSelf = self;
        [MLOCBridgingSwiftMacro loadModelsAsDictionariesWithName:@"LibraryCircleBook" type:@"json" completion:^(NSArray * dataArr, NSError *  error) {
            if (!error) {
                NSMutableArray *arrM = [NSMutableArray array];
                
                NSInteger index = 1;
                for (NSDictionary *dict in dataArr) {
                    CardModel *model = [weakSelf createModelWithBookTitle:dict[@"bookTitle"]
                                                                    index:index
                                                                  authour:dict[@"bookAuthor"]
                                                                  content:dict[@"bookBrief"]
                                                                bookPress:dict[@"bookPress"]];
                    if (model) {
                        [arrM addObject:model];
                    }
                    index++;
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakSelf.imageArray = arrM;
                    [weakSelf setupUI];
                    self->_dragMiniDistance = weakSelf.collectionView.bounds.size.width / 20;
                    self->_maxIndex = weakSelf.imageArray.count - 1;
                });
            }
        }];
    }
    return self;
}




- (CardModel *)createModelWithBookTitle:(NSString *)title
                                 index:(NSInteger)index
                               authour:(NSString *)authour
                               content:(NSString *)contentStr
                              bookPress:(NSString *)bookPress
{
    
    CardModel *model = [[CardModel alloc] init];
    model.cardPicName = [NSString stringWithFormat:@"%ld",(long)index];
    model.bookTitle = title;
    model.bookCover = [NSString stringWithFormat:@"book%ld",(long)index];
    model.bookAuthour = authour;
    model.bookContent = contentStr;
    model.bookPress = bookPress;
    return model;
}







- (void)setupUI
{
    //初始化背景图并附加毛玻璃效果
    self.BgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.imageArray[0].cardPicName]];
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = self.BgView.bounds;
    [self.BgView addSubview:effectView];
    
    
    //初始化collectionView
    CardFlowLayout *layout = [[CardFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [MLOCBridgingSwiftMacro ml_screenWidth], [MLOCBridgingSwiftMacro ml_screenHeight]) collectionViewLayout:layout];
    self.collectionView.backgroundView = self.BgView;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[CardCollectionViewCell class] forCellWithReuseIdentifier:CellId];
    
    //隐藏滚动条
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    [self addSubview:self.collectionView];
    
  
}

#pragma mark - collectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CardCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellId forIndexPath:indexPath];
    [cell loadData:self.imageArray[indexPath.row]];
    
    cell.index = indexPath.row;

    cell.tapCoverImageBlock = ^(NSInteger index) {
        if ([self.delegate respondsToSelector:@selector(cardScrollViewDelegateDidSelectAtIndex: imageModel:)]) {
            [self.delegate cardScrollViewDelegateDidSelectAtIndex:index imageModel:self.imageArray[index]];
        }
    };
    
    return cell;
}

#pragma mark - scrollView delegate
/**
 修正cell居中
 */

//开始拖拽collectionView(scrollView的子类）
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
//    NSLog(@"开始拖动%f",scrollView.contentOffset.x);
    _startDragX = scrollView.contentOffset.x;
}

//停止拖拽collectionView
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
//    NSLog(@"停止拖动%f",scrollView.contentOffset.x);
    _endDragX = scrollView.contentOffset.x;
    
    CGFloat delta = _startDragX - _endDragX;
    
    if (delta >= _dragMiniDistance) {
        //向右滑动
        _currentIndex -= 1;
        
    } else if (delta * -1 >= _dragMiniDistance) {
        //向左滑动
        _currentIndex += 1;
    }
    
    _currentIndex = _currentIndex <= 0 ? 0 : _currentIndex;
    _currentIndex = _currentIndex >= _maxIndex ? _maxIndex : _currentIndex;
    
    //等候数据源方法确定，所以用主队列异步
    dispatch_async(dispatch_get_main_queue(), ^{
    
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    });
    
    self.BgView.image = [UIImage imageNamed:self.imageArray[_currentIndex].cardPicName];
}


@end










