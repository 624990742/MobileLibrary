//
//  CardModel.h
//  卡片转场1
//
//  Created by Mac on 2018/1/26.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CardModel : NSObject

@property(nonatomic, strong) NSString *cardPicName;
@property(nonatomic, strong) NSString *bookTitle;
@property(nonatomic, strong) NSString *bookCover;
@property(nonatomic, strong) NSString *bookAuthour;
@property(nonatomic, strong) NSString *bookContent;
@property(nonatomic, strong) NSString *bookPress;

@end
