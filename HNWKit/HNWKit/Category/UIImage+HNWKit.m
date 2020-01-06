//
//  UIImage+HNWKit.m
//  HNWKit
//
//  Created by Young on 2020/1/5.
//  Copyright © 2020 Young. All rights reserved.
//

#import "UIImage+HNWKit.h"

@implementation UIImage (HNWKit)

+ (instancetype)imageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(size, NO, UIScreen.mainScreen.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
