//
//  HNWTabMenuItemBadgeProvider.m
//  HNWKit
//
//  Created by Young on 2019/12/25.
//  Copyright © 2019 Young. All rights reserved.
//

#import "HNWTabMenuItemBadgeProviders.h"

@implementation HNWTabMenuItemBadgeRedDotProvider

+ (instancetype)redDotProvider {
    return [[[self class] alloc] init];
}

@end

@implementation HNWTabMenuItemBadgeTextProvider

+ (instancetype)providerWithText:(NSString *)text {
    HNWTabMenuItemBadgeTextProvider *provider = [[[self class] alloc] init];
    if (text && [text isKindOfClass:[NSString class]] && text.length > 0) {
        provider->_text = [text copy]; // copy修饰的属性
    } else {
        provider->_text = @"";
    }
    return provider;
}

@end

@implementation HNWTabMenuItemBadgeImageProvider

+ (instancetype)providerWithImage:(UIImage *)image imageSize:(CGSize)imageSize {
    HNWTabMenuItemBadgeImageProvider *provider = [[[self class] alloc] init];
    provider->_image = image;
    provider->_imageSize = imageSize;
    return provider;
}

@end
