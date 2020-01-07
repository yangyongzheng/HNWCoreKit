//
//  HNWWeakTimer.h
//  HNWKit
//
//  Created by Young on 2019/12/26.
//  Copyright © 2019 Young. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HNWWeakTimer : NSObject

/**
 开启定时器
 
 @param interval 定时器触发间隔时间，单位毫秒。当 interval <= 0 时使用默认值 1ms
 @param repeats 是否重复触发
 @param block 定时器触发回调，注意Block循环引用
 */
- (void)scheduledTimerWithTimeInterval:(long)interval
                               repeats:(BOOL)repeats
                                 block:(void (^)(HNWWeakTimer *timerHolder))block;
/**
 开启定时器
 
 @param interval 定时器触发间隔时间，单位毫秒。当 interval <= 0 时使用默认值 1ms
 @param repeats 是否重复触发
 @param mode 运行循环模式，默认 NSRunLoopCommonModes
 @param block 定时器触发回调，注意Block循环引用
 */
- (void)scheduledTimerWithTimeInterval:(long)interval
                               repeats:(BOOL)repeats
                                  mode:(NSRunLoopMode)mode
                                 block:(void (^)(HNWWeakTimer *timerHolder))block;

/**
 开启倒计时定时器，当 countdown >= interval > 0 时才能开启成功。
 
 @param countdown 初始倒计时长，单位毫秒
 @param interval 定时器触发间隔时间，单位毫秒
 @param block 定时器触发回调，注意Block循环引用
 */
- (void)scheduledTimerWithCountdown:(long)countdown
                           interval:(long)interval
                              block:(void (^)(HNWWeakTimer *timerHolder, long currentCountdown))block;

/**
 开启倒计时定时器，当 countdown >= interval > 0 时才能开启成功。
 
 @param countdown 初始倒计时长，单位毫秒
 @param interval 定时器触发间隔时间，单位毫秒
 @param mode 运行循环模式，默认 NSRunLoopCommonModes
 @param block 定时器触发回调，注意Block循环引用
 */
- (void)scheduledTimerWithCountdown:(long)countdown
                           interval:(long)interval
                               mode:(NSRunLoopMode)mode
                              block:(void (^)(HNWWeakTimer *timerHolder, long currentCountdown))block;

/** 立即触发一次定时器 */
- (void)fireTimer;

/** 销毁定时器 */
- (void)invalidateTimer;

/** 定时器是否有效 */
@property (nonatomic, readonly, getter=isValid) BOOL valid;

@end

NS_ASSUME_NONNULL_END
