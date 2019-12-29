//
//  HNWDateManager.h
//  HNWKit
//
//  Created by Young on 2019/12/28.
//  Copyright © 2019 Young. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 日期格式化
 
 年: yyyy
 月: M 9, MM 09, MMM Sept, MMMM September, MMMMM S
 日: d 表示 Day of the month, 范围1...2; D 表示 Day of year, 范围1...3; F 表示 Day of Week in Month.
 时: h [1 12], H [0 23], Use hh or HH for zero padding. K [0 11], k [1 24], Use KK or kk for zero padding.
 分: m/mm Use one or two for zero padding.
 秒: s/ss Use one or two for zero padding.
 毫秒: SSS
 */
static NSString * const HNWDateFormatterShortStyle = @"yyyy-MM-dd";
static NSString * const HNWDateFormatterLongStyle = @"yyyy-MM-dd HH:mm:ss";
static NSString * const HNWDateFormatterFullStyle = @"yyyy-MM-dd HH:mm:ss.SSS";
static NSString * const HNWDateFormatterForeignStyle = @"MMM dd, yyyy h:mm:ss a";

@interface HNWDateManager : NSObject

/** 公历日历，单例对象。中国北京时区，中国简体中文本地化 */
@property (class, readonly, strong) NSCalendar *gregorianCalendar;

/** 中国北京时区(东八区)，单例对象 */
@property (class, readonly, strong) NSTimeZone *chineseTimeZone;

/** 中国简体中文本地化，单例对象 */
@property (class, readonly, strong) NSLocale *chineseSimplifiedLocale;

/** 美国英语本地化，单例对象 */
@property (class, readonly, strong) NSLocale *americanEnglishLocale;

/** 日期格式化单例对象。默认为公历日历、中国北京时区、中国简体中文本地化、日期格式为 HNWDateFormatterLongStyle */
@property (class, readonly, strong) NSDateFormatter *defaultDateFormatter;

/** 时间戳(单位秒)转字符串 */
+ (nullable NSString *)stringFromSeconds:(NSTimeInterval)seconds dateFormat:(NSString *)dateFormat;

/** 时间戳(单位毫秒)转字符串 */
+ (nullable NSString *)stringFromMilliseconds:(NSTimeInterval)milliseconds dateFormat:(NSString *)dateFormat;

/** 判断两个日期是否是同一天 */
+ (BOOL)isDate:(NSDate *)date inSameDayAsDate:(NSDate *)toDate;

@end

NS_ASSUME_NONNULL_END
