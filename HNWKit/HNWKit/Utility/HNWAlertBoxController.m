//
//  HNWAlertBoxController.m
//  HNWKit
//
//  Created by Young on 2020/1/7.
//  Copyright © 2020 Young. All rights reserved.
//

#import "HNWAlertBoxController.h"
#import "HNWAlertViewBox.h"
#import <objc/runtime.h>

@interface HNWAlertBoxControllerTransitionAnimator : NSObject <UIViewControllerAnimatedTransitioning>
+ (instancetype)presentTransitionAnimator:(HNWAlertAnimationTransition)animationTransition;
+ (instancetype)dismissTransitionAnimator:(HNWAlertAnimationTransition)animationTransition;
@end


@interface HNWAlertBoxController () <UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) HNWAlertViewBox *alertViewBox;
@property (nonatomic) HNWAlertAnimationTransition presentAnimationTransition;
@property (nonatomic) HNWAlertAnimationTransition dismissAnimationTransition;
@end

@implementation HNWAlertBoxController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupDefaultConfiguration];
}

- (void)dealloc {
    self.alertViewBox.alertView.alertBoxController = nil;
}

#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    return [HNWAlertBoxControllerTransitionAnimator presentTransitionAnimator:self.presentAnimationTransition];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [HNWAlertBoxControllerTransitionAnimator dismissTransitionAnimator:self.dismissAnimationTransition];
}

#pragma mark - Public
+ (instancetype)boxControllerWithAlertView:(UIView *)alertView {
    if (alertView && [alertView isKindOfClass:[UIView class]]) {
        HNWAlertBoxController *vc = [[[self class] alloc] init];
        alertView.alertBoxController = vc;
        vc.alertViewBox = [[HNWAlertViewBox alloc] initWithFrame:UIScreen.mainScreen.bounds alertView:alertView];
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
    if (self.alertViewBox) {
        self.alertViewBox.frame = self.view.bounds;
        self.alertViewBox.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:self.alertViewBox];
    }
}

@end



@interface HNWAlertBoxControllerTransitionAnimator ()
@property (nonatomic) HNWAlertAnimationTransition animationTransition;
@property (nonatomic, getter=isPresentFlag) BOOL presentFlag;
@end

@implementation HNWAlertBoxControllerTransitionAnimator

static const double HNWAlertBoxControllerTransitionDuration = 0.25;

+ (instancetype)presentTransitionAnimator:(HNWAlertAnimationTransition)animationTransition {
    HNWAlertBoxControllerTransitionAnimator *animator = [[[self class] alloc] init];
    animator.animationTransition = animationTransition;
    animator.presentFlag = YES;
    return animator;
}

+ (instancetype)dismissTransitionAnimator:(HNWAlertAnimationTransition)animationTransition {
    HNWAlertBoxControllerTransitionAnimator *animator = [[[self class] alloc] init];
    animator.animationTransition = animationTransition;
    animator.presentFlag = NO;
    return animator;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return HNWAlertBoxControllerTransitionDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    if (self.isPresentFlag) {
        [self presentAnimateTransition:transitionContext];
    } else {
        [self dismissAnimateTransition:transitionContext];
    }
}

- (void)presentAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    HNWAlertBoxController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CGRect visibleFrame = [transitionContext initialFrameForViewController:fromVC]; // 初始可见区域
    CGRect visibleBounds = CGRectMake(0, 0, CGRectGetWidth(visibleFrame), CGRectGetHeight(visibleFrame));
    [containerView addSubview:toVC.view];
    toVC.view.frame = visibleBounds;
    [toVC.view layoutIfNeeded];
    // 开始动画
    switch (self.animationTransition) {
        case HNWAlertAnimationTransitionFade: {
            toVC.alertViewBox.alpha = 0;
            [UIView animateWithDuration:HNWAlertBoxControllerTransitionDuration animations:^{
                toVC.alertViewBox.alpha = 1;
            } completion:^(BOOL finished) {
                [transitionContext completeTransition:YES];
            }];
            break;
        }
            
        case HNWAlertAnimationTransitionSlideFromLeft: {
            __block CGRect boxFrame = toVC.alertViewBox.alertViewContainer.frame;
            boxFrame.origin.x = -CGRectGetWidth(boxFrame);
            toVC.alertViewBox.alertViewContainer.frame = boxFrame;
            [UIView animateWithDuration:HNWAlertBoxControllerTransitionDuration animations:^{
                boxFrame.origin.x = 0;
                toVC.alertViewBox.alertViewContainer.frame = boxFrame;
            } completion:^(BOOL finished) {
                [transitionContext completeTransition:YES];
            }];
            break;
        }
            
        case HNWAlertAnimationTransitionSlideFromRight: {
            __block CGRect boxFrame = toVC.alertViewBox.alertViewContainer.frame;
            boxFrame.origin.x = CGRectGetWidth(boxFrame);
            toVC.alertViewBox.alertViewContainer.frame = boxFrame;
            [UIView animateWithDuration:HNWAlertBoxControllerTransitionDuration animations:^{
                boxFrame.origin.x = 0;
                toVC.alertViewBox.alertViewContainer.frame = boxFrame;
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
    HNWAlertBoxController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    switch (self.animationTransition) {
        case HNWAlertAnimationTransitionFade: {
            [UIView animateWithDuration:HNWAlertBoxControllerTransitionDuration animations:^{
                fromVC.alertViewBox.alpha = 0;
            } completion:^(BOOL finished) {
                [fromVC.view removeFromSuperview];
                [transitionContext completeTransition:YES];
            }];
            break;
        }
            
        case HNWAlertAnimationTransitionSlideFromLeft: {
            [UIView animateWithDuration:HNWAlertBoxControllerTransitionDuration animations:^{
                CGRect boxFrame = fromVC.alertViewBox.alertViewContainer.frame;
                boxFrame.origin.x = -CGRectGetWidth(boxFrame);
                fromVC.alertViewBox.alertViewContainer.frame = boxFrame;
            } completion:^(BOOL finished) {
                [fromVC.view removeFromSuperview];
                [transitionContext completeTransition:YES];
            }];
            break;
        }
            
        case HNWAlertAnimationTransitionSlideFromRight: {
            [UIView animateWithDuration:HNWAlertBoxControllerTransitionDuration animations:^{
                CGRect boxFrame = fromVC.alertViewBox.alertViewContainer.frame;
                boxFrame.origin.x = CGRectGetWidth(boxFrame);
                fromVC.alertViewBox.alertViewContainer.frame = boxFrame;
            } completion:^(BOOL finished) {
                [fromVC.view removeFromSuperview];
                [transitionContext completeTransition:YES];
            }];
            break;
        }
            
        default: {
            [fromVC.view removeFromSuperview];
            [transitionContext completeTransition:YES];
            break;
        }
    }
}

@end



@implementation UIView (HNWAlertBoxController)

static const void * const UIViewAlertBoxControllerAssociationKey = (void *)&UIViewAlertBoxControllerAssociationKey;

- (void)setAlertBoxController:(HNWAlertBoxController *)alertBoxController {
    objc_setAssociatedObject(self, UIViewAlertBoxControllerAssociationKey, alertBoxController, OBJC_ASSOCIATION_ASSIGN);
}

- (HNWAlertBoxController *)alertBoxController {
    return objc_getAssociatedObject(self, UIViewAlertBoxControllerAssociationKey);
}

@end
