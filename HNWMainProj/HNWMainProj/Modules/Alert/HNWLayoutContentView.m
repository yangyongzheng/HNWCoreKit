//
//  HNWLayoutContentView.m
//  HNWMainProj
//
//  Created by Young on 2020/1/12.
//  Copyright © 2020 Young. All rights reserved.
//

#import "HNWLayoutContentView.h"

@interface HNWLayoutContentView ()
@property (nonatomic, readwrite, strong) UIView *backgroundView;
@property (nonatomic, readwrite, strong) UIView *bottomLayoutGuideView;
@property (nonatomic, readwrite, strong) UIView *barrierView;
@property (nonatomic, readwrite, strong) UIView *contentView;
@property (nonatomic, weak) NSLayoutConstraint *bottomLayoutGuideHeightConstraint;
@end

@implementation HNWLayoutContentView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupBasicEnvironment];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setupBasicEnvironment];
    }
    return self;
}

- (void)setupBasicEnvironment {
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.backgroundView];
    [self addSubview:self.bottomLayoutGuideView];
    [self addSubview:self.barrierView];
    [self addSubview:self.contentView];
    [self addConstraintsForCustomView];
    [self layoutIfNeeded];
}

- (void)addConstraintsForCustomView {
    HNWLayoutConstraintsEqualEdgeInsets(self.backgroundView, self, UIEdgeInsetsZero);
    
    self.bottomLayoutGuideView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *leading = HNWLayoutConstraintLiteMaker(self.bottomLayoutGuideView, NSLayoutAttributeLeading, self, NSLayoutAttributeLeading, 0);
    NSLayoutConstraint *bottom = HNWLayoutConstraintLiteMaker(self.bottomLayoutGuideView, NSLayoutAttributeBottom, self, NSLayoutAttributeBottom, 0);
    NSLayoutConstraint *trailing = HNWLayoutConstraintLiteMaker(self.bottomLayoutGuideView, NSLayoutAttributeTrailing, self, NSLayoutAttributeTrailing, 0);
    NSLayoutConstraint *height = HNWLayoutConstraintLiteMaker(self.bottomLayoutGuideView, NSLayoutAttributeHeight, nil, NSLayoutAttributeNotAnAttribute, 0);
    [NSLayoutConstraint activateConstraints:@[leading, bottom, trailing, height]];
    self.bottomLayoutGuideHeightConstraint = height;
    
    self.barrierView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *top2 = HNWLayoutConstraintLiteMaker(self.barrierView, NSLayoutAttributeTop, self, NSLayoutAttributeTop, 0);
    NSLayoutConstraint *leading2 = HNWLayoutConstraintLiteMaker(self.barrierView, NSLayoutAttributeLeading, self, NSLayoutAttributeLeading, 0);
    NSLayoutConstraint *bottom2 = HNWLayoutConstraintLiteMaker(self.barrierView, NSLayoutAttributeBottom, self.bottomLayoutGuideView, NSLayoutAttributeTop, 0);
    NSLayoutConstraint *trailing2 = HNWLayoutConstraintLiteMaker(self.barrierView, NSLayoutAttributeTrailing, self, NSLayoutAttributeTrailing, 0);
    [NSLayoutConstraint activateConstraints:@[top2, leading2, bottom2, trailing2]];
    
    HNWLayoutConstraintsEqualEdgeInsets(self.contentView, self.barrierView, UIEdgeInsetsZero);
}

- (void)setBottomLayoutGuideHeight:(CGFloat)bottomLayoutGuideHeight {
    [self setBottomLayoutGuideHeight:bottomLayoutGuideHeight animated:NO];
}

- (void)setBottomLayoutGuideHeight:(CGFloat)bottomLayoutGuideHeight animated:(BOOL)animated {
    _bottomLayoutGuideHeight = bottomLayoutGuideHeight;
    self.bottomLayoutGuideHeightConstraint.constant = bottomLayoutGuideHeight;
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            [self layoutIfNeeded];
        }];
    } else {
        [self layoutIfNeeded];
    }
}

- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
        _backgroundView.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.6];
    }
    return _backgroundView;
}

- (UIView *)bottomLayoutGuideView {
    if (!_bottomLayoutGuideView) {
        _bottomLayoutGuideView = [[UIView alloc] initWithFrame:CGRectZero];
        _bottomLayoutGuideView.userInteractionEnabled = NO;
        _bottomLayoutGuideView.hidden = YES;
    }
    return _bottomLayoutGuideView;
}

- (UIView *)barrierView {
    if (!_barrierView) {
        _barrierView = [[UIView alloc] initWithFrame:CGRectZero];
        _barrierView.userInteractionEnabled = NO;
    }
    return _barrierView;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _contentView;
}

@end
