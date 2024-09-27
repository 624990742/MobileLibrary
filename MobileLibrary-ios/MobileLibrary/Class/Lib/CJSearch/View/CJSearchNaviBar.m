//
//  CJSearchNaviBar.m
//  CJSearchDemo
//
//  Created by 创建zzh on 2017/9/20.
//  Copyright © 2017年 cjzzh. All rights reserved.
//

#import "CJSearchNaviBar.h"
#import "common_define.h"
#import "MobileLibrary-Swift.h"
@interface CJSearchNaviBar ()<UISearchBarDelegate>

@end

@implementation CJSearchNaviBar

- (instancetype)initWithFrame:(CGRect)frame
               beginEditBlock:(SearchBarShouldBeginEditingBlock)editBlock
             clickSearchBlock:(SearchBarSearchButtonClickedBlock)searchBlock {
    self = [super initWithFrame:frame];
    if (self) {
        self.beginEditBlock = editBlock;
        self.searchBlock = searchBlock;
        [self creatView];
    }
    return self;
}

- (void)creatView {
    
    [self addSubview:self.searchBar];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat cancleBtnHeight = 46;
    CGFloat status = [MLOCBridgingSwiftMacro ml_statusBarHeight];
    CGFloat navHeight = [MLOCBridgingSwiftMacro ml_navgationHeight];
    
    CGFloat btnY = status + (navHeight- status - self.searchBar.frame.size.height)/2 - 12;
    cancelBtn.frame = CGRectMake(CGRectGetMaxX(self.searchBar.frame) + 31/2, CGRectGetMaxY(self.searchBar.frame)- btnY, 45, cancleBtnHeight);
    [cancelBtn addTarget:self action:@selector(backToSuperView) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    cancelBtn.backgroundColor = [UIColor clearColor];
    [self addSubview:cancelBtn];
}

- (void)backToSuperView {
    if (self.clickCancelBlock) {
        self.clickCancelBlock();
    }
}
#pragma mark -- SearchBarDelegate
//如果是联想词搜索
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (self.tfdDidChangedBlock) {
        self.openAssociativeSearch = YES;
        self.tfdDidChangedBlock(searchText);
    }
}
//点击清除按钮 || 呼出键盘
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    if ([searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0) {
        if (self.beginEditBlock) {
            self.beginEditBlock(searchBar);
        }
    }
    return YES;
}
//点击搜索
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if ([searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0) return;
    
    [searchBar resignFirstResponder];
    
    if (self.searchBlock) {
        self.searchBlock(searchBar);
    }
}

#pragma mark -- LazyLoad

- (UISearchBar *)searchBar
{
    if (!_searchBar) {
        
        CGFloat searchBarHeight = 30;
        
        CGFloat status = [MLOCBridgingSwiftMacro ml_statusBarHeight];
        CGFloat navHeight = [MLOCBridgingSwiftMacro ml_navgationHeight];
        
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(10, status + (navHeight- status - searchBarHeight)/2 - 12, [MLOCBridgingSwiftMacro ml_screenWidth] - 80, searchBarHeight)];
        _searchBar.delegate = self;
        
        
        _searchBar.placeholder = @"请输入搜索名称";
        _searchBar.layer.cornerRadius = 15;
        _searchBar.layer.masksToBounds = YES;
        _searchBar.backgroundImage = [self imageWithColor:[MLOCBridgingSwiftMacro ml_f7f8Color]];
        //放大镜
        UIImage *leftImage = [UIImage imageNamed:@"ic_search"];
        [_searchBar setImage:leftImage forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
        
        //清除按钮
        UIImage *clearImage = [UIImage imageNamed:@"searchBar_right_clear_icon"];
        [_searchBar setImage:clearImage forSearchBarIcon:UISearchBarIconClear state:UIControlStateNormal];
        
        
        UITextField *searchField = [self getSearchTextField:_searchBar];
        searchField.enablesReturnKeyAutomatically = YES;
        NSMutableAttributedString *arrStr = [[NSMutableAttributedString alloc]initWithString:searchField.placeholder attributes:@{NSForegroundColorAttributeName : [MLOCBridgingSwiftMacro ml_twoTitleColor],NSFontAttributeName:[UIFont systemFontOfSize:15]}];
            searchField.attributedPlaceholder= arrStr;
        searchField.backgroundColor = [MLOCBridgingSwiftMacro ml_f7f8Color];
//        searchField.backgroundColor = kSearchBarTFDColor;
        searchField.textColor = [MLOCBridgingSwiftMacro ml_twoTitleColor];
        
    }
    return _searchBar;
}

- (UITextField *)getSearchTextField:(UISearchBar *)searchBar
{
    
    if (@available(iOS 13.0, *)) {
        return [searchBar valueForKey:@"_searchTextField"];
      }
    return [searchBar valueForKey:@"_searchField"];
}

- (UIImage *)imageWithColor:(UIColor *)color
{
    
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return theImage;
}
@end
