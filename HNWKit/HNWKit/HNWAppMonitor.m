//
//  HNWAppMonitor.m
//  HNWKit
//
//  Created by Young on 2019/12/28.
//  Copyright © 2019 Young. All rights reserved.
//

#import "HNWAppMonitor.h"

#define HNWSharedAppMonitor [HNWAppMonitor sharedMonitor]

@interface HNWAppMonitor ()
@property (nonatomic, strong) NSHashTable *delegateContainer;
@end

@implementation HNWAppMonitor

#pragma mark - Lifecycle
+ (HNWAppMonitor *)sharedMonitor {
    static HNWAppMonitor *monitor = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        monitor = [[HNWAppMonitor alloc] init];
        [monitor setupDefaultConfiguration];
    });
    return monitor;
}

+ (void)load {
    [HNWAppMonitor sharedMonitor];
}

- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

#pragma mark - Public
+ (void)addDelegate:(id<HNWAppMonitorDelegate>)delegate {
    if (delegate) {
        @synchronized (HNWSharedAppMonitor.delegateContainer) {
            [HNWSharedAppMonitor.delegateContainer addObject:delegate];
        }
    }
}

+ (void)removeDelegate:(id<HNWAppMonitorDelegate>)delegate {
    @synchronized (HNWSharedAppMonitor.delegateContainer) {
        [HNWSharedAppMonitor.delegateContainer removeObject:delegate];
    }
}

#pragma mark - Notifications
- (void)applicationDidFinishLaunchingNotification:(NSNotification *)notification {
    [self tellAppMonitorDelegateWithSelector:@selector(applicationDidFinishLaunching:)];
}

- (void)applicationWillTerminateNotification:(NSNotification *)notification {
    [self tellAppMonitorDelegateWithSelector:@selector(applicationWillTerminate:)];
}

- (void)applicationWillEnterForegroundNotification:(NSNotification *)notification {
    [self tellAppMonitorDelegateWithSelector:@selector(applicationWillEnterForeground:)];
}

- (void)applicationDidEnterBackgroundNotification:(NSNotification *)notification {
    [self tellAppMonitorDelegateWithSelector:@selector(applicationDidEnterBackground:)];
}

- (void)applicationDidBecomeActiveNotification:(NSNotification *)notification {
    [self tellAppMonitorDelegateWithSelector:@selector(applicationDidBecomeActive:)];
}

- (void)applicationWillResignActiveNotification:(NSNotification *)notification {
    [self tellAppMonitorDelegateWithSelector:@selector(applicationWillResignActive:)];
}

- (void)applicationDidReceiveMemoryWarningNotification:(NSNotification *)notification {
    [self tellAppMonitorDelegateWithSelector:@selector(applicationDidReceiveMemoryWarning:)];
}

#pragma mark - Misc
- (void)setupDefaultConfiguration {
    self.delegateContainer = [NSHashTable weakObjectsHashTable];
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(applicationDidFinishLaunchingNotification:)
                                               name:UIApplicationDidFinishLaunchingNotification
                                             object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(applicationWillTerminateNotification:)
                                               name:UIApplicationWillTerminateNotification
                                             object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(applicationWillEnterForegroundNotification:)
                                               name:UIApplicationWillEnterForegroundNotification
                                             object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(applicationDidEnterBackgroundNotification:)
                                               name:UIApplicationDidEnterBackgroundNotification
                                             object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(applicationDidBecomeActiveNotification:)
                                               name:UIApplicationDidBecomeActiveNotification
                                             object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(applicationWillResignActiveNotification:)
                                               name:UIApplicationWillResignActiveNotification
                                             object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(applicationDidReceiveMemoryWarningNotification:)
                                               name:UIApplicationDidReceiveMemoryWarningNotification
                                             object:nil];
}

- (void)tellAppMonitorDelegateWithSelector:(SEL)aSelector {
    NSArray *allDelegates = self.delegateContainer.allObjects;
    for (id <HNWAppMonitorDelegate> delegate in allDelegates) {
        if ([self.delegateContainer containsObject:delegate] && [delegate respondsToSelector:aSelector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [delegate performSelector:aSelector withObject:self];
#pragma clang diagnostic pop
        }
    }
}

@end
