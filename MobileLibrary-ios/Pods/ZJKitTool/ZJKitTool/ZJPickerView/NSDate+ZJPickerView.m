//
//  NSDate+ZJPickerView.m
//  ZJKitTool
//
//  Created by 邓志坚 on 2018/7/4.
//  Copyright © 2018年 kapokcloud. All rights reserved.
//

#import "NSDate+ZJPickerView.h"
#import "ZJPickerViewMacro.h"

ZJSYNTH_DUMMY_CLASS(NSDate_ZJPickerView)

static const NSCalendarUnit unitFlags = (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfMonth |  NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal);
@implementation NSDate (ZJPickerView)

#pragma mark - 获取日历单例对象
+ (NSCalendar *)calendar {
    static NSCalendar *sharedCalendar = nil;
    if (!sharedCalendar) {
        // 创建日历对象：返回当前客户端的逻辑日历(当每次修改系统日历设定，其实例化的对象也会随之改变)
        sharedCalendar = [NSCalendar autoupdatingCurrentCalendar];
    }
    return sharedCalendar;
}

#pragma mark - 获取指定日期的年份
- (NSInteger)zj_year {
    // NSDateComponent 可以获得日期的详细信息，即日期的组成
    NSDateComponents *components = [[NSDate calendar] components:unitFlags fromDate:self];
    return components.year;
}

#pragma mark - 获取指定日期的月份
- (NSInteger)zj_month {
    NSDateComponents *components = [[NSDate calendar] components:unitFlags fromDate:self];
    return components.month;
}

#pragma mark - 获取指定日期的天
- (NSInteger)zj_day {
    NSDateComponents *components = [[NSDate calendar] components:unitFlags fromDate:self];
    return components.day;
}

#pragma mark - 获取指定日期的小时
- (NSInteger)zj_hour {
    NSDateComponents *components = [[NSDate calendar] components:unitFlags fromDate:self];
    return components.hour;
}

#pragma mark - 获取指定日期的分钟
- (NSInteger)zj_minute {
    NSDateComponents *comps = [[NSDate calendar] components:unitFlags fromDate:self];
    return comps.minute;
}

#pragma mark - 获取指定日期的秒
- (NSInteger)zj_second {
    NSDateComponents *components = [[NSDate calendar] components:unitFlags fromDate:self];
    return components.second;
}

#pragma mark - 获取指定日期的星期
- (NSInteger)zj_weekday {
    NSDateComponents *components = [[NSDate calendar] components:unitFlags fromDate:self];
    return components.weekday;
}

///// 提示：除了使用 NSDateComponents 获取年月日等信息，还可以通过格式化日期获取日期的详细的信息 //////

#pragma mark - 创建date
+ (NSDate *)zj_setYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second {
    NSCalendar *calendar = [NSDate calendar];
    // 初始化日期组件
    NSDateComponents *components = [calendar components:unitFlags fromDate:[NSDate date]];
    if (year >= 0) {
        components.year = year;
    }
    if (month >= 0) {
        components.month = month;
    }
    if (day >= 0) {
        components.day = day;
    }
    if (hour >= 0) {
        components.hour = hour;
    }
    if (minute >= 0) {
        components.minute = minute;
    }
    if (second >= 0) {
        components.second = second;
    }
    NSDate *date = [calendar dateFromComponents:components];
    return date;
}

+ (NSDate *)zj_setYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute {
    return [self zj_setYear:year month:month day:day hour:hour minute:minute second:-1];
}

+ (NSDate *)zj_setYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    return [self zj_setYear:year month:month day:day hour:-1 minute:-1 second:-1];
}

+ (NSDate *)zj_setYear:(NSInteger)year month:(NSInteger)month {
    return [self zj_setYear:year month:month day:-1 hour:-1 minute:-1 second:-1];
}

+ (NSDate *)zj_setYear:(NSInteger)year {
    return [self zj_setYear:year month:-1 day:-1 hour:-1 minute:-1 second:-1];
}

+ (NSDate *)zj_setMonth:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute {
    return [self zj_setYear:-1 month:month day:day hour:hour minute:minute second:-1];
}

+ (NSDate *)zj_setMonth:(NSInteger)month day:(NSInteger)day {
    return [self zj_setYear:-1 month:month day:day hour:-1 minute:-1 second:-1];
}

+ (NSDate *)zj_setHour:(NSInteger)hour minute:(NSInteger)minute {
    return [self zj_setYear:-1 month:-1 day:-1 hour:hour minute:minute second:-1];
}

+ (NSDate *)setYear:(NSInteger)year {
    return [self zj_setYear:year];
}

+ (NSDate *)setYear:(NSInteger)year month:(NSInteger)month {
    return [self zj_setYear:year month:month];
}

+ (NSDate *)setYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    return [self zj_setYear:year month:month day:day];
}

+ (NSDate *)setYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute {
    return [self zj_setYear:year month:month day:day hour:hour minute:minute];
}

+ (NSDate *)setMonth:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute {
    return [self zj_setMonth:month day:day hour:hour minute:minute];
}

+ (NSDate *)setMonth:(NSInteger)month day:(NSInteger)day {
    return [self zj_setMonth:month day:day];
}

+ (NSDate *)setHour:(NSInteger)hour minute:(NSInteger)minute {
    return [self zj_setHour:hour minute:minute];
}

#pragma mark - 日期和字符串之间的转换：NSDate --> NSString
+ (NSString *)zj_getDateString:(NSDate *)date format:(NSString *)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [NSLocale currentLocale];
    dateFormatter.timeZone = [NSTimeZone localTimeZone];
    dateFormatter.dateFormat = format;
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
}

#pragma mark - 日期和字符串之间的转换：NSString --> NSDate
+ (NSDate *)zj_getDate:(NSString *)dateString format:(NSString *)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [NSLocale currentLocale];
    dateFormatter.timeZone = [NSTimeZone localTimeZone];
    dateFormatter.dateFormat = format;
    NSDate *destDate = [dateFormatter dateFromString:dateString];
    
    return destDate;
}

#pragma mark - 算法1：获取某个月的天数（通过年月求每月天数）
+ (NSUInteger)zj_getDaysInYear:(NSInteger)year month:(NSInteger)month {
    BOOL isLeapYear = year % 4 == 0 ? (year % 100 == 0 ? (year % 400 == 0 ? YES : NO) : YES) : NO;
    switch (month) {
        case 1:case 3:case 5:case 7:case 8:case 10:case 12:
        {
            return 31;
            break;
        }
        case 4:case 6:case 9:case 11:
        {
            return 30;
            break;
        }
        case 2:
        {
            if (isLeapYear) {
                return 29;
                break;
            } else {
                return 28;
                break;
            }
        }
        default:
            break;
    }
    return 0;
}

#pragma mark - 算法2：获取某个月的天数（通过年月求每月天数）
+ (NSUInteger)zj_getDaysInYear2:(NSInteger)year month:(NSInteger)month {
    NSDate *date = [NSDate zj_getDate:[NSString stringWithFormat:@"%@-%@", @(year), @(month)] format:@"yyyy-MM"];
    // 指定日历的算法(这里按公历)
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    // 只要给个时间给日历,就会帮你计算出来。
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit: NSCalendarUnitMonth forDate:date];
    return range.length;
}

#pragma mark - 获取 日期加上/减去某天数后的新日期
- (NSDate *)zj_getNewDate:(NSDate *)date addDays:(NSTimeInterval)days {
    // days 为正数时，表示几天之后的日期；负数表示几天之前的日期
    return [self dateByAddingTimeInterval:60 * 60 * 24 * days];
}

#pragma mark - 比较两个时间大小（可以指定比较级数，即按指定格式进行比较）
- (NSComparisonResult)zj_compare:(NSDate *)targetDate format:(NSString *)format {
    NSString *dateString1 = [NSDate zj_getDateString:self format:format];
    NSString *dateString2 = [NSDate zj_getDateString:targetDate format:format];
    NSDate *date1 = [NSDate zj_getDate:dateString1 format:format];
    NSDate *date2 = [NSDate zj_getDate:dateString2 format:format];
    if ([date1 compare:date2] == NSOrderedDescending) {
        return 1;
    } else if ([date1 compare:date2] == NSOrderedAscending) {
        return -1;
    } else {
        return 0;
    }
}

@end
