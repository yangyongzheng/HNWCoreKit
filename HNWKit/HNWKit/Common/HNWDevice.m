//
//  HNWDevice.m
//  HNWKit
//
//  Created by Young on 2019/12/29.
//  Copyright © 2019 Young. All rights reserved.
//

#import "HNWDevice.h"

#define HNWDeviceSingletonInstance [HNWDevice privateSingletonInstance]

@interface HNWDevice ()
@property (nonatomic) CGFloat screenWidth;
@property (nonatomic) CGFloat screenHeight;
@property (nonatomic) CGFloat statusBarHeight;
@property (nonatomic) CGFloat navigationBarHeight;
@property (nonatomic) CGFloat tabBarHeight;
@property (nonatomic) CGFloat safeAreaBottomInset;
@end

@implementation HNWDevice

#pragma mark - Public
+ (void)initializeConfiguration {
    [HNWDeviceSingletonInstance resetDefaultConfiguration];
}

+ (CGFloat)screenWidth {
    return HNWDeviceSingletonInstance.screenWidth;
}

+ (CGFloat)screenHeight {
    return HNWDeviceSingletonInstance.screenHeight;
}

+ (CGFloat)statusBarHeight {
    return HNWDeviceSingletonInstance.statusBarHeight;
}

+ (CGFloat)navigationBarHeight {
    return HNWDeviceSingletonInstance.navigationBarHeight;
}

+ (CGFloat)tabBarHeight {
    return HNWDeviceSingletonInstance.tabBarHeight;
}

+ (CGFloat)safeAreaBottomInset {
    return HNWDeviceSingletonInstance.safeAreaBottomInset;
}

+ (CGFloat)safeAreaTopInset {
    return HNWDeviceSingletonInstance.statusBarHeight + HNWDeviceSingletonInstance.navigationBarHeight;
}

#pragma mark - Misc
+ (HNWDevice *)privateSingletonInstance {
    static HNWDevice *device = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        device = [[HNWDevice alloc] init];
    });
    if (device.statusBarHeight < 1) {[device resetDefaultConfiguration];}
    return device;
}

- (void)resetDefaultConfiguration {
    @synchronized (self) {
        self.screenWidth = UIScreen.mainScreen.bounds.size.width;
        self.screenHeight = UIScreen.mainScreen.bounds.size.height;
        self.statusBarHeight = UIApplication.sharedApplication.statusBarFrame.size.height;
        self.navigationBarHeight = 44;
        self.tabBarHeight = 49;
        if (@available(iOS 11.0, *)) {
            self.safeAreaBottomInset = self.currentFrontWindow.safeAreaInsets.bottom;
        } else {
            self.safeAreaBottomInset = 0;
        }
    }
}

- (UIWindow *)currentFrontWindow {
    UIWindow *frontWindow = nil;
    NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
    for (UIWindow *window in frontToBackWindows) {
        BOOL windowOnMainScreen = [window.screen isEqual:UIScreen.mainScreen];
        BOOL windowIsVisible = !window.hidden && window.alpha > 0;
        BOOL windowKeyWindow = window.isKeyWindow;
        if (windowOnMainScreen && windowIsVisible && windowKeyWindow) {
            frontWindow = window;
            break;
        }
    }
    if (!frontWindow) {
        frontWindow = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
        frontWindow.backgroundColor = [UIColor whiteColor];
        frontWindow.rootViewController = [[UIViewController alloc] init];
        frontWindow.hidden = NO;
        [frontWindow layoutIfNeeded];
    }
    return frontWindow;
}

@end
