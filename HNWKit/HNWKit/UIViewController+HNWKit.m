//
//  UIViewController+HNWKit.m
//  HNWKit
//
//  Created by Young on 2019/12/31.
//  Copyright © 2019 Young. All rights reserved.
//

#import "UIViewController+HNWKit.h"

@implementation UIViewController (HNWKit)

static NSString * const HNWKitMainStoryboardName = @"Main";

+ (instancetype)hnw_instantiateFromStoryboard {
    return [self hnw_instantiateWithStoryboardName:HNWKitMainStoryboardName];
}

+ (instancetype)hnw_instantiateWithStoryboardName:(NSString *)storyboardName {
    return [self hnw_instantiateWithStoryboardName:storyboardName bundle:NSBundle.mainBundle];
}

+ (instancetype)hnw_instantiateWithStoryboardName:(NSString *)storyboardName bundle:(NSBundle *)bundle {
    NSString *identifier = NSStringFromClass([self class]);
    return [self hnw_instantiateWithStoryboardName:storyboardName identifier:identifier bundle:bundle];
}

+ (instancetype)hnw_instantiateWithIdentifier:(NSString *)identifier {
    return [self hnw_instantiateWithStoryboardName:HNWKitMainStoryboardName identifier:identifier];
}

+ (instancetype)hnw_instantiateWithStoryboardName:(NSString *)storyboardName identifier:(NSString *)identifier {
    return [self hnw_instantiateWithStoryboardName:storyboardName identifier:identifier bundle:NSBundle.mainBundle];
}

+ (instancetype)hnw_instantiateWithStoryboardName:(NSString *)storyboardName identifier:(NSString *)identifier bundle:(NSBundle *)bundle {
    if (storyboardName && [storyboardName isKindOfClass:[NSString class]] && storyboardName.length > 0) {/** Do nothing */} else {
        storyboardName = HNWKitMainStoryboardName;
    }
    if (identifier && [identifier isKindOfClass:[NSString class]] && identifier.length > 0) {/** Do nothing */} else {
        identifier = NSStringFromClass([self class]);
    }
    if (bundle && [bundle isKindOfClass:[NSBundle class]]) {/** Do nothing */} else {
        bundle = NSBundle.mainBundle;
    }
    UIStoryboard *sb = [UIStoryboard storyboardWithName:storyboardName bundle:bundle];
    return [sb instantiateViewControllerWithIdentifier:identifier];
}

@end
