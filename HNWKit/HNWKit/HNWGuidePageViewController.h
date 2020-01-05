//
//  HNWGuidePageViewController.h
//  HNWKit
//
//  Created by Young on 2020/1/5.
//  Copyright © 2020 Young. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HNWGuidePageViewController : UIViewController

@property (nonatomic, readonly, copy) NSArray<UIImage *> *guidePageImages;

+ (HNWGuidePageViewController *)controllerWithGuidePageImages:(NSArray<UIImage *> *)guidePageImages;

@end

NS_ASSUME_NONNULL_END
