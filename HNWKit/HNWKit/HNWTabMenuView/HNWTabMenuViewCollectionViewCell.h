//
//  HNWTabMenuViewCollectionViewCell.h
//  HNWKit
//
//  Created by Young on 2019/12/25.
//  Copyright © 2019 Young. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HNWTabMenuItemBadgeProviders.h"

NS_ASSUME_NONNULL_BEGIN

@interface HNWTabMenuViewCollectionViewCell : UICollectionViewCell

@property (nonatomic, readonly, strong) UILabel *titleLabel;
@property (nonatomic, readonly, strong) UIImageView *badgeImageView;
@property (nonatomic, readonly, strong) UIButton *badgeTextView;

- (void)resetBadgeWithProvider:(id<HNWTabMenuItemBadgeProvider>)badgeProvider;

@end

NS_ASSUME_NONNULL_END
