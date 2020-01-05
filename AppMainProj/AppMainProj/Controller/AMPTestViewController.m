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
    
}
@end

@implementation AMPTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.hnw_randomColor;
    self.navigationItem.backBarButtonItem = nil;
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"GoBack"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(goBack)];
}

- (void)goBack {
    [self.navigationController.parentViewController.navigationController popViewControllerAnimated:YES];
}

@end
