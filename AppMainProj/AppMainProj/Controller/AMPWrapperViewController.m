//
//  AMPWrapperViewController.m
//  AppMainProj
//
//  Created by Young on 2020/1/9.
//  Copyright © 2020 Young. All rights reserved.
//

#import "AMPWrapperViewController.h"
#import "AMPBoxNavigationController.h"
#import <objc/runtime.h>


@implementation UIViewController (AMPWrapperViewController)

static const void * UIViewControllerWrapperViewControllerKey = (void *)&UIViewControllerWrapperViewControllerKey;

- (AMPWrapperViewController *)wrapperViewController {
    return objc_getAssociatedObject(self, UIViewControllerWrapperViewControllerKey);
}

- (void)setWrapperViewController:(AMPWrapperViewController * _Nullable)wrapperViewController {
    objc_setAssociatedObject(self, UIViewControllerWrapperViewControllerKey, wrapperViewController, OBJC_ASSOCIATION_ASSIGN);
}

@end



@interface AMPWrapperViewController ()
@property (nonatomic, weak) UIViewController *contentViewController;
@end

@implementation AMPWrapperViewController

+ (instancetype)wrapperViewController:(UIViewController *)viewController {
    AMPBoxNavigationController *boxNavigationController = [[AMPBoxNavigationController alloc] initWithRootViewController:viewController];
    // 包装盒子控制器
    AMPWrapperViewController *wrapperController = [[AMPWrapperViewController alloc] init];
    wrapperController.contentViewController = viewController;
    [viewController setWrapperViewController:wrapperController];
    // 添加专属导航控制器
    [wrapperController addChildViewController:boxNavigationController];
    boxNavigationController.view.frame = wrapperController.view.bounds;
    boxNavigationController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [wrapperController.view addSubview:boxNavigationController.view];
    [boxNavigationController didMoveToParentViewController:wrapperController];
    wrapperController.hidesBottomBarWhenPushed = YES;
    
    return wrapperController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
}

- (void)dealloc {
    self.contentViewController.wrapperViewController = nil;
}

@end
