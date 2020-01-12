//
//  HNWTransitionContainer.m
//  HNWKit
//
//  Created by Young on 2020/1/11.
//  Copyright © 2020 Young. All rights reserved.
//

#import "HNWTransitionContainer.h"

@interface HNWTransitionContainer ()
@property (nonatomic, readwrite, strong) UIView *backgroundView;
@property (nonatomic, readwrite, strong) UIView *separatorView;
@property (nonatomic, readwrite, strong) UIView *keyboardLayoutAlignmentView;
@property (nonatomic, readwrite, strong) UIView *containerView;
@property (nonatomic, weak) NSLayoutConstraint *keyboardLayoutAlignmentViewHeightConstraint;
@end

@implementation HNWTransitionContainer

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
    [self addSubview:self.separatorView];
    [self addSubview:self.keyboardLayoutAlignmentView];
    [self addSubview:self.containerView];
    [self addConstraintsForCustomView];
}

- (void)addConstraintsForCustomView {
    self.backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *top = HNWLayoutConstraintLiteMaker(self.backgroundView, NSLayoutAttributeTop, self, NSLayoutAttributeTop, 0);
    NSLayoutConstraint *leading = HNWLayoutConstraintLiteMaker(self.backgroundView, NSLayoutAttributeLeading, self, NSLayoutAttributeLeading, 0);
    NSLayoutConstraint *bottom = HNWLayoutConstraintLiteMaker(self.backgroundView, NSLayoutAttributeBottom, self, NSLayoutAttributeBottom, 0);
    NSLayoutConstraint *trailing = HNWLayoutConstraintLiteMaker(self.backgroundView, NSLayoutAttributeTrailing, self, NSLayoutAttributeTrailing, 0);
    [NSLayoutConstraint activateConstraints:@[top, leading, bottom, trailing]];
    
    self.separatorView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *top2 = HNWLayoutConstraintLiteMaker(self.separatorView, NSLayoutAttributeTop, self, NSLayoutAttributeTop, 0);
    NSLayoutConstraint *leading2 = HNWLayoutConstraintLiteMaker(self.separatorView, NSLayoutAttributeLeading, self, NSLayoutAttributeLeading, 0);
    NSLayoutConstraint *bottom2 = HNWLayoutConstraintLiteMaker(self.separatorView, NSLayoutAttributeBottom, self.keyboardLayoutAlignmentView, NSLayoutAttributeTop, 0);
    NSLayoutConstraint *trailing2 = HNWLayoutConstraintLiteMaker(self.separatorView, NSLayoutAttributeTrailing, self, NSLayoutAttributeTrailing, 0);
    [NSLayoutConstraint activateConstraints:@[top2, leading2, bottom2, trailing2]];
    
    self.keyboardLayoutAlignmentView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *leading3 = HNWLayoutConstraintLiteMaker(self.keyboardLayoutAlignmentView, NSLayoutAttributeLeading, self, NSLayoutAttributeLeading, 0);
    NSLayoutConstraint *bottom3 = HNWLayoutConstraintLiteMaker(self.keyboardLayoutAlignmentView, NSLayoutAttributeBottom, self, NSLayoutAttributeBottom, 0);
    NSLayoutConstraint *trailing3 = HNWLayoutConstraintLiteMaker(self.keyboardLayoutAlignmentView, NSLayoutAttributeTrailing, self, NSLayoutAttributeTrailing, 0);
    NSLayoutConstraint *height3 = HNWLayoutConstraintLiteMaker(self.keyboardLayoutAlignmentView, NSLayoutAttributeHeight, nil, NSLayoutAttributeNotAnAttribute, 0);
    [NSLayoutConstraint activateConstraints:@[leading3, bottom3, trailing3, height3]];
    self.keyboardLayoutAlignmentViewHeightConstraint = height3;
    
    self.containerView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *top4 = HNWLayoutConstraintLiteMaker(self.containerView, NSLayoutAttributeTop, self.separatorView, NSLayoutAttributeTop, 0);
    NSLayoutConstraint *leading4 = HNWLayoutConstraintLiteMaker(self.containerView, NSLayoutAttributeLeading, self.separatorView, NSLayoutAttributeLeading, 0);
    NSLayoutConstraint *bottom4 = HNWLayoutConstraintLiteMaker(self.containerView, NSLayoutAttributeBottom, self.separatorView, NSLayoutAttributeBottom, 0);
    NSLayoutConstraint *trailing4 = HNWLayoutConstraintLiteMaker(self.containerView, NSLayoutAttributeTrailing, self.separatorView, NSLayoutAttributeTrailing, 0);
    [NSLayoutConstraint activateConstraints:@[top4, leading4, bottom4, trailing4]];
}

- (void)setKeyboardLayoutAlignmentViewHeight:(CGFloat)keyboardLayoutAlignmentViewHeight {
    _keyboardLayoutAlignmentViewHeight = keyboardLayoutAlignmentViewHeight;
    if (self.keyboardLayoutAlignmentViewHeightConstraint) {
        self.keyboardLayoutAlignmentViewHeightConstraint.constant = keyboardLayoutAlignmentViewHeight;
    }
}

- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        _backgroundView.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.6];
    }
    return _backgroundView;
}

- (UIView *)separatorView {
    if (!_separatorView) {
        _separatorView = [[UIView alloc] initWithFrame:self.bounds];
        _separatorView.userInteractionEnabled = NO;
    }
    return _separatorView;
}

- (UIView *)keyboardLayoutAlignmentView {
    if (!_keyboardLayoutAlignmentView) {
        _keyboardLayoutAlignmentView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _keyboardLayoutAlignmentView;
}

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] initWithFrame:self.bounds];
    }
    return _containerView;
}

@end
