//
//  UIApplication+HNWKit.m
//  HNWMainProj
//
//  Created by Young on 2020/1/14.
//  Copyright © 2020 Young. All rights reserved.
//

#import "UIApplication+HNWKit.h"

@implementation UIApplication (HNWKit)

- (void)hnw_openURL:(NSURL *)url completionHandler:(void (^)(BOOL))completionHandler {
    if (NSThread.isMainThread) {
        if (@available(iOS 10.0, *)) {
            [self openURL:url options:@{} completionHandler:completionHandler];
        } else {
            BOOL success = [self openURL:url];
            if (completionHandler) {completionHandler(success);}
        }
    } else {
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (@available(iOS 10.0, *)) {
                [self openURL:url options:@{} completionHandler:completionHandler];
            } else {
                BOOL success = [self openURL:url];
                if (completionHandler) {completionHandler(success);}
            }
        });
    }
}

@end
