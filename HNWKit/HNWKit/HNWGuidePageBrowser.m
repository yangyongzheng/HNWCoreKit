//
//  HNWGuidePageBrowser.m
//  HNWKit
//
//  Created by Young on 2020/1/5.
//  Copyright © 2020 Young. All rights reserved.
//

#import "HNWGuidePageBrowser.h"

@interface HNWGuidePageBrowser ()
@property (nonatomic, readwrite, strong) UIWindow *window;
@property (nonatomic, strong) HNWGuidePageViewController *guidePageViewController;
@end

@implementation HNWGuidePageBrowser

+ (instancetype)browserWithGuidePageImages:(NSArray<UIImage *> *)guidePageImages {
    HNWGuidePageBrowser *browser = [[[self class] alloc] init];
    browser.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    browser.window.windowLevel = UIWindowLevelStatusBar + 50;
    browser.window.backgroundColor = UIColor.whiteColor;
    browser.window.hidden = YES;
    HNWGuidePageViewController *viewController = [HNWGuidePageViewController controllerWithGuidePageImages:guidePageImages];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    browser.window.rootViewController = navigationController;
    return browser;
}

- (NSArray<UIImage *> *)guidePageImages {
    return self.guidePageViewController.guidePageImages;
}

@end
