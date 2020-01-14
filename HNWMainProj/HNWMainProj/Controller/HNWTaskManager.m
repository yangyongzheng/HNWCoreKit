//
//  HNWTaskManager.m
//  HNWMainProj
//
//  Created by Young on 2020/1/14.
//  Copyright © 2020 Young. All rights reserved.
//

#import "HNWTaskManager.h"

@implementation HNWTaskManager

+ (void)performTasks:(dispatch_queue_t  _Nonnull (NS_NOESCAPE ^)(dispatch_group_t _Nonnull, NSString * _Nonnull))taskBlock
   completionHandler:(void (^)(NSString * _Nonnull))completionHandler {
    dispatch_group_t group = dispatch_group_create();
    NSString *taskId = NSUUID.UUID.UUIDString;
    dispatch_queue_t queue = nil;
    if (taskBlock) {
        queue = taskBlock(group, taskId);
    }
    if (!queue) {queue = dispatch_get_main_queue();}
    dispatch_group_notify(group, queue, ^{
        if (completionHandler) {completionHandler(taskId);}
    });
}

@end
