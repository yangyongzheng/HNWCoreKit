//
//  HNWLayoutConstraintConstructor.h
//  HNWKit
//
//  Created by Young on 2019/12/25.
//  Copyright © 2019 Young. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

UIKIT_EXTERN NSLayoutConstraint * HNWLayoutConstraintMaker(id view1, NSLayoutAttribute attr1,
                                                           NSLayoutRelation relation,
                                                           id _Nullable view2, NSLayoutAttribute attr2,
                                                           CGFloat multiplier,
                                                           CGFloat constant);

UIKIT_EXTERN NSLayoutConstraint * HNWLayoutConstraintLiteMaker(id view1, NSLayoutAttribute attr1,
                                                               id _Nullable view2, NSLayoutAttribute attr2,
                                                               CGFloat constant);

UIKIT_EXTERN NSArray<NSLayoutConstraint *> * _Nullable HNWAddConstraintsForViewEdgeInsetsToView(UIView *view, UIView *toView, UIEdgeInsets insets);

NS_ASSUME_NONNULL_END
