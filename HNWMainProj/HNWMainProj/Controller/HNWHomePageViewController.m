//
//  HNWHomePageViewController.m
//  HNWMainProj
//
//  Created by Young on 2020/1/12.
//  Copyright © 2020 Young. All rights reserved.
//

#import "HNWHomePageViewController.h"
#import "HNWTaskManager.h"
#import "UIApplication+HNWKit.h"

@interface HNWHomePageViewController ()

@end

@implementation HNWHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"首页";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    __block NSString *lastTaskId = nil;
    [HNWTaskManager performTasks:^dispatch_queue_t _Nonnull(dispatch_group_t  _Nonnull group, NSString * _Nonnull taskId) {
        lastTaskId = taskId;
        NSLog(@"taskId: %@", lastTaskId);
        dispatch_group_enter(group);
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [NSThread sleepForTimeInterval:2];
            dispatch_group_leave(group);
        });
        
        dispatch_group_enter(group);
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [NSThread sleepForTimeInterval:5];
            dispatch_group_leave(group);
        });
        
        return dispatch_get_global_queue(0, 0);
    } completionHandler:^(NSString * _Nonnull taskId) {
        NSLog(@"taskId: %@ - %@", taskId, lastTaskId);
        NSURL *url = [NSURL URLWithString:@"https://www.baidu.com/"];
        [UIApplication.sharedApplication hnw_openURL:url completionHandler:^(BOOL success) {
            
        }];
    }];
}

@end
