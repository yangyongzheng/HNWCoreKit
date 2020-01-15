//
//  ChildBaseViewController.h
//  BaseProj
//
//  Created by yangyongzheng on 2019/12/17.
//  Copyright © 2019 yangyongzheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChildBaseViewController : UIViewController

@property (nonatomic, readonly, strong) UITableView *tableView;

- (void)scrollToTopAnimated:(BOOL)animated;

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;

@end

NS_ASSUME_NONNULL_END
