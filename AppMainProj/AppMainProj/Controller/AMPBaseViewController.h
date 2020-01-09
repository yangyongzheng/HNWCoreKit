//
//  AMPBaseViewController.h
//  AppMainProj
//
//  Created by Young on 2019/12/24.
//  Copyright © 2019 Young. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AMPBaseViewController : UIViewController

@property (nullable, nonatomic, readonly, weak) UINavigationController *stackNavigationController;

@property (nonatomic, strong) UIBarButtonItem *goBackItem;

@property (nonatomic, getter=isInteractivePopEnabled) BOOL interactivePopEnabled; // default YES

- (void)removeGoBackItem;

- (void)goBackActionHandler;

@end

NS_ASSUME_NONNULL_END
