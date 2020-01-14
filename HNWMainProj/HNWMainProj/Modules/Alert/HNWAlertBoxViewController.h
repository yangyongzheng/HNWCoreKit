//
//  HNWAlertBoxViewController.h
//  HNWMainProj
//
//  Created by Young on 2020/1/14.
//  Copyright © 2020 Young. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, HNWAlertAnimationTransition) {
    HNWAlertAnimationTransitionNone = 0,
    HNWAlertAnimationTransitionFade,
    HNWAlertAnimationTransitionSlideFromLeft,
    HNWAlertAnimationTransitionSlideFromRight
};

@interface HNWAlertBoxViewController : UIViewController

+ (nullable HNWAlertBoxViewController *)alertBoxViewControllerWithAlertView:(UIView *)alertView;

- (void)showWithPresentingViewController:(UIViewController *)presentingViewController
                     animationTransition:(HNWAlertAnimationTransition)animationTransition
                              completion:(void (^ _Nullable)(void))completion;

- (void)hideWithAnimationTransition:(HNWAlertAnimationTransition)animationTransition completion:(void (^ _Nullable)(void))completion;

@end


@interface UIView (HNWAlertBoxViewController)
@property (nullable, nonatomic, readonly, weak) HNWAlertBoxViewController *alertBoxViewController;
@end

NS_ASSUME_NONNULL_END
