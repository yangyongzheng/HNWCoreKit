//
//  HNWTabMenuView.m
//  HNWKit
//
//  Created by Young on 2019/12/25.
//  Copyright © 2019 Young. All rights reserved.
//

#import "HNWTabMenuView.h"
#import "HNWTabMenuViewCollectionViewCell.h"
#import "HNWTabMenuViewItem.h"
#import "HNWLayoutConstraintConstructor.h"

@interface HNWTabMenuView () <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>
@property (nonatomic, readwrite, strong) UIView *contentView;
@property (nonatomic, readwrite, strong) UIView *topSeparator;
@property (nonatomic, readwrite, strong) UIView *bottomSeparator;
@property (nonatomic, readwrite, strong) UIView *indicatorView;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) HNWTabMenuViewConfiguration *configuration;
@property (nonatomic, copy) NSArray<NSString *> *lastOriginTitles;          // 原始标题数据
@property (nonatomic, copy) NSArray<HNWTabMenuViewItem *> *tabMenuItems;    // 根据原始标题数据生成的Items
@property (nonatomic, readwrite) NSInteger selectedItemIndex;
@end

@implementation HNWTabMenuView

#pragma mark - Public
- (instancetype)initWithFrame:(CGRect)frame
            selectedItemIndex:(NSInteger)selectedItemIndex
                configuration:(void (^)(HNWTabMenuViewConfiguration * _Nonnull))configuration {
    self = [super initWithFrame:frame];
    if (self) {
        if (configuration) {configuration(self.configuration);}
        self.selectedItemIndex = selectedItemIndex;
        [self setupDefaultConfig];
    }
    return self;
}

- (void)selectItemAtIndex:(NSInteger)index
                 animated:(BOOL)animated
            isUserTrigger:(BOOL)isUserTrigger {
    [self selectItemAtIndex:index
                   animated:animated
              isUserTrigger:isUserTrigger
        shouldTellsDelegate:YES];
}

- (void)reloadDataWithScope:(HNWTabMenuReloadScope)reloadScope {
    switch (reloadScope) {
        case HNWTabMenuReloadScopeBadges:
            [self reloadDataScopeBadges];
            break;
            
        default:
            [self reloadDataScopeAll];
            break;
    }
}

- (void)setDataSource:(id<HNWTabMenuViewDataSource>)dataSource {
    if ((!_dataSource && !dataSource) || (_dataSource && [_dataSource isEqual:dataSource])) {
        return;
    }
    _dataSource = dataSource;
    [self reloadDataScopeAll];
}

- (void)setDelegate:(id<HNWTabMenuViewDelegate>)delegate {
    if ((!_delegate && !delegate) || (_delegate && [_delegate isEqual:delegate])) {
        return;
    }
    _delegate = delegate;
    [self tellsDelegateWithUserTrigger:NO];
}

#pragma mark - Delegates
#pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.tabMenuItems.count > 0) {
        UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)collectionViewLayout;
        const CGFloat totalItemWidth = CGRectGetWidth(collectionView.bounds) - (self.tabMenuItems.count - 1) * flowLayout.minimumLineSpacing;
        const CGFloat validTotalItemWidth = totalItemWidth > 0 ? totalItemWidth : 0;
        const CGFloat itemWidth = floor(validTotalItemWidth / self.tabMenuItems.count);
        const CGFloat validItemWidth = MAX(itemWidth, self.configuration.minimumItemWidth);
        return CGSizeMake(validItemWidth, CGRectGetHeight(collectionView.bounds));
    } else {
        return CGSizeZero;
    }
}

#pragma mark UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.tabMenuItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HNWTabMenuViewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HNWTabMenuViewCollectionViewCell" forIndexPath:indexPath];
    HNWTabMenuViewItem *model = [self tabMenuItemAtIndex:indexPath.item];
    cell.titleLabel.text = model.title;
    cell.titleLabel.textColor = self.selectedItemIndex == indexPath.item ? self.configuration.selectedTitleColor : self.configuration.unselectedTitleColor;
    cell.titleLabel.font = self.selectedItemIndex == indexPath.item ? self.configuration.selectedTitleFont : self.configuration.unselectedTitleFont;
    [cell resetBadgeWithProvider:model.badgeProvider];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self selectItemAtIndex:indexPath.item animated:YES isUserTrigger:YES shouldTellsDelegate:YES];
}

#pragma mark - Actions
- (void)selectItemAtIndex:(NSInteger)index
                 animated:(BOOL)animated
            isUserTrigger:(BOOL)isUserTrigger
      shouldTellsDelegate:(BOOL)shouldTellsDelegate {
    if ([self validateItemIndex:index]) {
        self.selectedItemIndex = index;
        [self refreshTabMenuViewAnimated:animated];
        if (shouldTellsDelegate) {
            [self tellsDelegateWithUserTrigger:isUserTrigger];
        }
    }
}

- (BOOL)tellsDelegateWithUserTrigger:(BOOL)isUserTrigger {
    BOOL canRespond = (self.delegate && [self.delegate respondsToSelector:@selector(tabMenuView:didSelectItemAtIndex:isUserTrigger:)]);
    if ([self validateItemIndex:self.selectedItemIndex] && canRespond) {
        [self.delegate tabMenuView:self
              didSelectItemAtIndex:self.selectedItemIndex
                     isUserTrigger:isUserTrigger];
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - Misc
- (void)reloadDataScopeAll {
    if ([self constructDataSource]) {
        // 标题项发生改变时，判断是否重置选中项，同步通知代理
        if ([self validateItemIndex:self.selectedItemIndex]) {/* Do nothing */} else {
            self.selectedItemIndex = 0;
        }
        [self tellsDelegateWithUserTrigger:NO];
    }
    [self refreshTabMenuViewAnimated:NO];
}

- (void)reloadDataScopeBadges {
    [self constructItemBadges];
    [self.collectionView reloadData];
}

- (BOOL)constructDataSource {
    BOOL valueChanged = NO;
    NSArray<NSString *> *safeTitleArray = @[];
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(titlesForTabMenuView:)]) {
        NSArray *titleArray = [self.dataSource titlesForTabMenuView:self];
        if (titleArray && [titleArray isKindOfClass:[NSArray class]] && titleArray.count > 0) {
            safeTitleArray = [titleArray copy];
        }
    }
    if ([self lastOriginTitleArrayIsEqualToArray:safeTitleArray]) {
        [self constructItemBadges]; // 标题未变时更新角标
    } else {
        valueChanged = YES;
        self.lastOriginTitles = safeTitleArray;
        self.tabMenuItems = [self itemArrayWithTitleArray:safeTitleArray];
    }
    return valueChanged;
}

- (void)constructItemBadges {
    if (self.tabMenuItems.count > 0) {
        [self.tabMenuItems enumerateObjectsUsingBlock:^(HNWTabMenuViewItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.badgeProvider = [self dequeueBadgeProviderForItemAtIndex:idx];
        }];
    }
}

- (NSArray<HNWTabMenuViewItem *> *)itemArrayWithTitleArray:(NSArray<NSString *> *)titleArray {
    __block NSMutableArray *itemsArray = [NSMutableArray arrayWithCapacity:titleArray.count];
    [titleArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        id <HNWTabMenuItemBadgeProvider> badgeProvider = [self dequeueBadgeProviderForItemAtIndex:idx];
        HNWTabMenuViewItem *item = [HNWTabMenuViewItem itemWithTitle:obj badgeProvider:badgeProvider];
        if (item) {
            const CGSize titleSize = [item.title boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)
                                                              options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                                           attributes:@{NSFontAttributeName : self.configuration.selectedTitleFont}
                                                              context:nil].size;
            item.titleSelectedWidth = ceil(titleSize.width);
            [itemsArray addObject:item];
        }
    }];
    return [itemsArray copy];
}

- (id<HNWTabMenuItemBadgeProvider>)dequeueBadgeProviderForItemAtIndex:(NSInteger)index {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(tabMenuView:badgeProviderForItemAtIndex:)]) {
        return [self.dataSource tabMenuView:self badgeProviderForItemAtIndex:index];
    } else {
        return nil;
    }
}

- (HNWTabMenuViewItem *)tabMenuItemAtIndex:(NSInteger)index {
    if ([self validateItemIndex:index]) {
        return self.tabMenuItems[index];
    } else {
        return nil;
    }
}

- (BOOL)lastOriginTitleArrayIsEqualToArray:(NSArray *)toArray {
    BOOL oldNotEmpty = self.lastOriginTitles && [self.lastOriginTitles isKindOfClass:[NSArray class]] && self.lastOriginTitles.count > 0;
    BOOL newNotEmpty = toArray && [toArray isKindOfClass:[NSArray class]] && toArray.count > 0;
    return (!oldNotEmpty && !newNotEmpty) || (oldNotEmpty && newNotEmpty && [self.lastOriginTitles isEqualToArray:toArray]);
}

- (BOOL)validateItemIndex:(NSInteger)index {
    return index >= 0 && index < self.tabMenuItems.count;
}

- (BOOL)indicatorViewHidden {
    return !((self.configuration.indicatorWidth > 0 || self.configuration.indicatorWidth == HNWTabMenuIndicatorWidthAutomaticDimension)
             && self.configuration.indicatorHeight > 0 &&
             [self validateItemIndex:self.selectedItemIndex]);
}

#pragma mark - UI
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self layoutIfNeeded];
    [self refreshTabMenuViewAnimated:NO];
}

- (void)refreshTabMenuViewAnimated:(BOOL)animated {
    [self.collectionView reloadData];
    [self refreshIndicatorViewAnimated:animated];
    if ([self validateItemIndex:self.selectedItemIndex]) {
        if (self.collectionView.contentSize.width > self.collectionView.frame.size.width) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.selectedItemIndex inSection:0];
            [self.collectionView scrollToItemAtIndexPath:indexPath
                                        atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                                animated:animated];
        }
    }
}

- (void)refreshIndicatorViewAnimated:(BOOL)animated {
    self.indicatorView.hidden = [self indicatorViewHidden];
    if (!self.indicatorView.isHidden) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.selectedItemIndex inSection:0];
        UICollectionViewLayoutAttributes *layoutAttributes = [self.collectionView layoutAttributesForItemAtIndexPath:indexPath];
        if (layoutAttributes) {
            CGFloat x, y, w = self.configuration.indicatorWidth, h = self.configuration.indicatorHeight;
            self.indicatorView.layer.cornerRadius = h / 2.0;
            if (w == HNWTabMenuIndicatorWidthAutomaticDimension) {
                HNWTabMenuViewItem *item = [self tabMenuItemAtIndex:self.selectedItemIndex];
                w = item.titleSelectedWidth;
            }
            x = layoutAttributes.center.x - w / 2.0;
            y = layoutAttributes.size.height - h;
            CGRect newFrame = CGRectMake(x, y, w, h);
            if (animated) {
                [UIView animateWithDuration:0.25 animations:^{
                    self.indicatorView.frame = newFrame;
                }];
            } else {
                self.indicatorView.frame = newFrame;
            }
        }
    }
}

- (void)setupDefaultConfig {
    // 1.自身配置
    self.backgroundColor = [UIColor whiteColor];
    // 2.添加子视图
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.topSeparator];
    [self.contentView addSubview:self.bottomSeparator];
    [self.contentView addSubview:self.collectionView];
    [self.collectionView addSubview:self.indicatorView];
    // 3.添加约束
    [self layoutView:self.contentView equalEdgeInsetsToView:self];
    [self addConstraintsForTopSeparator];
    [self addConstraintsForBottomSeparator];
    [self layoutView:self.collectionView equalEdgeInsetsToView:self.contentView];
    // 4.更新子视图配置
    [self.collectionView registerClass:[HNWTabMenuViewCollectionViewCell class] forCellWithReuseIdentifier:@"HNWTabMenuViewCollectionViewCell"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}

- (void)addConstraintsForTopSeparator {
    self.topSeparator.translatesAutoresizingMaskIntoConstraints = NO;
    UIEdgeInsets insets = self.configuration.topSeparatorInsets;
    NSLayoutConstraint *top = HNWLayoutConstraintLiteMaker(self.topSeparator, NSLayoutAttributeTop,
                                                           self.contentView, NSLayoutAttributeTop,
                                                           insets.top);
    NSLayoutConstraint *leading = HNWLayoutConstraintLiteMaker(self.topSeparator, NSLayoutAttributeLeading,
                                                               self.contentView, NSLayoutAttributeLeading,
                                                               insets.left);
    NSLayoutConstraint *trailing = HNWLayoutConstraintLiteMaker(self.topSeparator, NSLayoutAttributeTrailing,
                                                                self.contentView, NSLayoutAttributeTrailing,
                                                                -insets.right);
    NSLayoutConstraint *height = HNWLayoutConstraintLiteMaker(self.topSeparator, NSLayoutAttributeHeight,
                                                              nil, NSLayoutAttributeNotAnAttribute,
                                                              self.configuration.topSeparatorHeight);
    [NSLayoutConstraint activateConstraints:@[top, leading, trailing, height]];
}

- (void)addConstraintsForBottomSeparator {
    self.bottomSeparator.translatesAutoresizingMaskIntoConstraints = NO;
    UIEdgeInsets insets = self.configuration.bottomSeparatorInsets;
    NSLayoutConstraint *bottom = HNWLayoutConstraintLiteMaker(self.bottomSeparator, NSLayoutAttributeBottom,
                                                              self.contentView, NSLayoutAttributeBottom,
                                                              -insets.bottom);
    NSLayoutConstraint *leading = HNWLayoutConstraintLiteMaker(self.bottomSeparator, NSLayoutAttributeLeading,
                                                               self.contentView, NSLayoutAttributeLeading,
                                                               insets.left);
    NSLayoutConstraint *trailing = HNWLayoutConstraintLiteMaker(self.bottomSeparator, NSLayoutAttributeTrailing,
                                                                self.contentView, NSLayoutAttributeTrailing,
                                                                -insets.right);
    NSLayoutConstraint *height = HNWLayoutConstraintLiteMaker(self.bottomSeparator, NSLayoutAttributeHeight,
                                                              nil, NSLayoutAttributeNotAnAttribute,
                                                              self.configuration.bottomSeparatorHeight);
    [NSLayoutConstraint activateConstraints:@[bottom, leading, trailing, height]];
}

- (void)layoutView:(UIView *)view equalEdgeInsetsToView:(UIView *)toView {
    view.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *top = HNWLayoutConstraintLiteMaker(view, NSLayoutAttributeTop, toView, NSLayoutAttributeTop, 0);
    NSLayoutConstraint *leading = HNWLayoutConstraintLiteMaker(view, NSLayoutAttributeLeading, toView, NSLayoutAttributeLeading, 0);
    NSLayoutConstraint *bottom = HNWLayoutConstraintLiteMaker(view, NSLayoutAttributeBottom, toView, NSLayoutAttributeBottom, 0);
    NSLayoutConstraint *trailing = HNWLayoutConstraintLiteMaker(view, NSLayoutAttributeTrailing, toView, NSLayoutAttributeTrailing, 0);
    [NSLayoutConstraint activateConstraints:@[top, leading, bottom, trailing]];
}

#pragma mark - getter or setter
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:self.bounds];
        _contentView.backgroundColor = [UIColor clearColor];
    }
    return _contentView;
}

- (UIView *)topSeparator {
    if (!_topSeparator) {
        _topSeparator = [[UIView alloc] initWithFrame:CGRectZero];
        _topSeparator.backgroundColor = UIColor.lightGrayColor;
        _topSeparator.userInteractionEnabled = NO;
    }
    return _topSeparator;
}

- (UIView *)bottomSeparator {
    if (!_bottomSeparator) {
        _bottomSeparator = [[UIView alloc] initWithFrame:CGRectZero];
        _bottomSeparator.backgroundColor = UIColor.lightGrayColor;
        _bottomSeparator.userInteractionEnabled = NO;
    }
    return _bottomSeparator;
}

- (UIView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIView alloc] initWithFrame:CGRectZero];
        _indicatorView.backgroundColor = self.configuration.selectedTitleColor;
        _indicatorView.userInteractionEnabled = NO;
        _indicatorView.layer.cornerRadius = self.configuration.indicatorHeight / 2.0;
    }
    return _indicatorView;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = MAX(1, self.configuration.itemSpacing);
        layout.minimumInteritemSpacing = MAX(1, self.configuration.itemSpacing);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.estimatedItemSize = CGSizeZero;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.contentView.bounds collectionViewLayout:layout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.scrollsToTop = NO;
        _collectionView.scrollEnabled = YES;
        _collectionView.bounces = NO;
        _collectionView.alwaysBounceHorizontal = NO;
        _collectionView.alwaysBounceVertical = NO;
        _collectionView.pagingEnabled = NO;
        _collectionView.contentInset = UIEdgeInsetsZero;
        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        _collectionView.backgroundColor = [UIColor clearColor];
    }
    return _collectionView;
}

- (HNWTabMenuViewConfiguration *)configuration {
    if (!_configuration) {
        _configuration = [[HNWTabMenuViewConfiguration alloc] init];
    }
    return _configuration;
}

@end
