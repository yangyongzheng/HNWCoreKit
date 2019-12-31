//
//  UIView+HNWKit.m
//  HNWKit
//
//  Created by Young on 2019/12/31.
//  Copyright © 2019 Young. All rights reserved.
//

#import "UIView+HNWKit.h"

@implementation UIView (HNWKit)

- (void)setHnw_minX:(CGFloat)hnw_minX {
    CGRect frame = self.frame;
    frame.origin.x = hnw_minX;
    self.frame = frame;
}

- (CGFloat)hnw_minX {
    return self.frame.origin.x;
}


-(void)setHnw_midX:(CGFloat)hnw_midX {
    CGPoint center = self.center;
    center.x = hnw_midX;
    self.center = center;
}

- (CGFloat)hnw_midX {
    return self.center.x;
}


- (void)setHnw_maxX:(CGFloat)hnw_maxX {
    CGRect frame = self.frame;
    frame.origin.x = hnw_maxX - frame.size.width;
    self.frame = frame;
}

- (CGFloat)hnw_maxX {
    return CGRectGetMaxX(self.frame);
}


- (void)setHnw_minY:(CGFloat)hnw_minY {
    CGRect frame = self.frame;
    frame.origin.y = hnw_minY;
    self.frame = frame;
}

- (CGFloat)hnw_minY {
    return self.frame.origin.y;
}


- (void)setHnw_midY:(CGFloat)hnw_midY {
    CGPoint center = self.center;
    center.y = hnw_midY;
    self.center = center;
}

- (CGFloat)hnw_midY {
    return self.center.y;
}


- (void)setHnw_maxY:(CGFloat)hnw_maxY {
    CGRect frame = self.frame;
    frame.origin.y = hnw_maxY - frame.size.height;
    self.frame = frame;
}

- (CGFloat)hnw_maxY {
    return CGRectGetMaxY(self.frame);
}


- (void)setHnw_width:(CGFloat)hnw_width {
    CGRect frame = self.frame;
    frame.size.width = hnw_width;
    self.frame = frame;
}

- (CGFloat)hnw_width {
    return self.frame.size.width;
}


- (void)setHnw_height:(CGFloat)hnw_height {
    CGRect frame = self.frame;
    frame.size.height = hnw_height;
    self.frame = frame;
}

- (CGFloat)hnw_height {
    return self.frame.size.height;
}


- (void)setHnw_origin:(CGPoint)hnw_origin {
    CGRect frame = self.frame;
    frame.origin = hnw_origin;
    self.frame = frame;
}

- (CGPoint)hnw_origin {
    return self.frame.origin;
}


- (void)setHnw_size:(CGSize)hnw_size {
    CGRect frame = self.frame;
    frame.size = hnw_size;
    self.frame = frame;
}

- (CGSize)hnw_size {
    return self.frame.size;
}

@end

@implementation UIView (HNWKitNibLoading)

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
    
    if (nibName && [nibName isKindOfClass:[NSString class]] && nibName.length > 0) {/** Do nothing */} else {
        nibName = NSStringFromClass([self class]);
    }
    if (bundleOrNil && [bundleOrNil isKindOfClass:[NSBundle class]]) {/** Do nothing */} else {
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
