//
//  common_define.h
//  CJSearchDemo
//
//  Created by 创建zzh on 2017/9/18.
//  Copyright © 2017年 cjzzh. All rights reserved.
//

#ifndef common_define_h
#define common_define_h


#define CJ_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define  CJ_StatusBarHeight      (CJ_iPhoneX ? 44.f : 20.f)

//#define  CJ_NavigationBarHeight  44.f

//#define  CJ_TabbarHeight         (CJ_iPhoneX ? (49.f+34.f) : 49.f)

//#define  CJ_TabbarSafeBottomMargin         (CJ_iPhoneX ? 34.f : 0.f)

#define  CJ_StatusBarAndNavigationBarHeight  (CJ_iPhoneX ? 88.f : 64.f)

//
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

//搜索框颜色
#define kSearchBarTFDColor UIColorHex(0x00B38A)
//文字颜色
#define kMainTextColor UIColorHex(0x646464)

#define UIColorHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


/** 字体离边框的水平距离 */
#define kTitleHorizontal_space 10.0f

/** 字体离边框的竖直距离 */
#define kTitleVertical_space   5.0f

/** tagLab之间的水平间距 */
#define kTagHorizontal_margin  15.0f

/** tagLab之间的竖直间距 */
#define kTagVertical_margin    10.0f

/** tagLab与屏幕左右间距 */
#define kTagScreen_margin  12.f

/** tag字体 **/
#define kTagFont [UIFont boldSystemFontOfSize:13]


#endif /* common_define_h */
