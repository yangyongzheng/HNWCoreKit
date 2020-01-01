//
//  AMPTestViewController.m
//  AppMainProj
//
//  Created by Young on 2019/12/26.
//  Copyright © 2019 Young. All rights reserved.
//

#import "AMPTestViewController.h"
#import <HNWKit/HNWKit.h>

@interface AMPTestViewController ()
{
    UIView *redView;
}
@end

@implementation AMPTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.hnw_randomColor;
    redView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 260, 360)];
    redView.backgroundColor = UIColor.redColor;
    [redView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideAlertView)]];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (!redView.alertWrapperController) {
        HNWAlertWrapperController *vc = [HNWAlertWrapperController wrapperControllerWithAlertView:redView];
        [vc showWithPresentingViewController:self animationTransition:HNWAlertAnimationTransitionSlideFromRight completion:nil];
    }
}

- (void)hideAlertView {
    [redView.alertWrapperController hideWithAnimationTransition:HNWAlertAnimationTransitionNone completion:nil];
}

@end
