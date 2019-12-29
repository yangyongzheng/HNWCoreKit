//
//  HNWPhotoManager.m
//  HNWKit
//
//  Created by Young on 2019/12/29.
//  Copyright © 2019 Young. All rights reserved.
//

#import "HNWPhotoManager.h"
#import <Photos/Photos.h>

@implementation HNWPhotoMediaItem

+ (instancetype)itemWithFileURL:(NSURL *)fileURL videoType:(BOOL)videoType {
    HNWPhotoMediaItem *item = [[[self class] alloc] init];
    item->_fileURL = fileURL;
    item->_videoType = videoType;
    return item;
}

@end



const NSInteger HNWPhotoAccessRestrictedErrorCode = -100000;
const NSInteger HNWPhotoSaveParameterInvalidErrorCode = -100001;


@implementation HNWPhotoManager

static const NSInteger HNWPhotoSaveFailedErrorCode = -100002;

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

- (void)requestSaveImages:(NSArray<UIImage *> *)images
             successBlock:(void (^)(void))successBlock
             failureBlock:(void (^)(NSError * _Nonnull))failureBlock {
    [HNWPhotoManager precheckBeforeSave:^(BOOL granted) {
        if (granted) {
            if (images && [images isKindOfClass:[NSArray class]]) {
                [self hnw_saveImages:images successBlock:successBlock failureBlock:failureBlock];
            } else {
                if (failureBlock) {failureBlock([self hnw_privateErrorWithCode:HNWPhotoSaveParameterInvalidErrorCode]);}
            }
        } else {
            if (failureBlock) {failureBlock([self hnw_privateErrorWithCode:HNWPhotoAccessRestrictedErrorCode]);}
        }
    }];
}

- (void)requestSaveMediaItems:(NSArray<HNWPhotoMediaItem *> *)mediaItems
                 successBlock:(void (^)(void))successBlock
                 failureBlock:(void (^)(NSError * _Nonnull))failureBlock {
    [HNWPhotoManager precheckBeforeSave:^(BOOL granted) {
        if (granted) {
            if (mediaItems && [mediaItems isKindOfClass:[NSArray class]]) {
                [self hnw_saveMediaItems:mediaItems successBlock:successBlock failureBlock:failureBlock];
            } else {
                if (failureBlock) {failureBlock([self hnw_privateErrorWithCode:HNWPhotoSaveParameterInvalidErrorCode]);}
            }
        } else {
            if (failureBlock) {failureBlock([self hnw_privateErrorWithCode:HNWPhotoAccessRestrictedErrorCode]);}
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

- (void)hnw_saveImages:(NSArray<UIImage *> *)images
          successBlock:(void (^)(void))successBlock
          failureBlock:(void (^)(NSError * _Nonnull))failureBlock {
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
                    if (successBlock) {successBlock();}
                } else {
                    if (failureBlock) {failureBlock(error?:[self hnw_privateErrorWithCode:HNWPhotoSaveFailedErrorCode]);}
                }
            });
        }];
    } else {
        if (successBlock) {successBlock();}
    }
}

- (void)hnw_saveMediaItems:(NSArray<HNWPhotoMediaItem *> *)mediaItems
              successBlock:(void (^)(void))successBlock
              failureBlock:(void (^)(NSError * _Nonnull))failureBlock {
    if (mediaItems.count > 0) {
        __block NSArray *safeMediaItems = [mediaItems copy];
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            for (HNWPhotoMediaItem *item in safeMediaItems) {
                if (item && [item isKindOfClass:[HNWPhotoMediaItem class]] &&
                    item.fileURL && [item.fileURL isKindOfClass:[NSURL class]]) {
                    if (item.isVideoType) {
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
                    if (successBlock) {successBlock();}
                } else {
                    if (failureBlock) {failureBlock(error?:[self hnw_privateErrorWithCode:HNWPhotoSaveFailedErrorCode]);}
                }
            });
        }];
    } else {
        if (successBlock) {successBlock();}
    }
}

- (NSError *)hnw_privateErrorWithCode:(NSInteger)errorCode {
    if (errorCode == HNWPhotoAccessRestrictedErrorCode) {
        return [NSError errorWithDomain:@"照片(相册)访问权限受限"
                                   code:HNWPhotoAccessRestrictedErrorCode
                               userInfo:@{NSLocalizedDescriptionKey : @"照片(相册)访问权限受限"}];
    } else {
        return [NSError errorWithDomain:@"保存失败"
                                   code:HNWPhotoSaveFailedErrorCode
                               userInfo:@{NSLocalizedDescriptionKey : @"保存失败"}];
    }
}

@end
