//
//  HNWDateManager.m
//  HNWKit
//
//  Created by Young on 2019/12/28.
//  Copyright © 2019 Young. All rights reserved.
//

#import "HNWDateManager.h"

@implementation HNWDateManager

+ (NSCalendar *)gregorianCalendar {
    static NSCalendar *calendar = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    });
    calendar.timeZone = [self chineseTimeZone];
    calendar.locale = [self chineseSimplifiedLocale];
    return calendar;
}

+ (NSTimeZone *)chineseTimeZone {
    static NSTimeZone *timeZone = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        timeZone = [NSTimeZone timeZoneForSecondsFromGMT:28800];
    });
    return timeZone;
}

+ (NSLocale *)chineseSimplifiedLocale {
    static NSLocale *locale = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        locale = [NSLocale localeWithLocaleIdentifier:@"zh_Hans_CN"];
    });
    return locale;
}

+ (NSLocale *)americanEnglishLocale {
    static NSLocale *locale = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
    });
    return locale;
}

+ (NSDateFormatter *)defaultDateFormatter {
    static NSDateFormatter *dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
    });
    dateFormatter.calendar = [self gregorianCalendar];
    dateFormatter.timeZone = [self chineseTimeZone];
    dateFormatter.locale = [self chineseSimplifiedLocale];
    dateFormatter.dateFormat = HNWDateFormatterLongStyle;
    return dateFormatter;
}

+ (NSString *)stringFromSeconds:(NSTimeInterval)seconds dateFormat:(NSString *)dateFormat {
    if (dateFormat && [dateFormat isKindOfClass:[NSString class]] && dateFormat.length > 0) {
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:seconds];
        if (date) {
            NSDateFormatter *formatter = [self defaultDateFormatter];
            formatter.dateFormat = dateFormat;
            return [formatter stringFromDate:date];
        }
    }
    return nil;
}

+ (NSString *)stringFromMilliseconds:(NSTimeInterval)milliseconds dateFormat:(NSString *)dateFormat {
    return [self stringFromSeconds:milliseconds/1000.0 dateFormat:dateFormat];
}

+ (BOOL)isDate:(NSDate *)date inSameDayAsDate:(NSDate *)toDate {
    if (date && [date isKindOfClass:[NSDate class]] && toDate && [toDate isKindOfClass:[NSDate class]]) {
        return [HNWDateManager.gregorianCalendar isDate:date inSameDayAsDate:toDate];
    }
    return NO;
}

@end
