//
//  HNWPhotoManager.m
//  HNWKit
//
//  Created by Young on 2019/12/29.
//  Copyright © 2019 Young. All rights reserved.
//

#import "HNWPhotoManager.h"
#import <Photos/Photos.h>

@implementation HNWPhotoItem

+ (instancetype)itemWithFileURL:(NSURL *)fileURL videoFlag:(BOOL)isVideoFlag {
    HNWPhotoItem *item = [[[self class] alloc] init];
    item->_fileURL = fileURL;
    item->_videoFlag = isVideoFlag;
    return item;
}

@end



const NSInteger HNWPhotoAccessRestrictedErrorCode = -100000;
const NSInteger HNWPhotoSaveParameterInvalidErrorCode = -100001;

static const NSInteger HNWPhotoSaveFailedErrorCode = -100002;

@implementation HNWPhotoManager

static void HNWPrivateSafeSyncMainQueue(dispatch_block_t block) {
    if (block) {
        if (NSThread.isMainThread) {
            block();
        } else {
            dispatch_sync(dispatch_get_main_queue(), block);
        }
    }
}

#pragma mark - Public
+ (HNWPhotoManager *)sharedManager {
    static HNWPhotoManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[[self class] alloc] init];
    });
    return manager;
}

- (void)requestSaveImages:(NSArray<UIImage *> *)images completionHandler:(void (^)(NSError * _Nullable))completionHandler {
    [HNWPhotoManager precheckBeforeSave:^(BOOL granted) {
        if (granted) {
            if (images && [images isKindOfClass:[NSArray class]]) {
                [self hnw_saveImages:images completionHandler:completionHandler];
            } else {
                if (completionHandler) {completionHandler([self hnw_privateErrorWithCode:HNWPhotoSaveParameterInvalidErrorCode]);}
            }
        } else {
            if (completionHandler) {completionHandler([self hnw_privateErrorWithCode:HNWPhotoAccessRestrictedErrorCode]);}
        }
    }];
}

- (void)requestSavePhotoItems:(NSArray<HNWPhotoItem *> *)photoItems completionHandler:(void (^)(NSError * _Nullable))completionHandler {
    [HNWPhotoManager precheckBeforeSave:^(BOOL granted) {
        if (granted) {
            if (photoItems && [photoItems isKindOfClass:[NSArray class]]) {
                [self hnw_savePhotoItems:photoItems completionHandler:completionHandler];
            } else {
                if (completionHandler) {completionHandler([self hnw_privateErrorWithCode:HNWPhotoSaveParameterInvalidErrorCode]);}
            }
        } else {
            if (completionHandler) {completionHandler([self hnw_privateErrorWithCode:HNWPhotoAccessRestrictedErrorCode]);}
        }
    }];
}

#pragma mark - Misc
+ (void)precheckBeforeSave:(void (^)(BOOL granted))completion {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        HNWPrivateSafeSyncMainQueue(^{
            if (completion) {completion(status == PHAuthorizationStatusAuthorized);}
        });
    }];
}

- (void)hnw_saveImages:(NSArray<UIImage *> *)images completionHandler:(void (^)(NSError * _Nullable))completionHandler {
    if (images.count > 0) {
        __block NSArray *safeImages = [images copy];
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            for (UIImage *image in safeImages) {
                if (image && [image isKindOfClass:[UIImage class]]) {
                    [PHAssetChangeRequest creationRequestForAssetFromImage:image];
                } else {
                    NSAssert(0, @"传入的图片数组元素不合法，保存到照片失败！");
                }
            }
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            HNWPrivateSafeSyncMainQueue(^{
                if (success) {
                    if (completionHandler) {completionHandler(nil);}
                } else {
                    if (completionHandler) {completionHandler(error?:[self hnw_privateErrorWithCode:HNWPhotoSaveFailedErrorCode]);}
                }
            });
        }];
    } else {
        if (completionHandler) {completionHandler(nil);}
    }
}

- (void)hnw_savePhotoItems:(NSArray<HNWPhotoItem *> *)photoItems completionHandler:(void (^)(NSError * _Nullable))completionHandler {
    if (photoItems.count > 0) {
        __block NSArray *safePhotoItems = [photoItems copy];
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            for (HNWPhotoItem *item in safePhotoItems) {
                if (item && [item isKindOfClass:[HNWPhotoItem class]] &&
                    item.fileURL && [item.fileURL isKindOfClass:[NSURL class]]) {
                    if (item.isVideoFlag) {
                        [PHAssetChangeRequest creationRequestForAssetFromVideoAtFileURL:item.fileURL];
                    } else {
                        [PHAssetChangeRequest creationRequestForAssetFromImageAtFileURL:item.fileURL];
                    }
                } else {
                    NSAssert(0, @"传入的图片或视频文件路径错误，保存到照片失败！");
                }
            }
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            HNWPrivateSafeSyncMainQueue(^{
                if (success) {
                    if (completionHandler) {completionHandler(nil);}
                } else {
                    if (completionHandler) {completionHandler(error?:[self hnw_privateErrorWithCode:HNWPhotoSaveFailedErrorCode]);}
                }
            });
        }];
    } else {
        if (completionHandler) {completionHandler(nil);}
    }
}

- (NSError *)hnw_privateErrorWithCode:(NSInteger)errorCode {
    if (errorCode == HNWPhotoAccessRestrictedErrorCode) {
        return [NSError errorWithDomain:@"照片(相册)访问权限受限"
                                   code:HNWPhotoAccessRestrictedErrorCode
                               userInfo:@{NSLocalizedDescriptionKey : @"照片(相册)访问权限受限"}];
    } else if (errorCode == HNWPhotoSaveParameterInvalidErrorCode) {
        return [NSError errorWithDomain:@"传入参数无效，保存到照片(相册)失败"
                                   code:HNWPhotoSaveParameterInvalidErrorCode
                               userInfo:@{NSLocalizedDescriptionKey : @"传入参数无效，保存到照片(相册)失败"}];
    } else {
        return [NSError errorWithDomain:@"保存失败"
                                   code:HNWPhotoSaveFailedErrorCode
                               userInfo:@{NSLocalizedDescriptionKey : @"保存失败"}];
    }
}

@end
