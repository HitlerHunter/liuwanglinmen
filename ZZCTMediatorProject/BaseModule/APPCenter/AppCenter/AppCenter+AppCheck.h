//
//  AppCenter+AppCheck.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/29.
//  Copyright © 2019 zenglizhi. All rights reserved.
//


#import "AppCenter.h"

NS_ASSUME_NONNULL_BEGIN

#define AppCenterCheckNotOpen \
[AppCenter checkModuleNotOpenToMemberUser];\
return ;

#define AppCenterCheckNotOpenToAllUser \
[AppCenter checkModuleNotOpenToAllUser];\
return ;

#define APPCenterPowerCheckMerchant \
if (![AppCenter checkMerchant]) {\
return ;\
}

#define APPCenterCheckRealName \
if (![AppCenter checkRealName]) {\
return ;\
}


@interface AppCenter (AppCheck)

+ (void)checkModuleNotOpenToMemberUser;
+ (void)checkModuleNotOpenToAllUser;
+ (BOOL)checkMerchant;
+ (BOOL)checkRealName;
+ (BOOL)isDevelopmentNumber;
+ (void)toEmptyController;
+ (void)setEmptyControllerTitle:(NSString *)title;
/**是否是放到分发平台*/
+ (BOOL)checkAppIsToHoc;
/**是否在开发*/
+ (BOOL)checkAppIsDevelopment;
@end

NS_ASSUME_NONNULL_END
