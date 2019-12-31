//
//  UIView+HNWKit.h
//  HNWKit
//
//  Created by Young on 2019/12/31.
//  Copyright © 2019 Young. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (HNWKit)

/** x */
@property (nonatomic) CGFloat hnw_minX;
@property (nonatomic) CGFloat hnw_midX;
@property (nonatomic) CGFloat hnw_maxX;

/** y */
@property (nonatomic) CGFloat hnw_minY;
@property (nonatomic) CGFloat hnw_midY;
@property (nonatomic) CGFloat hnw_maxY;

/** width */
@property (nonatomic) CGFloat hnw_width;

/** height */
@property (nonatomic) CGFloat hnw_height;

/** origin */
@property (nonatomic) CGPoint hnw_origin;

/** size */
@property (nonatomic) CGSize hnw_size;

@end

@interface UIView (HNWKitNibLoading)

/**
 从 Xib 实例化 UIView，默认 Xib 名称为类名，bundle 为 mainBundle
 */
+ (nullable instancetype)hnw_viewFromNib;

/**
 从 Xib 实例化 UIView
 
 @param nibName Xib 文件名
 */
+ (nullable instancetype)hnw_viewWithNibName:(NSString *)nibName;

/**
 从 Xib 实例化 UIView
 
 @param nibName Xib 文件名
 @param bundleOrNil 所在资源包，nil 时 默认为 mainBundle
 */
+ (nullable instancetype)hnw_viewWithNibName:(NSString *)nibName bundle:(nullable NSBundle *)bundleOrNil;

/**
 从 Xib 实例化 UIView
 
 @param nibName Xib 文件名
 @param bundleOrNil 所在资源包，nil 时 默认为 mainBundle
 @param index Xib 序列化后数组中对象下标
 */
+ (nullable instancetype)hnw_viewWithNibName:(NSString *)nibName bundle:(nullable NSBundle *)bundleOrNil index:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
