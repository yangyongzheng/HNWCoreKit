//
//  HNWAlertDispatcher.h
//  HNWKit
//
//  Created by Young on 2020/1/2.
//  Copyright © 2020 Young. All rights reserved.
//

#import <UIKit/UIkit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, HNWAlertMode) {
    HNWAlertModeAppend = 0, // 直接追加
    HNWAlertModeReplace,    // 直接替换
};

typedef NS_ENUM(NSInteger, HNWAlertAnimationStyle) {
    HNWAlertAnimationStyleNone = 0,
    HNWAlertAnimationStyleFade,
    HNWAlertAnimationStyleSlideFromLeft,
    HNWAlertAnimationStyleSlideFromRight,
};

@interface HNWAlertDispatcher : NSObject

@property (class, nonatomic, readonly, strong) HNWAlertDispatcher *sharedDispatcher;

@property (nonatomic, readonly, strong) UIWindow *alertWindow; // alertWindow.rootViewController => UINavigationController => HNWAlertBoxController
@property (nonatomic, readonly, getter=isDisplayingAlertView) BOOL displayingAlertView;

- (void)showAlertView:(UIView *)alertView
            alertMode:(HNWAlertMode)alertMode
       animationStyle:(HNWAlertAnimationStyle)animationStyle
           completion:(void (^ _Nullable)(void))completion;

- (void)hideAlertView:(UIView *)alertView
       animationStyle:(HNWAlertAnimationStyle)animationStyle
           completion:(void (^ _Nullable)(void))completion;

@end

NS_ASSUME_NONNULL_END
