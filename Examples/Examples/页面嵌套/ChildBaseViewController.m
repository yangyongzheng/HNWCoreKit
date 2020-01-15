//
//  ChildBaseViewController.m
//  BaseProj
//
//  Created by yangyongzheng on 2019/12/17.
//  Copyright © 2019 yangyongzheng. All rights reserved.
//

#import "ChildBaseViewController.h"
#import "HomePageViewController.h"

NSNotificationName const ChildViewControllerWillLeaveTopNotification = @"ChildViewControllerWillLeaveTopNotification";

@interface ChildBaseViewController ()
@property (nonatomic, readwrite, strong) UITableView *tableView;
@end

@implementation ChildBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    HomePageViewController *parentVC = (HomePageViewController *)self.parentViewController;
    if (parentVC.isScrollEnabled) {
        scrollView.contentOffset = CGPointZero;
    } else {
        if (scrollView.contentOffset.y <= FLT_EPSILON) {
            parentVC.scrollEnabled = YES;
            scrollView.contentOffset = CGPointZero;
        }
    }
}

- (void)scrollToTopAnimated:(BOOL)animated {
    [self.tableView setContentOffset:CGPointZero animated:animated];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.scrollsToTop = NO;
    }
    return _tableView;
}

@end
