//
//  HNWHomePageViewController.m
//  HNWMainProj
//
//  Created by Young on 2020/1/12.
//  Copyright © 2020 Young. All rights reserved.
//

#import "HNWHomePageViewController.h"
#import "HNWAlertBoxViewController.h"

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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

@end
