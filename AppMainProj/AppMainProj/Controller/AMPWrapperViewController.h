//
//  AMPWrapperViewController.h
//  AppMainProj
//
//  Created by Young on 2020/1/9.
//  Copyright © 2020 Young. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class AMPWrapperViewController;

@interface UIViewController (AMPWrapperViewController)
@property (nullable, nonatomic, readonly, weak) AMPWrapperViewController *wrapperViewController;
@end

@interface AMPWrapperViewController : UIViewController

+ (instancetype)wrapperViewController:(UIViewController *)viewController;

@end

NS_ASSUME_NONNULL_END
