//
//  HNWHomePageViewController.m
//  Examples
//
//  Created by Young on 2020/1/15.
//  Copyright © 2020 Young. All rights reserved.
//

#import "HNWHomePageViewController.h"
#import "HomePageViewController.h"

@interface HNWHomePageViewController ()

@end

@implementation HNWHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.cyanColor;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        HomePageViewController *vc = HomePageViewController.new;
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:vc animated:YES completion:nil];
    });
}

@end
