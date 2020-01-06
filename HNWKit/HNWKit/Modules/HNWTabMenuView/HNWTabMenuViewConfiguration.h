//
//  HNWTabMenuViewConfiguration.h
//  HNWKit
//
//  Created by Young on 2019/12/25.
//  Copyright © 2019 Young. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/** 表示indicatorView的宽度等于选择item标题宽度 */
extern const CGFloat HNWTabMenuIndicatorWidthAutomaticDimension;

@interface HNWTabMenuViewConfiguration : NSObject

/** item最小宽度，默认值 0 */
@property (nonatomic) CGFloat minimumItemWidth;
/** item之间的间距，最小值为1，默认值 1 */
@property (nonatomic) CGFloat itemSpacing;

/** 默认值 21，HNWTabMenuIndicatorWidthAutomaticDimension 表示和选中的Item标题等宽 */
@property (nonatomic) CGFloat indicatorWidth;
/** 默认值 3 */
@property (nonatomic) CGFloat indicatorHeight;

/** 默认值 0.5 */
@property (nonatomic) CGFloat topSeparatorHeight;
/** 默认值 0.5 */
@property (nonatomic) CGFloat bottomSeparatorHeight;
/** 仅有 top, left, right 会生效，默认值 UIEdgeInsetsZero */
@property (nonatomic) UIEdgeInsets topSeparatorInsets;
/** 仅有 left, bottom, right 会生效，默认值 UIEdgeInsetsZero */
@property (nonatomic) UIEdgeInsets bottomSeparatorInsets;

// 标题颜色、字体配置
@property (null_resettable, nonatomic, strong) UIColor *selectedTitleColor;
@property (null_resettable, nonatomic, strong) UIColor *unselectedTitleColor;
@property (null_resettable, nonatomic, strong) UIFont *selectedTitleFont;
@property (null_resettable, nonatomic, strong) UIFont *unselectedTitleFont;

@end

NS_ASSUME_NONNULL_END
