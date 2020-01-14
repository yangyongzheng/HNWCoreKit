//
//  UIApplication+HNWKit.h
//  HNWMainProj
//
//  Created by Young on 2020/1/14.
//  Copyright © 2020 Young. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIApplication (HNWKit)

- (void)hnw_openURL:(NSURL *)url completionHandler:(void (^ _Nullable)(BOOL success))completionHandler;

@end

NS_ASSUME_NONNULL_END
