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
@property (nonatomic, readwrite, strong) HNWGuidePageViewController *guidePageViewController;
@property (nonatomic, copy) dispatch_block_t completionHandler;
@end

@implementation HNWGuidePageBrowser

+ (instancetype)browserWithGuidePageImages:(NSArray<UIImage *> *)guidePageImages completionHandler:(void (^)(void))completionHandler {
    HNWGuidePageBrowser *browser = [[[self class] alloc] init];
    browser.completionHandler = completionHandler;
    browser.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    browser.window.windowLevel = UIWindowLevelStatusBar + 50;
    browser.window.backgroundColor = UIColor.whiteColor;
    HNWGuidePageViewController *viewController = [HNWGuidePageViewController controllerWithGuidePageImages:guidePageImages delegate:browser];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    browser.window.rootViewController = navigationController;
    navigationController.view.backgroundColor = UIColor.clearColor;
    [navigationController setNavigationBarHidden:YES animated:NO];
    viewController.view.backgroundColor = UIColor.clearColor;
    [browser.window makeKeyAndVisible];
    return browser;
}

- (void)dealloc {
    if (self.window) {
        [self.window resignKeyWindow];
        self.window.hidden = YES;
        self.window = nil;
    }
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
