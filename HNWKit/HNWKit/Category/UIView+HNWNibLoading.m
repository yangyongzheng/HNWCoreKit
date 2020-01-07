//
//  UIView+HNWNibLoading.m
//  HNWKit
//
//  Created by Young on 2019/12/31.
//  Copyright © 2019 Young. All rights reserved.
//

#import "UIView+HNWNibLoading.h"

@implementation UIView (HNWNibLoading)

+ (instancetype)hnw_viewFromNib {
    NSString *nibName = NSStringFromClass([self class]);
    return [self hnw_viewWithNibName:nibName];
}

+ (instancetype)hnw_viewWithNibName:(NSString *)nibName {
    return [self hnw_viewWithNibName:nibName bundle:NSBundle.mainBundle];
}

+ (instancetype)hnw_viewWithNibName:(NSString *)nibName bundle:(NSBundle *)bundleOrNil {
    return [self hnw_viewWithNibName:nibName bundle:bundleOrNil index:0];
}

+ (instancetype)hnw_viewWithNibName:(NSString *)nibName bundle:(NSBundle *)bundleOrNil index:(NSInteger)index {
    id findObject = nil;
    
    if (nibName && [nibName isKindOfClass:[NSString class]] && nibName.length > 0) {/* Do nothing */} else {
        nibName = NSStringFromClass([self class]);
    }
    if (bundleOrNil && [bundleOrNil isKindOfClass:[NSBundle class]]) {/* Do nothing */} else {
        bundleOrNil = NSBundle.mainBundle;
    }
    UINib *nib = [UINib nibWithNibName:nibName bundle:bundleOrNil];
    NSArray *nibObjects = [nib instantiateWithOwner:nil options:nil];
    if (nibObjects.count > 0) {
        if (index < nibObjects.count) {
            id tempObject = nibObjects[index];
            if ([tempObject isKindOfClass:[self class]]) {
                findObject = tempObject;
            }
        }
        if (!findObject) {
            for (id obj in nibObjects) {
                if ([obj isKindOfClass:[self class]]) {
                    findObject = obj;
                    break;
                }
            }
        }
    }
    
    return findObject;
}

@end
