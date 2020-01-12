//
//  HNWTransitionContainer.h
//  HNWKit
//
//  Created by Young on 2020/1/11.
//  Copyright © 2020 Young. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HNWTransitionContainer : UIView
@property (nonatomic, readonly, strong) UIView *backgroundView;
@property (nonatomic, readonly, strong) UIView *separatorView;
@property (nonatomic, readonly, strong) UIView *keyboardLayoutAlignmentView;
@property (nonatomic, readonly, strong) UIView *containerView;

@property (nonatomic) CGFloat keyboardLayoutAlignmentViewHeight;
@end

NS_ASSUME_NONNULL_END
