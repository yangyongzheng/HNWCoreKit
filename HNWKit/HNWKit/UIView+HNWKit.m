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
