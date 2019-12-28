//
//  HNWWeakTimer.m
//  HNWKit
//
//  Created by Young on 2019/12/26.
//  Copyright © 2019 Young. All rights reserved.
//

#import "HNWWeakTimer.h"
#import "HNWKitMacros.h"

@interface NSTimer (HNWWeakTimerHelper)
+ (NSTimer *)hnw_privateTimerWithTimeInterval:(NSTimeInterval)interval
                                      repeats:(BOOL)repeats
                                         mode:(NSRunLoopMode)mode
                                        block:(void (^)(void))block;
@end


@interface HNWWeakTimer ()
@property (nonatomic, strong) NSTimer *hnwTimer;
@property (nonatomic) long currentCountdown;
@end

@implementation HNWWeakTimer

#pragma mark - Lifecycle
- (void)dealloc {
    [self invalidate];
}

#pragma mark - Public
- (void)scheduledWithTimeInterval:(long)interval
                          repeats:(BOOL)repeats
                            block:(void (^)(HNWWeakTimer * _Nonnull))block {
    [self scheduledWithTimeInterval:interval
                            repeats:repeats
                               mode:NSRunLoopCommonModes
                              block:block];
}

- (void)scheduledWithTimeInterval:(long)interval
                          repeats:(BOOL)repeats
                             mode:(NSRunLoopMode)mode
                            block:(void (^)(HNWWeakTimer * _Nonnull))block {
    [self invalidate];
    if (interval <= 0) {interval = 1;}
    if (block) {
        NSTimeInterval newInterval = [self convertIntervalWithMilliseconds:interval];
        HNWKitWeakTransfer(self);
        self.hnwTimer = [NSTimer hnw_privateTimerWithTimeInterval:newInterval repeats:repeats mode:mode block:^{
            HNWKitStrongTransfer(self);
            if (selfStrongRef) {
                block(selfStrongRef);
                if (!repeats) {
                    [selfStrongRef invalidate];
                }
            }
        }];
    }
}

- (void)scheduledWithCountdown:(long)countdown
                      interval:(long)interval
                         block:(void (^)(HNWWeakTimer * _Nonnull, long))block {
    [self scheduledWithCountdown:countdown
                        interval:interval
                            mode:NSRunLoopCommonModes
                           block:block];
}

- (void)scheduledWithCountdown:(long)countdown
                      interval:(long)interval
                          mode:(NSRunLoopMode)mode
                         block:(void (^)(HNWWeakTimer * _Nonnull, long))block {
    [self invalidate];
    if (interval > 0 && countdown >= interval && block) {
        self.currentCountdown = countdown;
        NSTimeInterval newInterval = [self convertIntervalWithMilliseconds:interval];
        HNWKitWeakTransfer(self);
        self.hnwTimer = [NSTimer hnw_privateTimerWithTimeInterval:newInterval repeats:YES mode:mode block:^{
            HNWKitStrongTransfer(self);
            if (selfStrongRef) {
                selfStrongRef.currentCountdown -= interval;
                if (selfStrongRef.currentCountdown <= 0) {
                    selfStrongRef.currentCountdown = 0;
                    [selfStrongRef invalidate];
                }
                block(selfStrongRef, selfStrongRef.currentCountdown);
            }
        }];
    }
}

- (void)fire {
    if (self.hnwTimer) {
        [self.hnwTimer fire];
    }
}

- (void)invalidate {
    if (self.hnwTimer) {
        [self.hnwTimer invalidate];
        self.hnwTimer = nil;
    }
}

- (BOOL)isValid {
    return self.hnwTimer ? self.hnwTimer.isValid : NO;
}

#pragma mark - Private
- (NSTimeInterval)convertIntervalWithMilliseconds:(long)milliseconds {
    return (NSTimeInterval)milliseconds / 1000.0;
}

@end



@implementation NSTimer (HNWWeakTimerHelper)

+ (NSTimer *)hnw_privateTimerWithTimeInterval:(NSTimeInterval)interval
                                      repeats:(BOOL)repeats
                                         mode:(NSRunLoopMode)mode
                                        block:(void (^)(void))block {
    NSTimer *timer = [NSTimer timerWithTimeInterval:interval
                                             target:self
                                           selector:@selector(hnw_privateTimerDidTriggerHandler:)
                                           userInfo:block?[block copy]:nil
                                            repeats:repeats];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:mode?:NSRunLoopCommonModes];
    
    return timer;
}

+ (void)hnw_privateTimerDidTriggerHandler:(NSTimer *)timer {
    if (timer.userInfo) {
        void (^ block)(void) = timer.userInfo;
        block();
    } else {
        [timer invalidate];
    }
}

@end
