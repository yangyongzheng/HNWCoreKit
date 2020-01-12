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

void HNWLayoutConstraintsEqualEdgeInsets(UIView *view1, UIView *view2, UIEdgeInsets insets) {
    view1.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *top = HNWLayoutConstraintLiteMaker(view1, NSLayoutAttributeTop, view2, NSLayoutAttributeTop, insets.top);
    NSLayoutConstraint *leading = HNWLayoutConstraintLiteMaker(view1, NSLayoutAttributeLeading, view2, NSLayoutAttributeLeading, insets.left);
    NSLayoutConstraint *bottom = HNWLayoutConstraintLiteMaker(view1, NSLayoutAttributeBottom, view2, NSLayoutAttributeBottom, -insets.bottom);
    NSLayoutConstraint *trailing = HNWLayoutConstraintLiteMaker(view1, NSLayoutAttributeTrailing, view2, NSLayoutAttributeTrailing, -insets.right);
    [NSLayoutConstraint activateConstraints:@[top, leading, bottom, trailing]];
}
