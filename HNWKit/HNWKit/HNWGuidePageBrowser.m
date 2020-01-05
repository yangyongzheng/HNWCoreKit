//
//  HNWGuidePageBrowser.m
//  HNWKit
//
//  Created by Young on 2020/1/5.
//  Copyright © 2020 Young. All rights reserved.
//

#import "HNWGuidePageBrowser.h"

@interface HNWGuidePageBrowser () <HNWGuidePageViewControllerDelegate>
@property (nonatomic, readwrite, strong) UIWindow *window;
@property (nonatomic, strong) HNWGuidePageViewController *guidePageViewController;
@property (nonatomic, copy) dispatch_block_t completionHandler;
@end

@implementation HNWGuidePageBrowser

+ (instancetype)browserWithGuidePageImages:(NSArray<UIImage *> *)guidePageImages completionHandler:(void (^)(void))completionHandler {
    HNWGuidePageBrowser *browser = [[[self class] alloc] init];
    browser.completionHandler = completionHandler;
    browser.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    browser.window.windowLevel = UIWindowLevelStatusBar + 50;
    browser.window.backgroundColor = UIColor.clearColor;
    HNWGuidePageViewController *viewController = [HNWGuidePageViewController controllerWithGuidePageImages:guidePageImages];
    viewController.delegate = browser;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    browser.window.rootViewController = navigationController;
    [browser.window makeKeyAndVisible];
    return browser;
}

#pragma mark - HNWGuidePageViewControllerDelegate
- (void)guidePageViewController:(HNWGuidePageViewController *)guidePageViewController
    didFinishGuidingWithOptions:(NSDictionary *)guideOptions {
    [self didFinishGuidingHandler];
}

#pragma mark - Misc
- (void)didFinishGuidingHandler {
    [self.window resignKeyWindow];
    self.window.hidden = YES;
    if (self.completionHandler) {
        self.completionHandler();
    }
}

- (NSArray<UIImage *> *)guidePageImages {
    return self.guidePageViewController.guidePageImages;
}

@end
