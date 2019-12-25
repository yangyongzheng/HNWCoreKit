//
//  HNWTabMenuViewItem.h
//  HNWKit
//
//  Created by Young on 2019/12/25.
//  Copyright © 2019 Young. All rights reserved.
//

#import "HNWTabMenuItemBadgeProviders.h"

NS_ASSUME_NONNULL_BEGIN

@interface HNWTabMenuViewItem : NSObject

@property (nonatomic, readonly, copy) NSString *title;

@property (nullable, nonatomic, strong) id<HNWTabMenuItemBadgeProvider> badgeProvider;

@property (nonatomic) CGFloat titleSelectedWidth;

+ (instancetype)itemWithTitle:(NSString *)title;

+ (instancetype)itemWithTitle:(NSString *)title badgeProvider:(nullable id <HNWTabMenuItemBadgeProvider>)badgeProvider;

@end

NS_ASSUME_NONNULL_END
