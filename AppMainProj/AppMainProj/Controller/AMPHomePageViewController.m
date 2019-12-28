//
//  AMPHomePageViewController.m
//  AppMainProj
//
//  Created by Young on 2019/12/24.
//  Copyright © 2019 Young. All rights reserved.
//

#import "AMPHomePageViewController.h"
#import "AMPTestViewController.h"
#import <HNWKit/HNWKit.h>

@interface AMPHomePageViewController () <HNWKeyboardMonitorDelegate>

@end

@implementation AMPHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = HNWColorRGBAHexInt(0xFF442F);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    AMPTestViewController *testVC = [[AMPTestViewController alloc] init];
    [self.navigationController pushViewController:testVC animated:YES];
}

- (void)keyboardMonitor:(HNWKeyboardMonitor *)keyboardMonitor keyboardWillShow:(HNWKeyboardInfo *)info {
    
}

- (void)keyboardMonitor:(HNWKeyboardMonitor *)keyboardMonitor keyboardWillHide:(HNWKeyboardInfo *)info {
    
}

@end
