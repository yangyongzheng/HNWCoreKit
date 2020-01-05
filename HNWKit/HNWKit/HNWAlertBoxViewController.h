//
//  HNWAlertBoxViewController.h
//  HNWKit
//
//  Created by Young on 2020/1/5.
//  Copyright © 2020 Young. All rights reserved.
//

#import "HNWAlertViewBox.h"

NS_ASSUME_NONNULL_BEGIN

@interface HNWAlertBoxViewController : UIViewController

@property (nonatomic, readonly, strong) HNWAlertViewBox *alertViewBox;

+ (nullable instancetype)viewControllerWithAlertView:(UIView *)alertView;

@end

NS_ASSUME_NONNULL_END
