//
//  HNWTabMenuViewCollectionViewCell.m
//  HNWKit
//
//  Created by Young on 2019/12/25.
//  Copyright © 2019 Young. All rights reserved.
//

#import "HNWTabMenuViewCollectionViewCell.h"
#import "HNWLayoutConstraintConstructor.h"

@interface HNWTabMenuViewCollectionViewCell ()
@property (nonatomic, copy) NSArray<NSLayoutConstraint *> *badgeImageViewConstraints;   // [leading, bottom, width, height]
@property (nonatomic, copy) NSArray<NSLayoutConstraint *> *badgeTextViewConstraints;    // [leading, bottom, width, height]
@end

@implementation HNWTabMenuViewCollectionViewCell

@synthesize titleLabel = _titleLabel;
@synthesize badgeImageView = _badgeImageView;
@synthesize badgeTextView = _badgeTextView;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.clearColor;
        self.clipsToBounds = NO;
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.badgeImageView];
        [self.contentView addSubview:self.badgeTextView];
        [self addConstraintsForTitleLabel];
        [self addConstraintForBadgeView];
        self.badgeImageView.hidden = YES;
        self.badgeTextView.hidden = YES;
    }
    return self;
}

- (void)resetBadgeWithProvider:(id<HNWTabMenuItemBadgeProvider>)badgeProvider {
    if (badgeProvider && [badgeProvider isKindOfClass:[HNWTabMenuItemBadgeRedDotProvider class]]) {
        self.badgeImageView.hidden = NO;
        self.badgeTextView.hidden = YES;
        self.badgeImageView.image = nil;
        self.badgeImageView.backgroundColor = UIColor.redColor;
        self.badgeImageView.layer.cornerRadius = 4;
        self.badgeImageView.layer.masksToBounds = YES;
        self.badgeImageViewConstraints[1].constant = 3;
        self.badgeImageViewConstraints[2].constant = 8;
        self.badgeImageViewConstraints[3].constant = 8;
    } else if (badgeProvider && [badgeProvider isKindOfClass:[HNWTabMenuItemBadgeTextProvider class]]) {
        self.badgeImageView.hidden = YES;
        self.badgeTextView.hidden = NO;
        HNWTabMenuItemBadgeTextProvider *textProvider = (HNWTabMenuItemBadgeTextProvider *)badgeProvider;
        [self.badgeTextView setTitle:textProvider.text forState:UIControlStateNormal];
    } else if (badgeProvider && [badgeProvider isKindOfClass:[HNWTabMenuItemBadgeImageProvider class]]) {
        self.badgeImageView.hidden = NO;
        self.badgeTextView.hidden = YES;
        HNWTabMenuItemBadgeImageProvider *imageProvider = (HNWTabMenuItemBadgeImageProvider *)badgeProvider;
        self.badgeImageView.image = imageProvider.image;
        self.badgeImageView.backgroundColor = UIColor.clearColor;
        self.badgeImageView.layer.cornerRadius = 0;
        self.badgeImageView.layer.masksToBounds = NO;
        self.badgeImageViewConstraints[1].constant = 5;
        self.badgeImageViewConstraints[2].constant = imageProvider.imageSize.width;
        self.badgeImageViewConstraints[3].constant = imageProvider.imageSize.height;
    } else {
        self.badgeImageView.hidden = YES;
        self.badgeTextView.hidden = YES;
    }
}

- (void)addConstraintsForTitleLabel {
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *centerX = HNWLayoutConstraintLiteMaker(self.titleLabel, NSLayoutAttributeCenterX,
                                                               self.contentView, NSLayoutAttributeCenterX,
                                                               0);
    NSLayoutConstraint *centerY = HNWLayoutConstraintLiteMaker(self.titleLabel, NSLayoutAttributeCenterY,
                                                               self.contentView, NSLayoutAttributeCenterY,
                                                               0);
    NSLayoutConstraint *leading = HNWLayoutConstraintMaker(self.titleLabel, NSLayoutAttributeLeading,
                                                           NSLayoutRelationGreaterThanOrEqual,
                                                           self.contentView, NSLayoutAttributeLeading,
                                                           1.0,
                                                           0);
    [NSLayoutConstraint activateConstraints:@[centerX, centerY, leading]];
}

- (void)addConstraintForBadgeView {
    // badge image
    self.badgeImageView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *leading = HNWLayoutConstraintLiteMaker(self.badgeImageView, NSLayoutAttributeLeading,
                                                               self.titleLabel, NSLayoutAttributeTrailing,
                                                               -3);
    NSLayoutConstraint *bottom = HNWLayoutConstraintLiteMaker(self.badgeImageView, NSLayoutAttributeBottom,
                                                              self.titleLabel, NSLayoutAttributeTop,
                                                              3);
    NSLayoutConstraint *width = HNWLayoutConstraintLiteMaker(self.badgeImageView, NSLayoutAttributeWidth,
                                                             nil, NSLayoutAttributeNotAnAttribute,
                                                             8);
    NSLayoutConstraint *height = HNWLayoutConstraintLiteMaker(self.badgeImageView, NSLayoutAttributeHeight,
                                                              nil, NSLayoutAttributeNotAnAttribute,
                                                              8);
    self.badgeImageViewConstraints = @[leading, bottom, width, height];
    [NSLayoutConstraint activateConstraints:self.badgeImageViewConstraints];
    // badge text
    self.badgeTextView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *leading2 = HNWLayoutConstraintLiteMaker(self.badgeTextView, NSLayoutAttributeLeading,
                                                                self.titleLabel, NSLayoutAttributeTrailing,
                                                                -3);
    NSLayoutConstraint *bottom2 = HNWLayoutConstraintLiteMaker(self.badgeTextView, NSLayoutAttributeBottom,
                                                               self.titleLabel, NSLayoutAttributeTop,
                                                               5);
    NSLayoutConstraint *width2 = HNWLayoutConstraintMaker(self.badgeTextView, NSLayoutAttributeWidth,
                                                          NSLayoutRelationGreaterThanOrEqual,
                                                          self.badgeTextView, NSLayoutAttributeHeight,
                                                          1.0,
                                                          0);
    NSLayoutConstraint *height2 = HNWLayoutConstraintLiteMaker(self.badgeTextView, NSLayoutAttributeHeight,
                                                               nil, NSLayoutAttributeNotAnAttribute,
                                                               [self badgeTextHeight]);
    self.badgeTextViewConstraints = @[leading2, bottom2, width2, height2];
    [NSLayoutConstraint activateConstraints:self.badgeTextViewConstraints];
}

- (CGFloat)badgeTextHeight {
    return 15;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = UIColor.blackColor;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 1;
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _titleLabel.backgroundColor = UIColor.clearColor;
        _titleLabel.userInteractionEnabled = NO;
    }
    return _titleLabel;
}

- (UIImageView *)badgeImageView {
    if (!_badgeImageView) {
        _badgeImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _badgeImageView.contentMode = UIViewContentModeScaleToFill;
        _badgeImageView.backgroundColor = UIColor.redColor;
        _badgeImageView.userInteractionEnabled = NO;
    }
    return _badgeImageView;
}

- (UIButton *)badgeTextView {
    if (!_badgeTextView) {
        _badgeTextView = [UIButton buttonWithType:UIButtonTypeCustom];
        [_badgeTextView setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _badgeTextView.backgroundColor = UIColor.redColor;
        _badgeTextView.adjustsImageWhenDisabled = NO;
        _badgeTextView.adjustsImageWhenHighlighted = NO;
        _badgeTextView.userInteractionEnabled = NO;
        _badgeTextView.layer.cornerRadius = [self badgeTextHeight] / 2.0;
        _badgeTextView.layer.masksToBounds = YES;
        _badgeTextView.titleLabel.font = [UIFont boldSystemFontOfSize:11];
        _badgeTextView.contentEdgeInsets = UIEdgeInsetsMake(0, 2, 0, 2);
        _badgeTextView.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        _badgeTextView.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    }
    return _badgeTextView;
}

@end
