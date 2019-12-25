//
//  AMPHomePageViewController.m
//  AppMainProj
//
//  Created by Young on 2019/12/24.
//  Copyright © 2019 Young. All rights reserved.
//

#import "AMPHomePageViewController.h"
#import <HNWKit/HNWKit.h>

@interface AMPHomePageViewController () <HNWTabMenuViewDelegate, HNWTabMenuViewDataSource>
{
    HNWTabMenuView *_tabMenuView;
}
@end

@implementation AMPHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = HNWColorRGBAHexInt(0xFF442F);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_tabMenuView removeFromSuperview];
    _tabMenuView = [[HNWTabMenuView alloc] initWithFrame:CGRectMake(15, 100, HNWKIT_SCREEN_WIDTH-30, 44)
                                       selectedItemIndex:1
                                           configuration:^(HNWTabMenuViewConfiguration * _Nonnull configuration) {
                                               configuration.selectedTitleColor = HNWColorRGBAHexInt(0x39BF3E);
                                               configuration.unselectedTitleColor = HNWColorRGBAHexInt(0x333333);
                                           }];
    [self.view addSubview:_tabMenuView];
    _tabMenuView.delegate = self;
    _tabMenuView.dataSource = self;
}

- (NSArray<NSString *> *)titlesForTabMenuView:(HNWTabMenuView *)tabMenuView {
    return @[@"全部", @"热销", @"关机"];
}

- (void)tabMenuView:(HNWTabMenuView *)tabMenuView didSelectItemAtIndex:(NSInteger)index isUserTrigger:(BOOL)isUserTrigger {
    
}

@end
