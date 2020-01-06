//
//  HNWAppMonitor.h
//  HNWKit
//
//  Created by Young on 2019/12/28.
//  Copyright © 2019 Young. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class HNWAppMonitor;

@protocol HNWAppMonitorDelegate <NSObject>

@optional
- (void)applicationDidFinishLaunching:(HNWAppMonitor *)appMonitor;
- (void)applicationWillTerminate:(HNWAppMonitor *)appMonitor;
- (void)applicationWillEnterForeground:(HNWAppMonitor *)appMonitor;
- (void)applicationDidEnterBackground:(HNWAppMonitor *)appMonitor;
- (void)applicationDidBecomeActive:(HNWAppMonitor *)appMonitor;
- (void)applicationWillResignActive:(HNWAppMonitor *)appMonitor;
- (void)applicationDidReceiveMemoryWarning:(HNWAppMonitor *)appMonitor;

@end

@interface HNWAppMonitor : NSObject

/** 添加代理 */
+ (void)addDelegate:(id <HNWAppMonitorDelegate>)delegate;

/** 移除代理 */
+ (void)removeDelegate:(id <HNWAppMonitorDelegate>)delegate;

@end

NS_ASSUME_NONNULL_END
