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
- (instancetype)init {
    if (self = [super init]) {
        [self resetDefaultConfiguration];
    }
    return self;
}

+ (HNWDevice *)privateSingletonInstance {
    static HNWDevice *device = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        device = [[HNWDevice alloc] init];
    });
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
            self.safeAreaBottomInset = self.temporaryReferWindow.safeAreaInsets.bottom;
        } else {
            self.safeAreaBottomInset = 0;
        }
    }
}

- (UIWindow *)temporaryReferWindow {
    UIWindow *window = UIApplication.sharedApplication.keyWindow;
    if (!window) {
        window = UIApplication.sharedApplication.delegate.window;
        if (!window) {
            window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
            window.backgroundColor = [UIColor whiteColor];
            window.rootViewController = [[UIViewController alloc] init];
            window.hidden = NO;
            [window setNeedsLayout];
            [window layoutIfNeeded];
        }
    }
    return window;
}

@end
