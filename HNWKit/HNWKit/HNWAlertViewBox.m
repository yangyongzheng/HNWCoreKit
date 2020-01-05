//
//  HNWAlertViewBox.m
//  HNWKit
//
//  Created by Young on 2020/1/5.
//  Copyright © 2020 Young. All rights reserved.
//

#import "HNWAlertViewBox.h"

@implementation HNWAlertViewBox

@synthesize backgroundShadowView = _backgroundShadowView;
@synthesize alertViewContainer = _alertViewContainer;

- (instancetype)initWithFrame:(CGRect)frame alertView:(UIView *)alertView {
    self = [super initWithFrame:frame];
    if (self) {
        if (alertView && [alertView isKindOfClass:[UIView class]]) {
            _alertView = alertView;
        } else {
            _alertView = nil;
        }
        [self addSubview:self.backgroundShadowView];
        [self addSubview:self.alertViewContainer];
        if (self.alertView) {
            [self.alertViewContainer addSubview:self.alertView];
            self.alertView.center = CGPointMake(CGRectGetMidX(self.alertViewContainer.bounds), CGRectGetMidY(self.alertViewContainer.bounds));
            self.alertView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
        }
    }
    return self;
}

- (UIView *)backgroundShadowView {
    if (!_backgroundShadowView) {
        _backgroundShadowView = [[UIView alloc] initWithFrame:self.bounds];
        _backgroundShadowView.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.6];
        _backgroundShadowView.userInteractionEnabled = NO;
        _backgroundShadowView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    }
    return _backgroundShadowView;
}

- (UIView *)alertViewContainer {
    if (!_alertViewContainer) {
        _alertViewContainer = [[UIView alloc] initWithFrame:self.bounds];
        _alertViewContainer.backgroundColor = [UIColor clearColor];
        _alertViewContainer.clipsToBounds = YES;
        _alertViewContainer.userInteractionEnabled = YES;
        _alertViewContainer.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    }
    return _alertViewContainer;
}

@end
