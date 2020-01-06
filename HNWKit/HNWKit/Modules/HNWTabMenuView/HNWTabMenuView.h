//
//  HNWTabMenuView.h
//  HNWKit
//
//  Created by Young on 2019/12/25.
//  Copyright © 2019 Young. All rights reserved.
//

#import "HNWTabMenuViewConfiguration.h"
#import "HNWTabMenuItemBadgeProviders.h"

NS_ASSUME_NONNULL_BEGIN

/**
 重新加载数据的作用域
 
 - HNWTabMenuReloadScopeAll: 重新加载 标题+角标
 - HNWTabMenuReloadScopeBadges: 重新加载 角标
 */
typedef NS_ENUM(NSInteger, HNWTabMenuReloadScope) {
    HNWTabMenuReloadScopeAll,
    HNWTabMenuReloadScopeBadges,
};


@class HNWTabMenuView;

@protocol HNWTabMenuViewDataSource <NSObject>

@required
- (nullable NSArray<NSString *> *)titlesForTabMenuView:(HNWTabMenuView *)tabMenuView;

@optional
- (nullable id <HNWTabMenuItemBadgeProvider>)tabMenuView:(HNWTabMenuView *)tabMenuView badgeProviderForItemAtIndex:(NSInteger)index;

@end


@protocol HNWTabMenuViewDelegate <NSObject>

@required
- (void)tabMenuView:(HNWTabMenuView *)tabMenuView didSelectItemAtIndex:(NSInteger)index isUserTrigger:(BOOL)isUserTrigger;

@end



@interface HNWTabMenuView : UIView

- (instancetype)initWithFrame:(CGRect)frame
            selectedItemIndex:(NSInteger)selectedItemIndex
                configuration:(void (^ _Nullable)(HNWTabMenuViewConfiguration *configuration))configuration;

@property (nonatomic, weak) id <HNWTabMenuViewDataSource> dataSource;
@property (nonatomic, weak) id <HNWTabMenuViewDelegate> delegate;

@property (nonatomic, readonly, strong) UIView *contentView;
@property (nonatomic, readonly, strong) UIView *topSeparator;
@property (nonatomic, readonly, strong) UIView *bottomSeparator;
@property (nonatomic, readonly, strong) UIView *indicatorView;

@property (nonatomic, readonly) NSInteger selectedItemIndex;

- (void)selectItemAtIndex:(NSInteger)index
                 animated:(BOOL)animated
            isUserTrigger:(BOOL)isUserTrigger;

- (void)reloadDataWithScope:(HNWTabMenuReloadScope)reloadScope;

@end

NS_ASSUME_NONNULL_END
