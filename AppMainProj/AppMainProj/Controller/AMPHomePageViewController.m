//
//  AMPHomePageViewController.m
//  AppMainProj
//
//  Created by Young on 2019/12/24.
//  Copyright © 2019 Young. All rights reserved.
//

#import "AMPHomePageViewController.h"
#import <HNWKit/HNWKit.h>

@interface AMPHomePageViewController ()

@end

@implementation AMPHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@", HNWColorRGBAHexInt(112233));
    NSLog(@"%@", HNWColorRGBAHexInt(0x112233));
    NSLog(@"%@", HNWColorRGBAHexInt(0x001100));
}

@end
