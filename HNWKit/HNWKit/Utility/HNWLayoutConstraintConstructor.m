//
//  HNWLayoutConstraintConstructor.m
//  HNWKit
//
//  Created by Young on 2019/12/25.
//  Copyright © 2019 Young. All rights reserved.
//

#import "HNWLayoutConstraintConstructor.h"

NSLayoutConstraint * HNWLayoutConstraintMaker(id view1, NSLayoutAttribute attr1,
                                              NSLayoutRelation relation,
                                              id _Nullable view2, NSLayoutAttribute attr2,
                                              CGFloat multiplier,
                                              CGFloat constant) {
    return [NSLayoutConstraint constraintWithItem:view1
                                        attribute:attr1
                                        relatedBy:relation
                                           toItem:view2
                                        attribute:attr2
                                       multiplier:multiplier
                                         constant:constant];
}

NSLayoutConstraint * HNWLayoutConstraintLiteMaker(id view1, NSLayoutAttribute attr1,
                                                  id _Nullable view2, NSLayoutAttribute attr2,
                                                  CGFloat constant) {
    return HNWLayoutConstraintMaker(view1, attr1, NSLayoutRelationEqual, view2, attr2, 1.0, constant);
}

NSArray<NSLayoutConstraint *> * HNWAddConstraintsForViewEdgeInsetsToView(UIView *view, UIView *toView, UIEdgeInsets insets) {
    if (view && [view isKindOfClass:[UIView class]] && toView) {
        view.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *top = HNWLayoutConstraintLiteMaker(view, NSLayoutAttributeTop, toView, NSLayoutAttributeTop, insets.top);
        NSLayoutConstraint *leading = HNWLayoutConstraintLiteMaker(view, NSLayoutAttributeLeading, toView, NSLayoutAttributeLeading, insets.left);
        NSLayoutConstraint *bottom = HNWLayoutConstraintLiteMaker(view, NSLayoutAttributeBottom, toView, NSLayoutAttributeBottom, -insets.bottom);
        NSLayoutConstraint *trailing = HNWLayoutConstraintLiteMaker(view, NSLayoutAttributeTrailing, toView, NSLayoutAttributeTrailing, -insets.right);
        NSArray *constraints = @[top, leading, bottom, trailing];
        [NSLayoutConstraint activateConstraints:constraints];
        return constraints;
    } else {
        return nil;
    }
}
