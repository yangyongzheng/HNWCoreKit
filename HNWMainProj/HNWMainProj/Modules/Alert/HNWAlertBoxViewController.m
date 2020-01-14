//
//  HNWAlertBoxViewController.m
//  HNWMainProj
//
//  Created by Young on 2020/1/14.
//  Copyright © 2020 Young. All rights reserved.
//

#import "HNWAlertBoxViewController.h"
#import "HNWLayoutContentView.h"
#import <objc/runtime.h>


@implementation UIView (HNWAlertBoxViewController)

static const void * UIViewAlertBoxViewControllerAssociationKey = &UIViewAlertBoxViewControllerAssociationKey;

- (void)setAlertBoxViewController:(HNWAlertBoxViewController * _Nullable)alertBoxViewController {
    objc_setAssociatedObject(self, UIViewAlertBoxViewControllerAssociationKey, alertBoxViewController, OBJC_ASSOCIATION_ASSIGN);
}

- (HNWAlertBoxViewController *)alertBoxViewController {
    return objc_getAssociatedObject(self, UIViewAlertBoxViewControllerAssociationKey);
}

@end



@interface HNWAlertBoxViewControllerTransitionProvider : NSObject <UIViewControllerAnimatedTransitioning>
+ (instancetype)presentProviderWithAnimationTransition:(HNWAlertAnimationTransition)animationTransition;
+ (instancetype)dismissProviderWithAnimationTransition:(HNWAlertAnimationTransition)animationTransition;
@end


@interface HNWAlertBoxViewController () <UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) UIView *alertView;
@property (nonatomic, strong) HNWLayoutContentView *layoutContentView;
/// [centerX, centerY, width, height]
@property (nonatomic, copy) NSArray<NSLayoutConstraint *> *alertViewConstraints;
@property (nonatomic) HNWAlertAnimationTransition presentAnimationTransition;
@property (nonatomic) HNWAlertAnimationTransition dismissAnimationTransition;
@end

@implementation HNWAlertBoxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBasicEnvironment];
}

- (void)dealloc {
    self.alertView.alertBoxViewController = nil;
}

#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    return [HNWAlertBoxViewControllerTransitionProvider presentProviderWithAnimationTransition:self.presentAnimationTransition];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [HNWAlertBoxViewControllerTransitionProvider dismissProviderWithAnimationTransition:self.dismissAnimationTransition];
}

#pragma mark - Public
+ (HNWAlertBoxViewController *)alertBoxViewControllerWithAlertView:(UIView *)alertView {
    if (alertView && [alertView isKindOfClass:[UIView class]]) {
        HNWAlertBoxViewController *viewController = [[HNWAlertBoxViewController alloc] init];
        viewController.alertView = alertView;
        alertView.alertBoxViewController = viewController;
        [viewController.view layoutIfNeeded]; // 调用该API初始化view
        return viewController;
    } else {
        return nil;
    }
}

- (void)showWithPresentingViewController:(UIViewController *)presentingViewController
                     animationTransition:(HNWAlertAnimationTransition)animationTransition
                              completion:(void (^)(void))completion {
    if (presentingViewController && [presentingViewController isKindOfClass:[UIViewController class]]) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        self.presentAnimationTransition = animationTransition;
        BOOL animated = (animationTransition != HNWAlertAnimationTransitionNone);
        [presentingViewController presentViewController:self animated:animated completion:completion];
    }
}

- (void)hideWithAnimationTransition:(HNWAlertAnimationTransition)animationTransition completion:(void (^)(void))completion {
    self.dismissAnimationTransition = animationTransition;
    BOOL animated = (animationTransition != HNWAlertAnimationTransitionNone);
    [self dismissViewControllerAnimated:animated completion:completion];
}

#pragma mark - Misc
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

#pragma mark - getter or setter
- (HNWLayoutContentView *)layoutContentView {
    if (!_layoutContentView) {
        _layoutContentView = [[HNWLayoutContentView alloc] initWithFrame:self.view.bounds];
        _layoutContentView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    }
    return _layoutContentView;
}

@end


@interface HNWAlertBoxViewControllerTransitionProvider ()
@property (nonatomic, getter=isPresentFlag) BOOL presentFlag;
@property (nonatomic) HNWAlertAnimationTransition animationTransition;
@end

@implementation HNWAlertBoxViewControllerTransitionProvider

#pragma mark - Public
+ (instancetype)presentProviderWithAnimationTransition:(HNWAlertAnimationTransition)animationTransition {
    HNWAlertBoxViewControllerTransitionProvider *provider = [[[self class] alloc] init];
    provider.presentFlag = YES;
    provider.animationTransition = animationTransition;
    return provider;
}

+ (instancetype)dismissProviderWithAnimationTransition:(HNWAlertAnimationTransition)animationTransition {
    HNWAlertBoxViewControllerTransitionProvider *provider = [[[self class] alloc] init];
    provider.presentFlag = NO;
    provider.animationTransition = animationTransition;
    return provider;
}

#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    if (self.isPresentFlag) {
        [self presentAnimationTransition:transitionContext];
    } else {
        [self dismissAnimationTransition:transitionContext];
    }
}

- (void)presentAnimationTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = [transitionContext containerView];
    HNWAlertBoxViewController *toController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CGRect finalFrame = [transitionContext finalFrameForViewController:toController];
    toController.view.frame = finalFrame;
    toController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [containerView addSubview:toController.view];
    [toController.view layoutIfNeeded];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    if (self.animationTransition == HNWAlertAnimationTransitionFade) {
        toController.layoutContentView.alpha = 0;
        [UIView animateWithDuration:duration animations:^{
            toController.layoutContentView.alpha = 1;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    } else if (self.animationTransition == HNWAlertAnimationTransitionSlideFromLeft && toController.alertViewConstraints.count == 4) {
        NSLayoutConstraint *centerXConstraint = toController.alertViewConstraints[0];
        NSLayoutConstraint *widthConstraint = toController.alertViewConstraints[2];
        centerXConstraint.constant = -finalFrame.size.width/2.0 - widthConstraint.constant;
        [toController.view layoutIfNeeded];
        centerXConstraint.constant = 0;
        [UIView animateWithDuration:duration animations:^{
            [toController.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    } else if (self.animationTransition == HNWAlertAnimationTransitionSlideFromRight && toController.alertViewConstraints.count == 4) {
        NSLayoutConstraint *centerXConstraint = toController.alertViewConstraints[0];
        NSLayoutConstraint *widthConstraint = toController.alertViewConstraints[2];
        centerXConstraint.constant = finalFrame.size.width/2.0 + widthConstraint.constant;
        [toController.view layoutIfNeeded];
        centerXConstraint.constant = 0;
        [UIView animateWithDuration:duration animations:^{
            [toController.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    } else {
        [transitionContext completeTransition:YES];
    }
}

- (void)dismissAnimationTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    HNWAlertBoxViewController *fromController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    CGRect initialFrame = [transitionContext initialFrameForViewController:fromController];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    if (self.animationTransition == HNWAlertAnimationTransitionFade) {
        [UIView animateWithDuration:duration animations:^{
            fromController.layoutContentView.alpha = 0;
        } completion:^(BOOL finished) {
            [fromController.view removeFromSuperview];
            [transitionContext completeTransition:YES];
        }];
    } else if (self.animationTransition == HNWAlertAnimationTransitionSlideFromLeft && fromController.alertViewConstraints.count == 4) {
        fromController.alertViewConstraints[0].constant = -CGRectGetWidth(initialFrame) / 2.0 - fromController.alertViewConstraints[2].constant;
        [UIView animateWithDuration:duration animations:^{
            [fromController.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            [fromController.view removeFromSuperview];
            [transitionContext completeTransition:YES];
        }];
    } else if (self.animationTransition == HNWAlertAnimationTransitionSlideFromRight && fromController.alertViewConstraints.count == 4) {
        fromController.alertViewConstraints[0].constant = CGRectGetWidth(initialFrame) / 2.0 + fromController.alertViewConstraints[2].constant;
        [UIView animateWithDuration:duration animations:^{
            [fromController.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            [fromController.view removeFromSuperview];
            [transitionContext completeTransition:YES];
        }];
    } else {
        [fromController.view removeFromSuperview];
        [transitionContext completeTransition:YES];
    }
}

@end
