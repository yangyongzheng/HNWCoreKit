//
//  HNWHomePageViewController.m
//  HNWMainProj
//
//  Created by Young on 2020/1/12.
//  Copyright © 2020 Young. All rights reserved.
//

#import "HNWHomePageViewController.h"
#import "HNWLayoutContentView.h"

@interface HNWHomePageViewController ()
{
    HNWLayoutContentView *_contentView;
}
@end

@implementation HNWHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"首页";
    _contentView = [[HNWLayoutContentView alloc] initWithFrame:CGRectMake(20, 100, 200, 300)];
    [self.view addSubview:_contentView];
    _contentView.contentView.backgroundColor = UIColor.redColor;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _contentView.bottomLayoutGuideHeight = arc4random() % 50;
    NSLog(@"%f-%@", _contentView.bottomLayoutGuideHeight, _contentView.contentView);
}

@end
