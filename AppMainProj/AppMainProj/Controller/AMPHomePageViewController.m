//
//  AMPHomePageViewController.m
//  AppMainProj
//
//  Created by Young on 2019/12/24.
//  Copyright © 2019 Young. All rights reserved.
//

#import "AMPHomePageViewController.h"
#import "AMPTestViewController.h"
#import "AMPWrapperViewController.h"

@interface AMPHomePageViewController ()
@property (nonatomic, strong) HNWGuidePageBrowser *guidePageBrowser;
@end

@implementation AMPHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.interactivePopEnabled = NO;
    [self removeGoBackItem];
    [self addGoTestItem];
    self.navigationItem.title = @"首页";
    self.view.backgroundColor = UIColor.whiteColor;
    [self showGuidePages];
}

- (void)addGoTestItem {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"GoTest"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(goTestActionHandler)];
}

- (void)showGuidePages {
    UIImage *image = [UIImage imageWithColor:UIColor.redColor size:CGSizeMake(1, 1)];
    UIImage *image2 = [UIImage imageWithColor:UIColor.greenColor size:CGSizeMake(1, 1)];
    UIImage *image3 = [UIImage imageWithColor:UIColor.blueColor size:CGSizeMake(1, 1)];
    HNWKitWeakTransfer(self);
    self.guidePageBrowser = [HNWGuidePageBrowser browserWithGuidePageImages:@[image , image2, image3] completionHandler:^{
        HNWKitStrongTransfer(self);
        selfStrongRef.guidePageBrowser = nil;
        [selfStrongRef didFinishGuidingHandler];
    }];
}

- (void)goTestActionHandler {
    [self.stackNavigationController pushViewController:AMPTestViewController.new animated:YES];
}

- (void)didFinishGuidingHandler {
    NSLog(@"引导完成");
}

@end
