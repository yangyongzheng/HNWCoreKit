//
//  AMPWrapperViewController.m
//  AppMainProj
//
//  Created by Young on 2020/1/3.
//  Copyright © 2020 Young. All rights reserved.
//

#import "AMPWrapperViewController.h"

@interface AMPBoxNavigationController : UINavigationController

@end

@implementation AMPBoxNavigationController

+ (instancetype)controllerWithContentViewController:(UIViewController *)contentViewController {
    AMPBoxNavigationController *box = [[[self class] alloc] initWithRootViewController:contentViewController];
    return box;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    [self setNavigationBarHidden:NO animated:NO];
    self.navigationBar.translucent = NO;
}

@end

@interface AMPWrapperViewController ()
@property (nonatomic, strong) AMPBoxNavigationController *boxNavigationController;
@end

@implementation AMPWrapperViewController

+ (instancetype)controllerWithContentViewController:(UIViewController *)contentViewController {
    AMPBoxNavigationController *boxNavigationController = [AMPBoxNavigationController controllerWithContentViewController:contentViewController];
    AMPWrapperViewController *wrapperViewController = [[[self class] alloc] init];
    wrapperViewController.boxNavigationController = boxNavigationController;
    [wrapperViewController addChildViewController:boxNavigationController];
    [boxNavigationController didMoveToParentViewController:wrapperViewController];
    return wrapperViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.boxNavigationController.view];
}



@end
