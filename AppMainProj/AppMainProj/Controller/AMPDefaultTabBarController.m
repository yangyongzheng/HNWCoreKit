//
//  AMPDefaultTabBarController.m
//  AppMainProj
//
//  Created by Young on 2019/12/24.
//  Copyright © 2019 Young. All rights reserved.
//

#import "AMPDefaultTabBarController.h"
#import "AMPDefaultNavigationController.h"
#import "AMPHomePageViewController.h"

@implementation AMPDefaultTabBarController

+ (void)initialize {
    [super initialize];
    if (self == [AMPDefaultTabBarController self]) {
        UITabBarItem *item;
        if (@available(iOS 9.0, *)) {
            item = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
        } else {
            item = [UITabBarItem appearanceWhenContainedIn:self, nil];
        }
        NSDictionary *normalAttributes = @{
                                           NSFontAttributeName : [UIFont systemFontOfSize:13],
                                           NSForegroundColorAttributeName : HNWColorWithARGBHexInt(0x222222),
                                           };
        [item setTitleTextAttributes:normalAttributes forState:UIControlStateNormal];
        
        NSDictionary *selectedAttributes = @{
                                             NSFontAttributeName : [UIFont systemFontOfSize:13],
                                             NSForegroundColorAttributeName : HNWColorWithARGBHexInt(0x39BF3E),
                                             };
        [item setTitleTextAttributes:selectedAttributes forState:UIControlStateSelected];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    [self setupDefaultViewControllers];
    self.tabBar.barTintColor = UIColor.whiteColor;
    self.tabBar.translucent = YES;
}

+ (AMPDefaultTabBarController *)defaultTabBarController {
    return [[AMPDefaultTabBarController alloc] init];
}

- (void)setupDefaultViewControllers {
    self.viewControllers = @[self.homePageNavigationController];
}

- (AMPDefaultNavigationController *)homePageNavigationController {
    AMPHomePageViewController *rootVC = [[AMPHomePageViewController alloc] init];
    AMPDefaultNavigationController *navigationController = [[AMPDefaultNavigationController alloc] initWithRootViewController:rootVC];
    UIImage *image = [UIImage imageWithColor:HNWColorWithARGBHexInt(0x222222) size:CGSizeMake(20, 20)];
    UIImage *selectedImage = [UIImage imageWithColor:HNWColorWithARGBHexInt(0x39BF3E) size:CGSizeMake(20, 20)];
    navigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页"
                                                                    image:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                            selectedImage:[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    return navigationController;
}

@end
