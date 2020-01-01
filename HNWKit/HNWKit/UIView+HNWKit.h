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

NS_ASSUME_NONNULL_END
