//
//  AMPDefaultNavigationController.m
//  AppMainProj
//
//  Created by Young on 2019/12/24.
//  Copyright © 2019 Young. All rights reserved.
//

#import "AMPDefaultNavigationController.h"
#import "AMPWrapperViewController.h"

@interface AMPDefaultNavigationController () <UINavigationControllerDelegate>

@end

@implementation AMPDefaultNavigationController

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    AMPWrapperViewController *wrapperViewController = [AMPWrapperViewController wrapperViewController:viewController];
    wrapperViewController.hidesBottomBarWhenPushed = self.viewControllers.count > 0;
    [super pushViewController:wrapperViewController animated:animated];
}

- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    return [super popToViewController:viewController.wrapperViewController animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    [self setNavigationBarHidden:YES animated:NO];
}

@end
