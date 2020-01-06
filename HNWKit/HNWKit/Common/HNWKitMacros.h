//
//  HNWKitMacros.h
//  HNWKit
//
//  Created by Young on 2019/12/24.
//  Copyright © 2019 Young. All rights reserved.
//

#ifndef HNWKitMacros_h
#define HNWKitMacros_h

#import "HNWKitDefines.h"

/** 对象引用转换 */
#ifndef HNWKitWeakTransfer
#define HNWKitWeakTransfer(obj) __weak typeof(obj) HNWKitWeakReferenceKey(obj) = obj
#endif

#ifndef HNWKitStrongTransfer
#define HNWKitStrongTransfer(obj) __strong typeof(HNWKitWeakReferenceKey(obj)) HNWKitStrongReferenceKey(obj) = HNWKitWeakReferenceKey(obj)
#endif

#ifndef HNWKitWeakReferenceKey
#define HNWKitWeakReferenceKey(k) HNWKitTokenConcatenation(k, WeakRef)
#endif

#ifndef HNWKitStrongReferenceKey
#define HNWKitStrongReferenceKey(k) HNWKitTokenConcatenation(k, StrongRef)
#endif

/** 待定 */

#endif /* HNWKitMacros_h */
