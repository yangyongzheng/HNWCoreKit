//
//  SecondChildViewController.m
//  BaseProj
//
//  Created by yangyongzheng on 2019/12/17.
//  Copyright © 2019 yangyongzheng. All rights reserved.
//

#import "SecondChildViewController.h"

@interface SecondChildViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation SecondChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor colorWithRed:(arc4random()%256)/255.0
                                           green:(arc4random()%256)/255.0
                                            blue:(arc4random()%256)/255.0
                                           alpha:1.0];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [super scrollViewDidScroll:scrollView];
}

- (void)scrollToTopAnimated:(BOOL)animated {
    [super scrollToTopAnimated:animated];
}

@end
