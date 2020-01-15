//
//  HomePageViewController.m
//  BaseProj
//
//  Created by yangyongzheng on 2019/12/17.
//  Copyright © 2019 yangyongzheng. All rights reserved.
//

#import "HomePageViewController.h"
#import "FirstChildViewController.h"
#import "SecondChildViewController.h"

#import "ParentMainTableView.h"

@interface HomePageViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) ParentMainTableView *mainTableView;
@property (nonatomic, strong) UIView *tableFooterView;
@property (nonatomic, strong) UIScrollView *contentScrollView;
@end

@implementation HomePageViewController

#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.mainTableView];
    self.mainTableView.scrollsToTop = YES;
    [self.mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    self.mainTableView.tableFooterView = self.tableFooterView;
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    // 添加子视图
    FirstChildViewController *vc1 = [[FirstChildViewController alloc] init];
    vc1.view.frame = self.contentScrollView.bounds;
    vc1.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self addChildViewController:vc1];
    [self.contentScrollView addSubview:vc1.view];
    [vc1 didMoveToParentViewController:self];
    
    SecondChildViewController *vc2 = [[SecondChildViewController alloc] init];
    vc2.view.frame = CGRectMake(HNWKIT_SCREEN_WIDTH, 0, HNWKIT_SCREEN_WIDTH, self.childViewHeight);
    vc2.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self addChildViewController:vc2];
    [self.contentScrollView addSubview:vc2.view];
    [vc1 didMoveToParentViewController:self];
    // 初始化状态
    self.scrollEnabled = YES;
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self
                       action:@selector(manualPulldownRefresh:)
             forControlEvents:UIControlEventValueChanged];
    if (@available(iOS 10.0, *)) {
        self.mainTableView.refreshControl = refreshControl;
    } else {
        [self.mainTableView addSubview:refreshControl];
    }
}

#pragma mark - Delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = indexPath.row == 0 ? [UIColor redColor] : [UIColor blueColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.row == 0 ? self.offsetYWhenHangOnTop : 44;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([scrollView isEqual:self.mainTableView]) {
        if (self.isScrollEnabled) {
            const CGFloat offsetY = scrollView.contentOffset.y;
            if (offsetY >= self.offsetYWhenHangOnTop) {
                self.scrollEnabled = NO;
                scrollView.contentOffset = CGPointMake(0, self.offsetYWhenHangOnTop);
            }
        } else {
            scrollView.contentOffset = CGPointMake(0, self.offsetYWhenHangOnTop);
        }
    }
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView {
    if ([scrollView isEqual:self.mainTableView]) {
        self.scrollEnabled = YES;
        return YES;
    } else {
        return NO;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if ([scrollView isEqual:self.mainTableView]) {
        self.contentScrollView.scrollEnabled = NO;
    } else {
        self.mainTableView.scrollEnabled = NO;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if ([scrollView isEqual:self.mainTableView]) {
        self.contentScrollView.scrollEnabled = YES;
    } else {
        self.mainTableView.scrollEnabled = YES;
        if (!decelerate) {
            [self refreshSegmentHeaderView];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([scrollView isEqual:self.contentScrollView]) {
        [self refreshSegmentHeaderView];
    }
}

#pragma mark - Actions
- (void)manualPulldownRefresh:(UIRefreshControl *)sender {
    [sender endRefreshing];
}

#pragma mark - Misc
- (void)refreshSegmentHeaderView {
    long idx = lround(self.contentScrollView.contentOffset.x / HNWKIT_SCREEN_WIDTH);
    NSLog(@"切换选中Segment View：%ld", idx);
}

#pragma mark - getter or setter
- (ParentMainTableView *)mainTableView {
    if (!_mainTableView) {
        _mainTableView = [[ParentMainTableView alloc] initWithFrame:self.view.bounds];
        _mainTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    }
    return _mainTableView;
}

- (UIView *)tableFooterView {
    if (!_tableFooterView) {
        _tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, HNWKIT_SCREEN_WIDTH, self.childViewHeight)];
        _tableFooterView.backgroundColor = [UIColor lightGrayColor];
        [_tableFooterView addSubview:self.contentScrollView];
    }
    return _tableFooterView;
}

- (UIScrollView *)contentScrollView {
    if (!_contentScrollView) {
        _contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, HNWKIT_SCREEN_WIDTH, self.childViewHeight)];
        _contentScrollView.contentSize = CGSizeMake(HNWKIT_SCREEN_WIDTH*2.0, self.childViewHeight);
        _contentScrollView.bounces = NO;
        _contentScrollView.showsVerticalScrollIndicator = NO;
        _contentScrollView.showsHorizontalScrollIndicator = NO;
        _contentScrollView.backgroundColor = [UIColor clearColor];
        _contentScrollView.pagingEnabled = YES;
        _contentScrollView.scrollsToTop = NO;
        _contentScrollView.delegate = self;
    }
    return _contentScrollView;
}

- (CGFloat)childViewHeight {
    return HNWKIT_SCREEN_HEIGHT - 44;// 44 为悬挂Tab高度
}

- (CGFloat)offsetYWhenHangOnTop {
    return 120;
}

- (void)setScrollEnabled:(BOOL)scrollEnabled {
    _scrollEnabled = scrollEnabled;
    
    NSArray *safeChildViewControllers = self.childViewControllers;
    for (ChildBaseViewController *childVC in safeChildViewControllers) {
        if (scrollEnabled) {
            [childVC scrollToTopAnimated:NO];
        }
    }
}

@end
