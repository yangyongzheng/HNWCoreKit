//
//  HNWLayoutContentView.h
//  HNWMainProj
//
//  Created by Young on 2020/1/12.
//  Copyright © 2020 Young. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HNWLayoutContentView : UIView

@property (nonatomic, readonly, strong) UIView *backgroundView;
@property (nonatomic, readonly, strong) UIView *contentView;

@property (nonatomic) CGFloat bottomLayoutGuideHeight;

- (void)setBottomLayoutGuideHeight:(CGFloat)bottomLayoutGuideHeight
                   animateDuration:(NSTimeInterval)animateDuration;

@end

NS_ASSUME_NONNULL_END
