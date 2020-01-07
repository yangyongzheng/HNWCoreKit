//
//  HNWAlertBoxController.h
//  HNWKit
//
//  Created by Young on 2020/1/7.
//  Copyright © 2020 Young. All rights reserved.
//

#import "HNWAlertViewBox.h"
#import "HNWAlertAnimationTransition.h"

NS_ASSUME_NONNULL_BEGIN

@interface HNWAlertBoxController : UIViewController

@property (nonatomic, readonly, strong) HNWAlertViewBox *alertViewBox;

+ (nullable instancetype)boxControllerWithAlertView:(UIView *)alertView;

- (void)showWithPresentingViewController:(UIViewController *)presentingViewController
                     animationTransition:(HNWAlertAnimationTransition)animationTransition
                              completion:(void (^ _Nullable)(void))completion;

- (void)hideWithAnimationTransition:(HNWAlertAnimationTransition)animationTransition
                         completion:(void (^ _Nullable)(void))completion;

@end



@interface UIView (HNWAlertBoxController)
@property (nullable, nonatomic, weak) HNWAlertBoxController *alertBoxController;
@end

NS_ASSUME_NONNULL_END
