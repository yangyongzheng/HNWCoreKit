//
//  HNWGuidePageViewController.h
//  HNWKit
//
//  Created by Young on 2020/1/5.
//  Copyright © 2020 Young. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class HNWGuidePageViewController;

@protocol HNWGuidePageViewControllerDelegate <NSObject>

- (void)guidePageViewController:(HNWGuidePageViewController *)guidePageViewController
    didFinishGuidingWithOptions:(NSDictionary *)guideOptions;

@end

@interface HNWGuidePageViewController : UIViewController

@property (nonatomic, readonly, weak) UIButton *skipButton;
@property (nonatomic, readonly, weak) UIButton *nextButton;
@property (nonatomic, readonly, weak) UIPageControl *pageControl;

@property (nonatomic, readonly, copy) NSArray<UIImage *> *guidePageImages;

@property (nonatomic, readonly) NSInteger currentPageIndex;

@property (nonatomic, weak) id <HNWGuidePageViewControllerDelegate> delegate;

+ (HNWGuidePageViewController *)controllerWithGuidePageImages:(NSArray<UIImage *> *)guidePageImages;

@end

NS_ASSUME_NONNULL_END
