//
//  AMPBoxNavigationController.m
//  AppMainProj
//
//  Created by Young on 2020/1/9.
//  Copyright © 2020 Young. All rights reserved.
//

#import "AMPBoxNavigationController.h"

@interface AMPBoxNavigationController ()

@end

@implementation AMPBoxNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBarHidden:NO animated:NO];
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationBar.barTintColor = UIColor.whiteColor;
    self.navigationBar.translucent = YES;
    self.interactivePopGestureRecognizer.enabled = NO;
}

@end
