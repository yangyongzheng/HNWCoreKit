//
//  NSString+HNWAdditions.m
//  HNWKit
//
//  Created by Young on 2019/12/28.
//  Copyright © 2019 Young. All rights reserved.
//

#import "NSString+HNWAdditions.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (HNWAdditions)

- (NSString *)hnw_MD5Encryption {
    const char *cString = self.UTF8String;
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cString, (CC_LONG)strlen(cString), digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02X", digest[i]];
    }
    
    return [output copy];
}

@end
