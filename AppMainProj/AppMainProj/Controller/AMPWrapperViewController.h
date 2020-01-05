//
//  AMPWrapperViewController.h
//  AppMainProj
//
//  Created by Young on 2020/1/3.
//  Copyright © 2020 Young. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AMPWrapperViewController : UIViewController

+ (instancetype)controllerWithContentViewController:(UIViewController *)contentViewController;

@end

NS_ASSUME_NONNULL_END
