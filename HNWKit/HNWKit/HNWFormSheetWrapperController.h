//
//  HNWFormSheetWrapperController.h
//  HNWKit
//
//  Created by Young on 2020/1/1.
//  Copyright © 2020 Young. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HNWFormSheetWrapperController : UIViewController

+ (nullable instancetype)wrapperControllerWithFormSheetView:(UIView *)formSheetView;

- (void)showWithPresentingViewController:(UIViewController *)presentingViewController
                     animationTransition:(NSInteger)animationTransition
                              completion:(void (^ _Nullable)(void))completion;

- (void)hideWithAnimationTransition:(NSInteger)animationTransition
                         completion:(void (^ _Nullable)(void))completion;

@end

NS_ASSUME_NONNULL_END
