//
//  HNWDevice.m
//  HNWKit
//
//  Created by Young on 2019/12/29.
//  Copyright © 2019 Young. All rights reserved.
//

#import "HNWDevice.h"

#define HNWSharedDevice [HNWDevice sharedDevice]

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
+ (CGFloat)screenWidth {
    return HNWSharedDevice.screenWidth;
}

+ (CGFloat)screenHeight {
    return HNWSharedDevice.screenHeight;
}

+ (CGFloat)statusBarHeight {
    return HNWSharedDevice.statusBarHeight;
}

+ (CGFloat)navigationBarHeight {
    return HNWSharedDevice.navigationBarHeight;
}

+ (CGFloat)tabBarHeight {
    return HNWSharedDevice.tabBarHeight;
}

+ (CGFloat)safeAreaBottomInset {
    return HNWSharedDevice.safeAreaBottomInset;
}

+ (void)initializeConfiguration {
    [HNWSharedDevice resetDefaultConfiguration];
}

#pragma mark - Misc
+ (void)load {
    [HNWDevice sharedDevice];
}

+ (HNWDevice *)sharedDevice {
    static HNWDevice *device = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        device = [[[self class] alloc] init];
        [device resetDefaultConfiguration];
        [device addDidFinishLaunchingNotification];
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
            UIWindow *window = UIApplication.sharedApplication.keyWindow;
            if (!window) {
                window = UIApplication.sharedApplication.delegate.window;
                if (!window) {
                    window = UIApplication.sharedApplication.windows.firstObject;
                }
            }
            self.safeAreaBottomInset = window.safeAreaInsets.bottom;
        } else {
            self.safeAreaBottomInset = 0;
        }
    }
}

- (void)addDidFinishLaunchingNotification {
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(applicationDidFinishLaunchingNotification:)
                                               name:UIApplicationDidFinishLaunchingNotification
                                             object:nil];
}

- (void)applicationDidFinishLaunchingNotification:(NSNotification *)notification {
    [NSNotificationCenter.defaultCenter removeObserver:self name:UIApplicationDidFinishLaunchingNotification object:nil];
    [HNWDevice initializeConfiguration];
}

@end
