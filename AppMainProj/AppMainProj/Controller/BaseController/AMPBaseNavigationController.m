//
//  AMPBaseNavigationController.m
//  AppMainProj
//
//  Created by Young on 2019/12/24.
//  Copyright © 2019 Young. All rights reserved.
//

#import "AMPBaseNavigationController.h"

@interface AMPBaseNavigationController ()

@end

@implementation AMPBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.whiteColor;
    [self setNavigationBarHidden:YES animated:NO];
}

@end
