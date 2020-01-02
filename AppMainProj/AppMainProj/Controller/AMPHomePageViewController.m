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

@interface AMPHomePageViewController ()

@end

@implementation AMPHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = HNWColorRGBAHexInt(0xFF442F);
    
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 250, 250)];
    redView.backgroundColor = UIColor.redColor;
    [HNWAlertDispatcher.sharedDispatcher showAlertView:redView
                                             alertMode:HNWAlertModeReplace
                                        animationStyle:HNWAlertAnimationStyleFade
                                            completion:^{
                                                
                                            }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.childViewControllers.count > 0) {} else {
        AMPTestViewController *testVC = [[AMPTestViewController alloc] init];
        [self addChildViewController:testVC];
        [self.view addSubview:testVC.view];
        testVC.view.frame = CGRectMake(0, 200, CGRectGetWidth(self.view.frame), HNWKIT_SCREEN_HEIGHT-200);
        testVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleBottomMargin;
        [testVC didMoveToParentViewController:self];
    }
}

@end
