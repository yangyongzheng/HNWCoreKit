//
//  HNWDevice.h
//  HNWKit
//
//  Created by Young on 2019/12/29.
//  Copyright © 2019 Young. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HNWDevice : NSObject

/** 初始化配置 */
+ (void)initializeConfiguration;

// 以下类属性在调用 initializeConfiguration 初始化方法后才会生成有效值，建议在 application:didFinishLaunchingWithOptions: 中调用
@property (class, nonatomic, readonly) CGFloat screenWidth;
@property (class, nonatomic, readonly) CGFloat screenHeight;
@property (class, nonatomic, readonly) CGFloat statusBarHeight;
@property (class, nonatomic, readonly) CGFloat navigationBarHeight;
@property (class, nonatomic, readonly) CGFloat tabBarHeight;
@property (class, nonatomic, readonly) CGFloat safeAreaBottomInset;

@end

NS_ASSUME_NONNULL_END
