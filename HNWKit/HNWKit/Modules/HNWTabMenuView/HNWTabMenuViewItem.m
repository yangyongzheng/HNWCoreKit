//
//  HNWTabMenuViewItem.m
//  HNWKit
//
//  Created by Young on 2019/12/25.
//  Copyright © 2019 Young. All rights reserved.
//

#import "HNWTabMenuViewItem.h"

@implementation HNWTabMenuViewItem

+ (instancetype)itemWithTitle:(NSString *)title {
    return [self itemWithTitle:title badgeProvider:nil];
}

+ (instancetype)itemWithTitle:(NSString *)title badgeProvider:(id<HNWTabMenuItemBadgeProvider>)badgeProvider {
    HNWTabMenuViewItem *item = [[[self class] alloc] init];
    if (title && [title isKindOfClass:[NSString class]] && title.length > 0) {
        item->_title = [title copy];
    } else {
        item->_title = @"";
    }
    item.badgeProvider = badgeProvider;
    return item;
}

- (void)setBadgeProvider:(id<HNWTabMenuItemBadgeProvider>)badgeProvider {
    if ([HNWTabMenuViewItem isValidBadgeProvider:badgeProvider]) {
        _badgeProvider = badgeProvider;
    } else {
        _badgeProvider = nil;
    }
}

+ (BOOL)isValidBadgeProvider:(id<HNWTabMenuItemBadgeProvider>)badgeProvider {
    return badgeProvider && ([badgeProvider isKindOfClass:[HNWTabMenuItemBadgeRedDotProvider class]] ||
                             [badgeProvider isKindOfClass:[HNWTabMenuItemBadgeTextProvider class]] ||
                             [badgeProvider isKindOfClass:[HNWTabMenuItemBadgeImageProvider class]]);
}

@end
