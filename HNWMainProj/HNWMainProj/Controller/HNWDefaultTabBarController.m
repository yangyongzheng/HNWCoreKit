//
//  HNWDefaultTabBarController.m
//  HNWMainProj
//
//  Created by Young on 2020/1/12.
//  Copyright © 2020 Young. All rights reserved.
//

#import "HNWDefaultTabBarController.h"
#import "HNWDefaultNavigationController.h"
#import "HNWHomePageViewController.h"

@interface HNWDefaultTabBarController ()

@end

@implementation HNWDefaultTabBarController

+ (void)initialize {
    [super initialize];
    if (self == [HNWDefaultTabBarController self]) {
        UITabBarItem *item;
        if (@available(iOS 9.0, *)) {
            item = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
        } else {
            item = [UITabBarItem appearanceWhenContainedIn:self, nil];
        }
        NSDictionary *normalAttributes = @{
                                           NSFontAttributeName : [UIFont systemFontOfSize:12],
                                           NSForegroundColorAttributeName : HNWColorWithARGBHexInt(0x222222),
                                           };
        [item setTitleTextAttributes:normalAttributes forState:UIControlStateNormal];
        
        NSDictionary *selectedAttributes = @{
                                             NSFontAttributeName : [UIFont systemFontOfSize:12],
                                             NSForegroundColorAttributeName : HNWColorWithARGBHexInt(0x39BF3E),
                                             };
        [item setTitleTextAttributes:selectedAttributes forState:UIControlStateSelected];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupDefaultViewControllers];
    self.view.backgroundColor = UIColor.whiteColor;
    self.tabBar.barTintColor = UIColor.whiteColor;
    self.tabBar.translucent = YES;
}

+ (HNWDefaultTabBarController *)defaultTabBarController {
    return [[HNWDefaultTabBarController alloc] init];
}

- (void)setupDefaultViewControllers {
    self.viewControllers = @[self.homePageNavigationController];
}

- (HNWDefaultNavigationController *)homePageNavigationController {
    HNWHomePageViewController *rootVC = [[HNWHomePageViewController alloc] init];
    HNWDefaultNavigationController *navigationController = [[HNWDefaultNavigationController alloc] initWithRootViewController:rootVC];
    UIImage *image = [UIImage imageWithColor:HNWColorWithARGBHexInt(0x222222) size:CGSizeMake(20, 20)];
    UIImage *selectedImage = [UIImage imageWithColor:HNWColorWithARGBHexInt(0x39BF3E) size:CGSizeMake(20, 20)];
    navigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页"
                                                                    image:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                            selectedImage:[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    return navigationController;
}

@end
