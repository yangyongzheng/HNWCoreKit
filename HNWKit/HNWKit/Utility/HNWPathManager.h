//
//  HNWPathManager.h
//  HNWKit
//
//  Created by Young on 2019/12/29.
//  Copyright © 2019 Young. All rights reserved.
//

#import "HNWKitDefines.h"

NS_ASSUME_NONNULL_BEGIN

/** 沙盒目录绝对路径：~/Documents/HNWUserData */
HNWKIT_EXTERN NSString * HNWUserDocumentsDirectory(void);

/** 沙盒目录绝对路径：~/Library/HNWUserData */
HNWKIT_EXTERN NSString * HNWUserLibraryDirectory(void);

/** 沙盒目录绝对路径：~/Library/Caches/HNWUserData */
HNWKIT_EXTERN NSString * HNWUserCachesDirectory(void);

/** 沙盒目录绝对路径：~/tmp/HNWUserData */
HNWKIT_EXTERN NSString * HNWUserTemporaryDirectory(void);

NS_ASSUME_NONNULL_END
