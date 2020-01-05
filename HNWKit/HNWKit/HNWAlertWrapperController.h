//
//  HNWAlertWrapperController.h
//  HNWKit
//
//  Created by Young on 2020/1/1.
//  Copyright © 2020 Young. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, HNWAlertAnimationTransition) {
    HNWAlertAnimationTransitionNone,
    HNWAlertAnimationTransitionFade,
    HNWAlertAnimationTransitionSlideFromLeft,
    HNWAlertAnimationTransitionSlideFromRight,
};

@interface HNWAlertWrapperController : UIViewController

+ (nullable instancetype)wrapperControllerWithAlertView:(UIView *)alertView;

- (void)showWithPresentingViewController:(UIViewController *)presentingViewController
                     animationTransition:(HNWAlertAnimationTransition)animationTransition
                              completion:(void (^ _Nullable)(void))completion;

- (void)hideWithAnimationTransition:(HNWAlertAnimationTransition)animationTransition
                         completion:(void (^ _Nullable)(void))completion;

@end


@interface UIView (HNWAlertWrapperController)
@property (nullable, nonatomic, weak) HNWAlertWrapperController *alertWrapperController;
@end

NS_ASSUME_NONNULL_END
