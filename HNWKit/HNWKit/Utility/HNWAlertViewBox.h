//
//  HNWAlertViewBox.h
//  HNWKit
//
//  Created by Young on 2020/1/5.
//  Copyright © 2020 Young. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HNWAlertViewBox : UIView

@property (nonatomic, readonly, strong) UIView *backgroundShadowView;
@property (nonatomic, readonly, strong) UIView *alertViewContainer;

@property (nullable, nonatomic, strong) UIView *alertView;

- (instancetype)initWithFrame:(CGRect)frame alertView:(nullable UIView *)alertView;

@end

NS_ASSUME_NONNULL_END
