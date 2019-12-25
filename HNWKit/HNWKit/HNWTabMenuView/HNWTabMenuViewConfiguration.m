//
//  HNWTabMenuViewConfiguration.m
//  HNWKit
//
//  Created by Young on 2019/12/25.
//  Copyright © 2019 Young. All rights reserved.
//

#import "HNWTabMenuViewConfiguration.h"

const CGFloat HNWTabMenuIndicatorWidthAutomaticDimension = -1;

@implementation HNWTabMenuViewConfiguration

- (instancetype)init {
    self = [super init];
    if (self) {
        self.minimumItemWidth = 0;
        self.itemSpacing = 1;
        
        self.indicatorWidth = 21;
        self.indicatorHeight = 3;
        
        self.topSeparatorHeight = 0.5;
        self.bottomSeparatorHeight = 0.5;
        self.topSeparatorInsets = UIEdgeInsetsZero;
        self.bottomSeparatorInsets = UIEdgeInsetsZero;
        
        self.selectedTitleColor = [UIColor redColor];
        self.unselectedTitleColor = [UIColor colorWithWhite:34.0/255.0 alpha:1.0];
        self.selectedTitleFont = [UIFont boldSystemFontOfSize:16];
        self.unselectedTitleFont = [UIFont systemFontOfSize:15];
    }
    return self;
}

- (void)setItemSpacing:(CGFloat)itemSpacing {
    if (itemSpacing >= 1) {
        _itemSpacing = itemSpacing;
    } else {
        _itemSpacing = 1;
    }
}

- (UIColor *)selectedTitleColor {
    if (!_selectedTitleColor) {
        _selectedTitleColor = [UIColor redColor];
    }
    return _selectedTitleColor;
}

- (UIColor *)unselectedTitleColor {
    if (!_unselectedTitleColor) {
        _unselectedTitleColor = [UIColor colorWithWhite:34.0/255.0 alpha:1.0];
    }
    return _unselectedTitleColor;
}

- (UIFont *)selectedTitleFont {
    if (!_selectedTitleFont) {
        _selectedTitleFont = [UIFont boldSystemFontOfSize:16];
    }
    return _selectedTitleFont;
}

- (UIFont *)unselectedTitleFont {
    if (!_unselectedTitleFont) {
        _unselectedTitleFont = [UIFont systemFontOfSize:15];
    }
    return _unselectedTitleFont;
}

@end
