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
#ifndef HNWKitStringConverter
#define HNWKitStringConverter(str) @HNWKitCStringizing(str)
#endif

#ifndef HNWKitCStringizing
#define HNWKitCStringizing(s) #s
#endif

/** 拼接Token */
#ifndef HNWKitTokenConcat
#define HNWKitTokenConcat(t1, t2) t1 ## t2
#endif

/** 对象引用转换 */
#ifndef HNWKitWeakTransfer
#define HNWKitWeakTransfer(obj) __weak typeof(obj) HNWKitKeyWeakRef(obj) = obj
#endif

#ifndef HNWKitStrongTransfer
#define HNWKitStrongTransfer(obj) __strong typeof(HNWKitKeyWeakRef(obj)) HNWKitKeyStrongRef(obj) = HNWKitKeyWeakRef(obj)
#endif

#ifndef HNWKitKeyWeakRef
#define HNWKitKeyWeakRef(k) HNWKitTokenConcat(k, WeakRef)
#endif

#ifndef HNWKitKeyStrongRef
#define HNWKitKeyStrongRef(k) HNWKitTokenConcat(k, StrongRef)
#endif

#endif /* HNWKitDefines_h */
