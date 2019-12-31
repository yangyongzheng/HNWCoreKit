//
//  UIAlertController+HNWKit.m
//  HNWKit
//
//  Created by Young on 2019/12/31.
//  Copyright © 2019 Young. All rights reserved.
//

#import "UIAlertController+HNWKit.h"

@implementation UIAlertController (HNWKit)

+ (instancetype)alertControllerWithTitle:(NSString *)title
                                 message:(NSString *)message
                          preferredStyle:(UIAlertControllerStyle)preferredStyle
                       cancelButtonTitle:(NSString *)cancelButtonTitle
                       otherButtonTitles:(NSArray<NSString *> *)otherButtonTitles
                           actionHandler:(void (^)(NSInteger))actionHandler {
    UIAlertController *vc = [self alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    
    if (cancelButtonTitle && [cancelButtonTitle isKindOfClass:[NSString class]] && cancelButtonTitle.length > 0) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle
                                                               style:UIAlertActionStyleCancel
                                                             handler:^(UIAlertAction * _Nonnull action) {
                                                                 if (actionHandler) {actionHandler(-1);}
                                                             }];
        [vc addAction:cancelAction];
    }
    
    if (otherButtonTitles && [otherButtonTitles isKindOfClass:[NSArray class]] && otherButtonTitles.count > 0) {
        NSArray<NSString *> *safeOtherButtonTitles = [otherButtonTitles copy];
        [safeOtherButtonTitles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[NSString class]] && obj.length > 0) {
                UIAlertAction *otherAction = [UIAlertAction actionWithTitle:obj
                                                                      style:UIAlertActionStyleDefault
                                                                    handler:^(UIAlertAction * _Nonnull action) {
                                                                        if (actionHandler) {actionHandler(idx);}
                                                                    }];
                [vc addAction:otherAction];
            }
        }];
    }
    
    return vc;
}

@end
