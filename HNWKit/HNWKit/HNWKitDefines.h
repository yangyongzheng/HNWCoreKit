//
//  HNWKitDefines.h
//  HNWKit
//
//  Created by Young on 2019/12/24.
//  Copyright © 2019 Young. All rights reserved.
//

#ifndef HNWKitDefines_h
#define HNWKitDefines_h

#import <UIKit/UIKit.h>

#ifndef HNWKIT_EXTERN
#define HNWKIT_EXTERN UIKIT_EXTERN
#endif

#ifndef HNWKIT_STATIC_INLINE
#define HNWKIT_STATIC_INLINE UIKIT_STATIC_INLINE
#endif

/** 字符串化 */
#ifndef HNWKitStringizing
#define HNWKitStringizing(s) #s
#endif

/** 拼接Token */
#ifndef HNWKitTokenConcatenation
#define HNWKitTokenConcatenation(t1, t2) t1 ## t2
#endif

#ifndef HNWKitFileName
#define HNWKitFileName [NSString stringWithUTF8String:__FILE__].lastPathComponent
#endif

#endif /* HNWKitDefines_h */
