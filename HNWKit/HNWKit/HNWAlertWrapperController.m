//
//  HNWAlertWrapperController.m
//  HNWKit
//
//  Created by Young on 2020/1/1.
//  Copyright © 2020 Young. All rights reserved.
//

#import "HNWAlertWrapperController.h"
#import <objc/runtime.h>

@interface HNWAlertWrapperControllerTransitionAnimator : NSObject <UIViewControllerAnimatedTransitioning>
+ (instancetype)presentTransitionAnimator:(HNWAlertAnimationTransition)animationTransition;
+ (instancetype)dismissTransitionAnimator:(HNWAlertAnimationTransition)animationTransition;
@end


@interface HNWAlertWrapperController () <UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) UIView *backgroundShadowView;
@property (nonatomic, strong) UIView *alertViewBox;
@property (nonatomic, strong) UIView *alertView;
@property (nonatomic) HNWAlertAnimationTransition presentAnimationTransition;
@property (nonatomic) HNWAlertAnimationTransition dismissAnimationTransition;
@end

@implementation HNWAlertWrapperController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupDefaultConfiguration];
}

- (void)dealloc {
    _alertView.alertWrapperController = nil;
}

#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    return [HNWAlertWrapperControllerTransitionAnimator presentTransitionAnimator:self.presentAnimationTransition];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [HNWAlertWrapperControllerTransitionAnimator dismissTransitionAnimator:self.dismissAnimationTransition];
}

#pragma mark - Public
+ (instancetype)wrapperControllerWithAlertView:(UIView *)alertView {
    if (alertView && [alertView isKindOfClass:[UIView class]]) {
        HNWAlertWrapperController *vc = [[[self class] alloc] init];
        vc.alertView = alertView;
        alertView.alertWrapperController = vc;
        return vc;
    } else {
        return nil;
    }
}

- (void)showWithPresentingViewController:(UIViewController *)presentingViewController
                     animationTransition:(HNWAlertAnimationTransition)animationTransition
                              completion:(void (^)(void))completion {
    if (presentingViewController && [presentingViewController isKindOfClass:[UIViewController class]]) {
        self.presentAnimationTransition = animationTransition;
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        self.transitioningDelegate = self;
        [presentingViewController presentViewController:self
                                               animated:animationTransition!=HNWAlertAnimationTransitionNone
                                             completion:completion];
    }
}

- (void)hideWithAnimationTransition:(HNWAlertAnimationTransition)animationTransition
                         completion:(void (^)(void))completion {
    self.dismissAnimationTransition = animationTransition;
    [self dismissViewControllerAnimated:animationTransition!=HNWAlertAnimationTransitionNone
                             completion:completion];
}

#pragma mark - Misc
- (void)setupDefaultConfiguration {
    self.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.backgroundShadowView];
    [self.view addSubview:self.alertViewBox];
    if (self.alertView) {
        [self.alertViewBox addSubview:self.alertView];
        self.alertView.center = CGPointMake(CGRectGetMidX(self.alertViewBox.bounds), CGRectGetMidY(self.alertViewBox.bounds));
        self.alertView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
    }
}

#pragma mark - getter or setter
- (UIView *)backgroundShadowView {
    if (!_backgroundShadowView) {
        _backgroundShadowView = [[UIView alloc] initWithFrame:self.view.bounds];
        _backgroundShadowView.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.6];
        _backgroundShadowView.userInteractionEnabled = NO;
        _backgroundShadowView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    }
    return _backgroundShadowView;
}

- (UIView *)alertViewBox {
    if (!_alertViewBox) {
        _alertViewBox = [[UIView alloc] initWithFrame:self.view.bounds];
        _alertViewBox.backgroundColor = [UIColor clearColor];
        _alertViewBox.clipsToBounds = YES;
        _alertViewBox.userInteractionEnabled = YES;
        _alertViewBox.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    }
    return _alertViewBox;
}

@end



@interface HNWAlertWrapperControllerTransitionAnimator ()
@property (nonatomic) HNWAlertAnimationTransition animationTransition;
@property (nonatomic, getter=isPresentTransitionAnimator) BOOL presentTransitionAnimator;
@end

@implementation HNWAlertWrapperControllerTransitionAnimator

static const double HNWAlertWrapperControllerTransitionDuration = 0.3;

+ (instancetype)presentTransitionAnimator:(HNWAlertAnimationTransition)animationTransition {
    HNWAlertWrapperControllerTransitionAnimator *animator = [[[self class] alloc] init];
    animator.animationTransition = animationTransition;
    animator.presentTransitionAnimator = YES;
    return animator;
}

+ (instancetype)dismissTransitionAnimator:(HNWAlertAnimationTransition)animationTransition {
    HNWAlertWrapperControllerTransitionAnimator *animator = [[[self class] alloc] init];
    animator.animationTransition = animationTransition;
    animator.presentTransitionAnimator = NO;
    return animator;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return HNWAlertWrapperControllerTransitionDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    if (self.isPresentTransitionAnimator) {
        [self presentAnimateTransition:transitionContext];
    } else {
        [self dismissAnimateTransition:transitionContext];
    }
}

- (void)presentAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    HNWAlertWrapperController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CGRect visibleFrame = [transitionContext initialFrameForViewController:fromVC]; // 初始可见区域
    CGRect visibleBounds = CGRectMake(0, 0, CGRectGetWidth(visibleFrame), CGRectGetHeight(visibleFrame));
    [containerView addSubview:toVC.view];
    toVC.view.frame = visibleBounds;
    [toVC.view layoutIfNeeded];
    switch (self.animationTransition) {
        case HNWAlertAnimationTransitionFade: {
            toVC.alertViewBox.alpha = 0;
            [UIView animateWithDuration:HNWAlertWrapperControllerTransitionDuration animations:^{
                toVC.alertViewBox.alpha = 1;
            } completion:^(BOOL finished) {
                [transitionContext completeTransition:YES];
            }];
            break;
        }
            
        case HNWAlertAnimationTransitionSlideFromLeft: {
            __block CGRect boxFrame = toVC.alertViewBox.frame;
            boxFrame.origin.x = -CGRectGetWidth(boxFrame);
            toVC.alertViewBox.frame = boxFrame;
            [UIView animateWithDuration:HNWAlertWrapperControllerTransitionDuration animations:^{
                boxFrame.origin.x = 0;
                toVC.alertViewBox.frame = boxFrame;
            } completion:^(BOOL finished) {
                [transitionContext completeTransition:YES];
            }];
            break;
        }
            
        case HNWAlertAnimationTransitionSlideFromRight: {
            __block CGRect boxFrame = toVC.alertViewBox.frame;
            boxFrame.origin.x = CGRectGetWidth(boxFrame);
            toVC.alertViewBox.frame = boxFrame;
            [UIView animateWithDuration:HNWAlertWrapperControllerTransitionDuration animations:^{
                boxFrame.origin.x = 0;
                toVC.alertViewBox.frame = boxFrame;
            } completion:^(BOOL finished) {
                [transitionContext completeTransition:YES];
            }];
            break;
        }
            
        default: {
            [transitionContext completeTransition:YES];
            break;
        }
    }
}

- (void)dismissAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
}

@end



@implementation UIView (HNWAlertWrapperController)

static const void * const UIViewAlertWrapperControllerAssociationKey = (void *)&UIViewAlertWrapperControllerAssociationKey;

- (void)setAlertWrapperController:(HNWAlertWrapperController *)alertWrapperController {
    objc_setAssociatedObject(self, UIViewAlertWrapperControllerAssociationKey, alertWrapperController, OBJC_ASSOCIATION_ASSIGN);
}

- (HNWAlertWrapperController *)alertWrapperController {
    return objc_getAssociatedObject(self, UIViewAlertWrapperControllerAssociationKey);
}

@end
