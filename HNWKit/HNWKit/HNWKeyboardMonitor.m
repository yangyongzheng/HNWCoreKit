//
//  HNWKeyboardMonitor.m
//  HNWKit
//
//  Created by Young on 2019/12/28.
//  Copyright © 2019 Young. All rights reserved.
//

#import "HNWKeyboardMonitor.h"

@implementation HNWKeyboardInfo

+ (HNWKeyboardInfo *)keyboardInfoWithNotification:(NSNotification *)noti {
    HNWKeyboardInfo *info = [[HNWKeyboardInfo alloc] init];
    info->_beginFrame = [noti.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    info->_endFrame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    info->_animationDuration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    return info;
}

@end

#define HNWSharedKeyboardMonitor [HNWKeyboardMonitor sharedMonitor]

@interface HNWKeyboardMonitor ()
@property (nonatomic, strong) NSHashTable *delegateContainer;
@end

@implementation HNWKeyboardMonitor

#pragma mark - Lifecycle
+ (HNWKeyboardMonitor *)sharedMonitor {
    static HNWKeyboardMonitor *monitor = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        monitor = [[HNWKeyboardMonitor alloc] init];
        [monitor setupDefaultConfiguration];
    });
    return monitor;
}

+ (void)load {
    [HNWKeyboardMonitor sharedMonitor];
}

- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

#pragma mark - Public
+ (void)addDelegate:(id<HNWKeyboardMonitorDelegate>)delegate {
    if (delegate) {
        @synchronized (HNWSharedKeyboardMonitor.delegateContainer) {
            [HNWSharedKeyboardMonitor.delegateContainer addObject:delegate];
        }
    }
}

+ (void)removeDelegate:(id<HNWKeyboardMonitorDelegate>)delegate {
    @synchronized (HNWSharedKeyboardMonitor.delegateContainer) {
        [HNWSharedKeyboardMonitor.delegateContainer removeObject:delegate];
    }
}

#pragma mark - Notifications
- (void)keyboardWillShowNotification:(NSNotification *)noti {
    [self tellKeyboardMonitorDelegateWithSelector:@selector(keyboardMonitor:keyboardWillShow:)
                                     keyboardInfo:[HNWKeyboardInfo keyboardInfoWithNotification:noti]];
}

- (void)keyboardDidShowNotification:(NSNotification *)noti {
    [self tellKeyboardMonitorDelegateWithSelector:@selector(keyboardMonitor:keyboardDidShow:)
                                     keyboardInfo:[HNWKeyboardInfo keyboardInfoWithNotification:noti]];
}

- (void)keyboardWillHideNotification:(NSNotification *)noti {
    [self tellKeyboardMonitorDelegateWithSelector:@selector(keyboardMonitor:keyboardWillHide:)
                                     keyboardInfo:[HNWKeyboardInfo keyboardInfoWithNotification:noti]];
}

- (void)keyboardDidHideNotification:(NSNotification *)noti {
    [self tellKeyboardMonitorDelegateWithSelector:@selector(keyboardMonitor:keyboardDidHide:)
                                     keyboardInfo:[HNWKeyboardInfo keyboardInfoWithNotification:noti]];
}

- (void)keyboardWillChangeFrameNotification:(NSNotification *)noti {
    [self tellKeyboardMonitorDelegateWithSelector:@selector(keyboardMonitor:keyboardWillChangeFrame:)
                                     keyboardInfo:[HNWKeyboardInfo keyboardInfoWithNotification:noti]];
}

- (void)keyboardDidChangeFrameNotification:(NSNotification *)noti {
    [self tellKeyboardMonitorDelegateWithSelector:@selector(keyboardMonitor:keyboardDidChangeFrame:)
                                     keyboardInfo:[HNWKeyboardInfo keyboardInfoWithNotification:noti]];
}

#pragma mark - Misc
- (void)setupDefaultConfiguration {
    self.delegateContainer = [NSHashTable weakObjectsHashTable];
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(keyboardWillShowNotification:)
                                               name:UIKeyboardWillShowNotification
                                             object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(keyboardDidShowNotification:)
                                               name:UIKeyboardDidShowNotification
                                             object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(keyboardWillHideNotification:)
                                               name:UIKeyboardWillHideNotification
                                             object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(keyboardDidHideNotification:)
                                               name:UIKeyboardDidHideNotification
                                             object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(keyboardWillChangeFrameNotification:)
                                               name:UIKeyboardWillChangeFrameNotification
                                             object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(keyboardDidChangeFrameNotification:)
                                               name:UIKeyboardDidChangeFrameNotification
                                             object:nil];
}

- (void)tellKeyboardMonitorDelegateWithSelector:(SEL)aSelector keyboardInfo:(HNWKeyboardInfo *)keyboardInfo {
    NSArray *allDelegates = self.delegateContainer.allObjects;
    for (id <HNWKeyboardMonitorDelegate> delegate in allDelegates) {
        if ([self.delegateContainer containsObject:delegate] && [delegate respondsToSelector:aSelector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [delegate performSelector:aSelector withObject:self withObject:keyboardInfo];
#pragma clang diagnostic pop
        }
    }
}

@end
