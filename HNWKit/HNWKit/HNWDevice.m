//
//  HNWDevice.m
//  HNWKit
//
//  Created by Young on 2019/12/29.
//  Copyright © 2019 Young. All rights reserved.
//

#import "HNWDevice.h"

@implementation HNWDevice

+ (void)load {
    [HNWDevice sharedDevice];
}

+ (HNWDevice *)sharedDevice {
    static HNWDevice *device = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        device = [[[self class] alloc] init];
        [device addDidFinishLaunchingNotification];
    });
    return device;
}

- (void)addDidFinishLaunchingNotification {
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(applicationDidFinishLaunchingNotification:)
                                               name:UIApplicationDidFinishLaunchingNotification
                                             object:nil];
}

- (void)applicationDidFinishLaunchingNotification:(NSNotification *)notification {
    [NSNotificationCenter.defaultCenter removeObserver:self name:UIApplicationDidFinishLaunchingNotification object:nil];
    [self resetDefaultConfiguration];
}

- (void)resetDefaultConfiguration {
    _statusBarHeight = UIApplication.sharedApplication.statusBarFrame.size.height;
    _navigationBarHeight = 44;
    _tabBarHeight = 49;
    if (@available(iOS 11.0, *)) {
        UIWindow *window = UIApplication.sharedApplication.keyWindow;
        if (!window) {
            window = UIApplication.sharedApplication.delegate.window;
            if (!window) {
                window = UIApplication.sharedApplication.windows.firstObject;
            }
        }
        _safeAreaBottomInset = window.safeAreaInsets.bottom;
    } else {
        _safeAreaBottomInset = 0;
    }
}

@end
