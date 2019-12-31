//
//  NSString+HNWKit.h
//  HNWKit
//
//  Created by Young on 2019/12/31.
//  Copyright © 2019 Young. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (HNWKit)

/** MD5加密后的字符串（大写字母数字组合） */
@property (nonatomic, readonly, copy) NSString *hnw_MD5Encryption;

@end

NS_ASSUME_NONNULL_END
