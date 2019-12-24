//
//  UIColor+HNWConstructor.h
//  HNWKit
//
//  Created by Young on 2019/12/24.
//  Copyright © 2019 Young. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HNWKitDefines.h"

NS_ASSUME_NONNULL_BEGIN

/** 根据RGBA/ARGB 16进制数创建颜色 */
#define HNWColorRGBAHexInt(hexInt) [UIColor hnw_colorWithRGBAHexCode:@HNWColorHexCodeFromHexInt(hexInt)]
#define HNWColorARGBHexInt(hexInt) [UIColor hnw_colorWithARGBHexCode:@HNWColorHexCodeFromHexInt(hexInt)]

/** 根据RGBA/ARGB 16进制字符串创建颜色 */
#define HNWColorRGBAHexCode(hexCode) [UIColor hnw_colorWithRGBAHexCode:hexCode]
#define HNWColorARGBHexCode(hexCode) [UIColor hnw_colorWithARGBHexCode:hexCode]

/** 16进制数转字符串 */
#define HNWColorHexCodeFromHexInt(hexInt) HNWKitStringizing(hexInt)

@interface UIColor (HNWConstructor)

+ (UIColor *)hnw_randomColor;

+ (UIColor *)hnw_colorWithRGBAHexCode:(NSString *)rgbaHexCode;
+ (UIColor *)hnw_colorWithARGBHexCode:(NSString *)argbHexCode;

@end

NS_ASSUME_NONNULL_END
