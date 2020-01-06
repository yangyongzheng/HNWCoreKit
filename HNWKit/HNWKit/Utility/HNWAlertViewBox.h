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

- (instancetype)initWithFrame:(CGRect)frame alertView:(UIView *)alertView;

@property (nonatomic, readonly, strong) UIView *backgroundShadowView;
@property (nonatomic, readonly, strong) UIView *alertViewContainer;
@property (nonatomic, readonly, strong) UIView *alertView;

@end

NS_ASSUME_NONNULL_END
