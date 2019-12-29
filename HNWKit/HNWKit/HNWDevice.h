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

@property (class, nonatomic, readonly, strong) HNWDevice *sharedDevice;

/** 重置默认配置，即刷新所有属性值（慎重调用） */
- (void)resetDefaultConfiguration;

// 以下属性在方法 application:didFinishLaunchingWithOptions: 调用后才会生成有效值
@property (nonatomic, readonly) CGFloat statusBarHeight;
@property (nonatomic, readonly) CGFloat navigationBarHeight;
@property (nonatomic, readonly) CGFloat tabBarHeight;
@property (nonatomic, readonly) CGFloat safeAreaBottomInset;

@end

NS_ASSUME_NONNULL_END
