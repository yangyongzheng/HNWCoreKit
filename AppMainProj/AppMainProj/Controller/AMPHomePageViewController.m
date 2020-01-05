//
//  AMPHomePageViewController.m
//  AppMainProj
//
//  Created by Young on 2019/12/24.
//  Copyright © 2019 Young. All rights reserved.
//

#import "AMPHomePageViewController.h"
#import "AMPTestViewController.h"
#import "AMPWrapperViewController.h"
#import <HNWKit/HNWKit.h>

@interface AMPHomePageViewController ()

@end

@implementation AMPHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = HNWColorWithRGBAHexInt(0xFF442F);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    AMPTestViewController *vc = [[AMPTestViewController alloc] init];
    AMPWrapperViewController *wrapperViewController = [AMPWrapperViewController controllerWithContentViewController:vc];
    wrapperViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:wrapperViewController animated:YES];
}

@end
