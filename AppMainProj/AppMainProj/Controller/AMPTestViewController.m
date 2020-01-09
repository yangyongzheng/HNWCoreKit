//
//  AMPTestViewController.m
//  AppMainProj
//
//  Created by Young on 2019/12/26.
//  Copyright © 2019 Young. All rights reserved.
//

#import "AMPTestViewController.h"
#import "AMPDefaultNavigationController.h"
#import "AMPWebViewController.h"

@interface AMPTestViewController ()

@end

@implementation AMPTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.hnw_randomColor;
    self.navigationItem.title = @"测试";
}

- (void)goBackActionHandler {
    [super goBackActionHandler];
}

@end
