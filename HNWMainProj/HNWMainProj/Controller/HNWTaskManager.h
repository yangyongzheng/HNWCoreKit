//
//  HNWTaskManager.h
//  HNWMainProj
//
//  Created by Young on 2020/1/14.
//  Copyright © 2020 Young. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HNWTaskManager : NSObject

/**
 多个异步任务 同步
 
 @param taskBlock 添加任务Block，直接在当前线程执行。
 Block参数：group 调度组，taskId 任务id，返回值为completionHandler回调队列
 
 @param completionHandler 全部任务完成回调(taskBlock返回值队列中回调)
 */
+ (void)performTasks:(dispatch_queue_t (NS_NOESCAPE ^)(dispatch_group_t group, NSString *taskId))taskBlock
   completionHandler:(void (^)(NSString *taskId))completionHandler;

@end

NS_ASSUME_NONNULL_END
