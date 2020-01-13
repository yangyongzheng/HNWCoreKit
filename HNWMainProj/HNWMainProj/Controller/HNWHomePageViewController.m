//
//  HNWHomePageViewController.m
//  HNWMainProj
//
//  Created by Young on 2020/1/12.
//  Copyright © 2020 Young. All rights reserved.
//

#import "HNWHomePageViewController.h"
#import "HNWAlertBoxController.h"

@interface HNWHomePageViewController ()
{
    UITextField *tf;
}
@end

@implementation HNWHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"首页";
    tf = [[UITextField alloc] initWithFrame:CGRectMake(20, 100, 300, 30)];
    [self.view addSubview:tf];
    tf.backgroundColor = UIColor.yellowColor;
    tf.textColor = UIColor.whiteColor;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    static BOOL isFirstFlag = YES;
    if (isFirstFlag) {
        isFirstFlag = NO;
        [tf becomeFirstResponder];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    redView.backgroundColor = UIColor.redColor;
    HNWAlertBoxController *boxVC = [HNWAlertBoxController alertBoxControllerWithAlertView:redView];
    [self presentViewController:boxVC animated:NO completion:nil];
}

@end
