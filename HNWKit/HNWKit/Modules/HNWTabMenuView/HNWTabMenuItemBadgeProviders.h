//
//  HNWTabMenuItemBadgeProvider.h
//  HNWKit
//
//  Created by Young on 2019/12/25.
//  Copyright © 2019 Young. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HNWTabMenuItemBadgeProvider <NSObject>

@end

@interface HNWTabMenuItemBadgeRedDotProvider : NSObject <HNWTabMenuItemBadgeProvider>
+ (instancetype)redDotProvider;
@end



@interface HNWTabMenuItemBadgeTextProvider : NSObject <HNWTabMenuItemBadgeProvider>
+ (instancetype)providerWithText:(NSString *)text;

@property (nonatomic, readonly, copy) NSString *text;
@end



@interface HNWTabMenuItemBadgeImageProvider : NSObject <HNWTabMenuItemBadgeProvider>
+ (instancetype)providerWithImage:(UIImage *)image imageSize:(CGSize)imageSize;

@property (nonatomic, readonly, strong) UIImage *image;
@property (nonatomic, readonly) CGSize imageSize;
@end

NS_ASSUME_NONNULL_END
