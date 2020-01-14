//
//  UIApplication+HNWKit.m
//  HNWMainProj
//
//  Created by Young on 2020/1/14.
//  Copyright © 2020 Young. All rights reserved.
//

#import "UIApplication+HNWKit.h"
#import <UserNotifications/UserNotifications.h>

@implementation UIApplication (HNWKit)

- (void)hnw_openURL:(NSURL *)url completionHandler:(void (^)(BOOL))completionHandler {
    if (NSThread.isMainThread) {
        if (@available(iOS 10.0, *)) {
            [self openURL:url options:@{} completionHandler:completionHandler];
        } else {
            BOOL success = [self openURL:url];
            if (completionHandler) {completionHandler(success);}
        }
    } else {
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (@available(iOS 10.0, *)) {
                [self openURL:url options:@{} completionHandler:completionHandler];
            } else {
                BOOL success = [self openURL:url];
                if (completionHandler) {completionHandler(success);}
            }
        });
    }
}

- (void)pushNotificationEnabled:(void (^)(BOOL))resultHandler {
    BOOL flag = [UIApplication.sharedApplication isRegisteredForRemoteNotifications];
    if (@available(iOS 10.0, *)) {
        [UNUserNotificationCenter.currentNotificationCenter getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            UNAuthorizationStatus status = settings.authorizationStatus;
            BOOL soundEnabled = settings.soundSetting == UNNotificationSettingEnabled; // 声音 授权状态
            BOOL badgeEnabled = settings.badgeSetting == UNNotificationSettingEnabled; // app icon 角标标记 授权状态
            BOOL alertEnabled = settings.alertSetting == UNNotificationSettingEnabled; // push提醒弹框展示 授权状态
            BOOL lockScreenEnabled = settings.lockScreenSetting == UNNotificationSettingEnabled; // 锁屏展示push提醒弹框
            BOOL notificationCenterEnabled = settings.notificationCenterSetting == UNNotificationSettingEnabled; // 通知中心展示push提醒弹框
            BOOL unlockedAlertEnabled = settings.alertStyle != UNAlertStyleNone; // 设备未锁屏时 提醒-横幅风格，影响push提醒弹框的展示
        }];
    } else {
        UIUserNotificationType type = UIApplication.sharedApplication.currentUserNotificationSettings.types;
        BOOL enabled = type == UIUserNotificationTypeBadge && type == UIUserNotificationTypeSound && type == UIUserNotificationTypeAlert;
    }
}

@end
