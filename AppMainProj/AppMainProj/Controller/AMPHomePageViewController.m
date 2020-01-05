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
@property (nonatomic, strong) HNWGuidePageBrowser *guidePageBrowser;
@end

@implementation AMPHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = HNWColorWithRGBAHexInt(0xFF442F);
    UIImage *image = [UIImage imageWithColor:UIColor.redColor size:CGSizeMake(1, 1)];
    UIImage *image2 = [UIImage imageWithColor:UIColor.greenColor size:CGSizeMake(1, 1)];
    UIImage *image3 = [UIImage imageWithColor:UIColor.blueColor size:CGSizeMake(1, 1)];
    HNWKitWeakTransfer(self);
    self.guidePageBrowser = [HNWGuidePageBrowser browserWithGuidePageImages:@[image , image2, image3] completionHandler:^{
        HNWKitStrongTransfer(self);
        selfStrongRef.guidePageBrowser = nil;
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    AMPTestViewController *vc = [[AMPTestViewController alloc] init];
}

@end
