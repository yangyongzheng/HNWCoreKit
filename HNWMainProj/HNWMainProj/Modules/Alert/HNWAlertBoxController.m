//
//  HNWAlertBoxController.m
//  HNWMainProj
//
//  Created by Young on 2020/1/12.
//  Copyright © 2020 Young. All rights reserved.
//

#import "HNWAlertBoxController.h"
#import "HNWLayoutContentView.h"

@interface HNWViewControllerAlertTransitionProvider : NSObject <UIViewControllerAnimatedTransitioning>

@end

@implementation HNWViewControllerAlertTransitionProvider

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
}

@end


@interface HNWAlertBoxController () <UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) UIView *alertView;
@property (nonatomic, strong) HNWLayoutContentView *layoutContentView;
@property (nonatomic, copy) NSArray<NSLayoutConstraint *> *alertViewConstraints;
@property (nonatomic, strong) HNWViewControllerAlertTransitionProvider *alertTransitionProvider;
@end

@implementation HNWAlertBoxController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBasicEnvironment];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    return [[HNWViewControllerAlertTransitionProvider alloc] init];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[HNWViewControllerAlertTransitionProvider alloc] init];
}

+ (HNWAlertBoxController *)alertBoxControllerWithAlertView:(UIView *)alertView {
    if (alertView && [alertView isKindOfClass:[UIView class]]) {
        HNWAlertBoxController *viewController = [[HNWAlertBoxController alloc] init];
        viewController.alertView = alertView;
        [viewController.view layoutIfNeeded]; // 调用该API初始化view
        return viewController;
    } else {
        return nil;
    }
}

- (void)setupBasicEnvironment {
    self.view.backgroundColor = UIColor.clearColor;
    [self.view addSubview:self.layoutContentView];
    if (self.alertView) {
        [self.layoutContentView.contentView addSubview:self.alertView];
        [self addConstraintsForAlertView];
    }
    self.transitioningDelegate = self;
}

- (void)addConstraintsForAlertView {
    self.alertView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *centerX = HNWLayoutConstraintLiteMaker(self.alertView, NSLayoutAttributeCenterX, self.alertView.superview, NSLayoutAttributeCenterX, 0);
    NSLayoutConstraint *centerY = HNWLayoutConstraintLiteMaker(self.alertView, NSLayoutAttributeCenterY, self.alertView.superview, NSLayoutAttributeCenterY, 0);
    NSLayoutConstraint *width = HNWLayoutConstraintLiteMaker(self.alertView, NSLayoutAttributeWidth, nil, NSLayoutAttributeNotAnAttribute, self.alertView.frame.size.width);
    NSLayoutConstraint *height = HNWLayoutConstraintLiteMaker(self.alertView, NSLayoutAttributeHeight, nil, NSLayoutAttributeNotAnAttribute, self.alertView.frame.size.height);
    self.alertViewConstraints = @[centerX, centerY, width, height];
    [NSLayoutConstraint activateConstraints:self.alertViewConstraints];
}

- (HNWLayoutContentView *)layoutContentView {
    if (!_layoutContentView) {
        _layoutContentView = [[HNWLayoutContentView alloc] initWithFrame:self.view.bounds];
        _layoutContentView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    }
    return _layoutContentView;
}

@end
