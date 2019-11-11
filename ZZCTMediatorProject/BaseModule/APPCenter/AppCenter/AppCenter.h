//
//  AppCenter.h
//  ScanPurse
//
//  Created by zenglizhi on 2018/4/10.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppCenter : NSObject

+ (void)callKeFu;
+ (void)callWithPhoneNumber:(NSString *)phone;
+ (void)openURL:(NSString *)urlStr;

/**绑定商户二维码code*/
+ (void)showEditCodeWithController:(UIViewController *)controller;

+ (void)toTabBarController;


/**
 NSString *startTimeStr = @"08:50";
 NSString *endTimeStr = @"18:00";

 */
+ (BOOL)checkTimeWithStart:(NSString *)start end:(NSString *)end;

+ (UIImage *)launchImage;
+ (UIImage *)appIcon;
+ (NSString *)appName;
+ (UIImage *)defaultAppAvatar;
+ (NSString *)KeFuPhone;


+ (BOOL)powerCheck;



+ (void)getAppInfo;

+ (NSString *)shareRegisterURL;
+ (void)shareURL:(NSString *)url;
@end
