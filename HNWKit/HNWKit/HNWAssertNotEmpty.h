//
//  HNWAssertNotEmpty.h
//  HNWKit
//
//  Created by Young on 2019/12/24.
//  Copyright © 2019 Young. All rights reserved.
//

#import "HNWKitDefines.h"

NS_ASSUME_NONNULL_BEGIN

HNWKIT_EXTERN BOOL HNWAssertStringNotEmpty(NSString *string);
HNWKIT_EXTERN BOOL HNWAssertMutableStringNotEmpty(NSMutableString *mutableString);

HNWKIT_EXTERN BOOL HNWAssertArrayNotEmpty(NSArray *array);
HNWKIT_EXTERN BOOL HNWAssertMutableArrayNotEmpty(NSMutableArray *mutableArray);

HNWKIT_EXTERN BOOL HNWAssertDictionaryNotEmpty(NSDictionary *dictionary);
HNWKIT_EXTERN BOOL HNWAssertMutableDictionaryNotEmpty(NSMutableDictionary *mutableDictionary);

NS_ASSUME_NONNULL_END
