//
//  HNWPhotoManager.h
//  HNWKit
//
//  Created by Young on 2019/12/29.
//  Copyright © 2019 Young. All rights reserved.
//

#import "HNWKitDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface HNWPhotoItem : NSObject
/** 图片/视频文件URL */
@property (nonatomic, readonly, copy) NSURL *fileURL;
/** 是否是视频文件 */
@property (nonatomic, readonly, getter=isVideoFlag) BOOL videoFlag;

+ (instancetype)itemWithFileURL:(NSURL *)fileURL videoFlag:(BOOL)isVideoFlag;
@end



/** 照片(相册)访问权限受限错误Code */
HNWKIT_EXTERN const NSInteger HNWPhotoAccessRestrictedErrorCode;

/** 保存图片/视频入参非法错误Code */
HNWKIT_EXTERN const NSInteger HNWPhotoSaveParameterInvalidErrorCode;


NS_CLASS_AVAILABLE_IOS(8_0) @interface HNWPhotoManager : NSObject

@property (class, readonly, strong) HNWPhotoManager *sharedManager;

- (void)requestSaveImages:(NSArray<UIImage *> *)images completionHandler:(void (^)(NSError * _Nullable aError))completionHandler;

- (void)requestSavePhotoItems:(NSArray<HNWPhotoItem *> *)photoItems completionHandler:(void (^)(NSError * _Nullable aError))completionHandler;

@end

NS_ASSUME_NONNULL_END
