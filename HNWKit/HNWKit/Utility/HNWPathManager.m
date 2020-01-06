//
//  HNWPathManager.m
//  HNWKit
//
//  Created by Young on 2019/12/29.
//  Copyright © 2019 Young. All rights reserved.
//

#import "HNWPathManager.h"

static NSString * const HNWUserDataDirectoryName = @"HNWUserData";

static NSString * HNWPrivateDirectoryAppendSubdirectory(NSString *directory, NSString *subdirectory) {
    NSString *fullPath = [directory stringByAppendingPathComponent:subdirectory];
    BOOL isDirectory = NO;
    BOOL isExists = [NSFileManager.defaultManager fileExistsAtPath:fullPath isDirectory:&isDirectory];
    if (isExists && isDirectory) {/** Do nothing */} else {
        [NSFileManager.defaultManager createDirectoryAtPath:fullPath
                                withIntermediateDirectories:YES
                                                 attributes:nil
                                                      error:nil];
    }
    return fullPath;
}

#pragma mark 沙盒目录绝对路径：~/Documents/HNWUserData
NSString * HNWUserDocumentsDirectory(void) {
    NSString *basePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    return HNWPrivateDirectoryAppendSubdirectory(basePath, HNWUserDataDirectoryName);
}

#pragma mark 沙盒目录绝对路径：~/Library/HNWUserData
NSString * HNWUserLibraryDirectory(void) {
    NSString *basePath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject;
    return HNWPrivateDirectoryAppendSubdirectory(basePath, HNWUserDataDirectoryName);
}

#pragma mark 沙盒目录绝对路径：~/Library/Caches/HNWUserData
NSString * HNWUserCachesDirectory(void) {
    NSString *basePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    return HNWPrivateDirectoryAppendSubdirectory(basePath, HNWUserDataDirectoryName);
}

#pragma mark 沙盒目录绝对路径：~/tmp/HNWUserData
NSString * HNWUserTemporaryDirectory(void) {
    NSString *basePath = NSTemporaryDirectory();
    return HNWPrivateDirectoryAppendSubdirectory(basePath, HNWUserDataDirectoryName);
}
