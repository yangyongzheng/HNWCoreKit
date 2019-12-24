//
//  UIColor+HNWConstructor.m
//  HNWKit
//
//  Created by Young on 2019/12/24.
//  Copyright © 2019 Young. All rights reserved.
//

#import "UIColor+HNWConstructor.h"
#import "HNWAssertNotEmpty.h"

@implementation UIColor (HNWConstructor)

+ (UIColor *)hnw_randomColor {
    const CGFloat r = arc4random() % 256;
    const CGFloat g = arc4random() % 256;
    const CGFloat b = arc4random() % 256;
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];
}

+ (UIColor *)hnw_colorWithRGBAHexCode:(NSString *)rgbaHexCode {
    NSLog(@"%@ - %d", rgbaHexCode, [rgbaHexCode isEqualToString:@"0x001100"]);
    return [UIColor clearColor];
}

+ (UIColor *)hnw_colorWithARGBHexCode:(NSString *)argbHexCode {
    return [UIColor clearColor];
}

@end
