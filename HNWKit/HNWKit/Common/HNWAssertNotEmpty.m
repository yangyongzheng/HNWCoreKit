//
//  HNWAssertNotEmpty.m
//  HNWKit
//
//  Created by Young on 2019/12/24.
//  Copyright © 2019 Young. All rights reserved.
//

#import "HNWAssertNotEmpty.h"

BOOL HNWAssertStringNotEmpty(NSString *string) {
    return string && [string isKindOfClass:[NSString class]] && string.length > 0;
}

BOOL HNWAssertMutableStringNotEmpty(NSMutableString *mutableString) {
    return mutableString && [mutableString isKindOfClass:[NSMutableString class]] && mutableString.length > 0;
}


BOOL HNWAssertArrayNotEmpty(NSArray *array) {
    return array && [array isKindOfClass:[NSArray class]] && array.count > 0;
}

BOOL HNWAssertMutableArrayNotEmpty(NSMutableArray *mutableArray) {
    return mutableArray && [mutableArray isKindOfClass:[NSMutableArray class]] && mutableArray.count > 0;
}


BOOL HNWAssertDictionaryNotEmpty(NSDictionary *dictionary) {
    return dictionary && [dictionary isKindOfClass:[NSDictionary class]] && dictionary.count > 0;
}

BOOL HNWAssertMutableDictionaryNotEmpty(NSMutableDictionary *mutableDictionary) {
    return mutableDictionary && [mutableDictionary isKindOfClass:[NSMutableDictionary class]] && mutableDictionary.count > 0;
}
