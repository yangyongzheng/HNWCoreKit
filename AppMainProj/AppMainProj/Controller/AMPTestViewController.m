//
//  AMPTestViewController.m
//  AppMainProj
//
//  Created by Young on 2019/12/26.
//  Copyright © 2019 Young. All rights reserved.
//

#import "AMPTestViewController.h"
#import <HNWKit/HNWKit.h>

@interface AMPTestViewController () <HNWAppMonitorDelegate>
{
    HNWWeakTimer *_timer;
}
@end

@implementation AMPTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.hnw_randomColor;
    [HNWAppMonitor addDelegate:self];
    [HNWAppMonitor addDelegate:self];
    [HNWAppMonitor addDelegate:self];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

- (void)applicationDidFinishLaunching:(HNWAppMonitor *)appMonitor {
    
}

- (void)applicationDidEnterBackground:(HNWAppMonitor *)appMonitor {
    [HNWAppMonitor removeDelegate:self];
}

- (void)applicationWillEnterForeground:(HNWAppMonitor *)appMonitor {
    
}

@end
