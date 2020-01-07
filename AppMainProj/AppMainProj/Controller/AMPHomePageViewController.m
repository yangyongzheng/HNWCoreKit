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
        [selfStrongRef didFinishGuidingHandler];
    }];
}

- (void)didFinishGuidingHandler {
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 420)];
    redView.backgroundColor = UIColor.whiteColor;
    [redView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideAlertView:)]];
    
    HNWAlertBoxController *boxVC = [HNWAlertBoxController boxControllerWithAlertView:redView];
    [boxVC showWithPresentingViewController:self
                        animationTransition:HNWAlertAnimationTransitionFade
                                 completion:^{
                                     
                                 }];
}

- (void)hideAlertView:(UITapGestureRecognizer *)tap {
    [tap.view.alertBoxController hideWithAnimationTransition:HNWAlertAnimationTransitionSlideFromRight
                                                  completion:^{
                                                      
                                                  }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self didFinishGuidingHandler];
}

@end
