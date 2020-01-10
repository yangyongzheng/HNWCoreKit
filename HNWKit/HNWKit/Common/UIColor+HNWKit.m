//
//  UIColor+HNWKit.m
//  HNWKit
//
//  Created by Young on 2019/12/31.
//  Copyright © 2019 Young. All rights reserved.
//

#import "UIColor+HNWKit.h"
#import "HNWAssertNotEmpty.h"

@implementation UIColor (HNWKit)

#pragma mark - Public
+ (UIColor *)hnw_randomColor {
    const CGFloat r = arc4random() % 256;
    const CGFloat g = arc4random() % 256;
    const CGFloat b = arc4random() % 256;
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];
}

+ (BOOL)hnw_validateHexCode:(NSString *)hexCode {
    NSString *safeHexCode = [self hnw_privateFilterHexCode:hexCode];
    return [self hnw_privateValidateHexCode:safeHexCode];
}

+ (UIColor *)hnw_colorWithRGBAHexCode:(NSString *)rgbaHexCode {
    NSString *safeHexCode = [self hnw_privateFilterHexCode:rgbaHexCode];
    if ([self hnw_privateValidateHexCode:safeHexCode]) {
        return [self hnw_privateColorWithValidHexCode:safeHexCode isBeginAlpha:NO];
    } else {
        NSAssert(0, @"入参非法，颜色创建失败");
        return [UIColor clearColor];
    }
}

+ (UIColor *)hnw_colorWithARGBHexCode:(NSString *)argbHexCode {
    NSString *safeHexCode = [self hnw_privateFilterHexCode:argbHexCode];
    if ([self hnw_privateValidateHexCode:safeHexCode]) {
        return [self hnw_privateColorWithValidHexCode:safeHexCode isBeginAlpha:YES];
    } else {
        NSAssert(0, @"入参非法，颜色创建失败");
        return [UIColor clearColor];
    }
}

#pragma mark - Private
+ (NSString *)hnw_privateFilterHexCode:(NSString *)hexCode {
    if (HNWAssertStringNotEmpty(hexCode)) {
        NSString *safeHexCode = [hexCode copy];
        NSString *result = [safeHexCode stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
        if (HNWAssertStringNotEmpty(result)) {
            result = [result stringByReplacingOccurrencesOfString:@" " withString:@""];
            if (HNWAssertStringNotEmpty(result)) {
                if ([result hasPrefix:@"#"]) {
                    return result.length > 1 ? [result substringFromIndex:1] : nil;
                } else if ([result hasPrefix:@"0x"] || [result hasPrefix:@"0X"]) {
                    return result.length > 2 ? [result substringFromIndex:2] : nil;
                } else {
                    return result;
                }
            }
        }
    }
    return nil;
}

+ (BOOL)hnw_privateValidateHexCode:(NSString *)hexCode {
    if (HNWAssertStringNotEmpty(hexCode)) {
        NSString *regularExpression = @"^[0-9a-fA-F]{6}([0-9a-fA-F]{2})?$";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regularExpression];
        return [predicate evaluateWithObject:hexCode];
    } else {
        return NO;
    }
}

+ (UIColor *)hnw_privateColorWithValidHexCode:(NSString *)hexCode isBeginAlpha:(BOOL)isBeginAlpha {
    if (hexCode && [hexCode isKindOfClass:[NSString class]]) {
        NSString *rStr = nil, *gStr = nil, *bStr = nil, *aStr = nil;
        if (hexCode.length == 6) {
            aStr = @"FF";
            rStr = [hexCode substringWithRange:NSMakeRange(0, 2)];
            gStr = [hexCode substringWithRange:NSMakeRange(2, 2)];
            bStr = [hexCode substringWithRange:NSMakeRange(4, 2)];
        } else if (hexCode.length == 8) {
            if (isBeginAlpha) {
                aStr = [hexCode substringWithRange:NSMakeRange(0, 2)];
                rStr = [hexCode substringWithRange:NSMakeRange(2, 2)];
                gStr = [hexCode substringWithRange:NSMakeRange(4, 2)];
                bStr = [hexCode substringWithRange:NSMakeRange(6, 2)];
            } else {
                rStr = [hexCode substringWithRange:NSMakeRange(0, 2)];
                gStr = [hexCode substringWithRange:NSMakeRange(2, 2)];
                bStr = [hexCode substringWithRange:NSMakeRange(4, 2)];
                aStr = [hexCode substringWithRange:NSMakeRange(6, 2)];
            }
        }
        
        if (rStr && gStr && bStr && aStr) {
            unsigned int r, g, b, a;
            sscanf(rStr.UTF8String, "%X", &r);
            sscanf(gStr.UTF8String, "%X", &g);
            sscanf(bStr.UTF8String, "%X", &b);
            sscanf(aStr.UTF8String, "%X", &a);
            
            return [UIColor colorWithRed:(CGFloat)r/255.0
                                   green:(CGFloat)g/255.0
                                    blue:(CGFloat)b/255.0
                                   alpha:(CGFloat)a/255.0];
        }
    }
    return [UIColor clearColor];
}

@end
