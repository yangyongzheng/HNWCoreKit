//
//  UIColor+HNWKit.h
//  HNWKit
//
//  Created by Young on 2019/12/31.
//  Copyright © 2019 Young. All rights reserved.
//

#import "HNWKitDefines.h"

NS_ASSUME_NONNULL_BEGIN

/** 根据RGBA/ARGB 16进制数创建颜色 */
#define HNWColorWithRGBAHexInt(hexInt) [UIColor hnw_colorWithRGBAHexCode:HNWKitStringConverter(hexInt)]
#define HNWColorWithARGBHexInt(hexInt) [UIColor hnw_colorWithARGBHexCode:HNWKitStringConverter(hexInt)]

/** 根据RGBA/ARGB 16进制字符串创建颜色 */
#define HNWColorWithRGBAHexCode(hexCode) [UIColor hnw_colorWithRGBAHexCode:hexCode]
#define HNWColorWithARGBHexCode(hexCode) [UIColor hnw_colorWithARGBHexCode:hexCode]

@interface UIColor (HNWKit)

/** 随机色 */
+ (UIColor *)hnw_randomColor;

/** 校验是否为有效可解析(RGB/RGBA/ARGB)16进制字符串 */
+ (BOOL)hnw_validateHexCode:(NSString *)hexCode;

/** 根据 RGB/RGBA 16进制字符串创建颜色 */
+ (UIColor *)hnw_colorWithRGBAHexCode:(NSString *)rgbaHexCode;

/** 根据 RGB/ARGB 16进制字符串创建颜色 */
+ (UIColor *)hnw_colorWithARGBHexCode:(NSString *)argbHexCode;

@end

NS_ASSUME_NONNULL_END
