//
//  HNWGuidePageBrowser.h
//  HNWKit
//
//  Created by Young on 2020/1/5.
//  Copyright © 2020 Young. All rights reserved.
//

#import "HNWGuidePageViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HNWGuidePageBrowser : NSObject

+ (instancetype)browserWithGuidePageImages:(NSArray<UIImage *> *)guidePageImages completionHandler:(void (^)(void))completionHandler;

@property (nonatomic, readonly, strong) UIWindow *window;
@property (nonatomic, readonly, weak) NSArray<UIImage *> *guidePageImages;

@end

NS_ASSUME_NONNULL_END
