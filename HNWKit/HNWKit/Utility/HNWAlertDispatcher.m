//
//  HNWAlertDispatcher.m
//  HNWKit
//
//  Created by Young on 2020/1/2.
//  Copyright © 2020 Young. All rights reserved.
//

#import "HNWAlertDispatcher.h"
#import "HNWAlertBoxController.h"

@interface HNWAlertDispatcher ()
@property (nonatomic, readwrite, strong) UIWindow *alertWindow;
@property (nonatomic, readonly, weak) HNWAlertBoxController *boxController;
@end

@implementation HNWAlertDispatcher

+ (HNWAlertDispatcher *)sharedDispatcher {
    static HNWAlertDispatcher *dispatcher = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dispatcher = [[[self class] alloc] init];
        [dispatcher setupDefaultConfiguration];
    });
    return dispatcher;
}

- (void)showAlertView:(UIView *)alertView
            alertMode:(HNWAlertMode)alertMode
       animationStyle:(HNWAlertAnimationStyle)animationStyle
           completion:(void (^)(void))completion {
    [self.alertWindow makeKeyAndVisible];
}

- (void)hideAlertView:(UIView *)alertView
       animationStyle:(HNWAlertAnimationStyle)animationStyle
           completion:(void (^)(void))completion {
    
}

#pragma mark - Misc
- (void)setupDefaultConfiguration {
    self.alertWindow = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.alertWindow.windowLevel = UIWindowLevelStatusBar + 10;
    self.alertWindow.backgroundColor = UIColor.clearColor;
    self.alertWindow.hidden = YES;
    self.alertWindow.clipsToBounds = YES;
    HNWAlertBoxController *boxVC = [[HNWAlertBoxController alloc] init];
    self.alertWindow.rootViewController = [[UINavigationController alloc] initWithRootViewController:boxVC];
}

@end
