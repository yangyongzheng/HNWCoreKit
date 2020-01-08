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

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupDefaultUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setupDefaultUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame alertView:(UIView *)alertView {
    if (self = [super initWithFrame:frame]) {
        [self setupDefaultUI];
        self.alertView = alertView;
    }
    return self;
}

- (void)setupDefaultUI {
    [self addSubview:self.backgroundShadowView];
    [self addSubview:self.alertViewContainer];
}

- (void)resetAlertView {
    NSArray *subviews = self.alertViewContainer.subviews;
    for (UIView *view in subviews) {
        [view removeFromSuperview];
    }
    if (self.alertView) {
        [self.alertViewContainer addSubview:self.alertView];
        self.alertView.center = CGPointMake(CGRectGetMidX(self.alertViewContainer.bounds), CGRectGetMidY(self.alertViewContainer.bounds));
        self.alertView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
    }
}

- (void)setAlertView:(UIView *)alertView {
    if (alertView && [alertView isKindOfClass:[UIView class]]) {
        _alertView = alertView;
    } else {
        _alertView = nil;
    }
    [self resetAlertView];
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
