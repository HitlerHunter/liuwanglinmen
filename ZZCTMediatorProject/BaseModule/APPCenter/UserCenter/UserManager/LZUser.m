//
//  LZUser.m
//  ScanPurse
//
//  Created by zenglizhi on 2018/3/15.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "LZUser.h"
#import <JPush/JPUSHService.h>

@implementation LZUser

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"merchantList":@"AuthenInfoModel"};
}

- (instancetype)init{
    self = [super init];
    if (self) {
        
        NSString *refresh_token = [[NSUserDefaults standardUserDefaults] objectForKey:@"refresh_token"];
        NSString *access_token = [[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"];
        NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
        
        NSUserDefaults *myDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.liuwanshangjia1"];
        BOOL isCloseTTS = [myDefaults boolForKey:@"isCloseTTS"];
        _isCloseTTS = isCloseTTS;
        
        BOOL isOpenAppNotification = [[NSUserDefaults standardUserDefaults] boolForKey:@"isOpenAppNotification"];
        _isOpenAppNotification = isOpenAppNotification;
        
        self.refresh_token = refresh_token;
        self.access_token = access_token;
        self.userId = userId;
    }
    return self;
}

- (NSString *)token{
    return self.access_token;
}

- (NSString *)nickName{
    if (!_nickName) {
        _nickName = self.userName?self.userName:self.phone;
    }
    return _nickName;
}


- (BOOL)hasAuthen{
    if (self.merchantList && self.merchantList.count>0) {
        return YES;
    }
    return NO;
}

- (void)setAccess_token:(NSString *)access_token{
    _access_token = access_token;
    
    [[NSUserDefaults standardUserDefaults] setObject:access_token forKey:@"access_token"];
}

- (void)setRefresh_token:(NSString *)refresh_token{
    _refresh_token = refresh_token;
    
    [[NSUserDefaults standardUserDefaults] setObject:refresh_token forKey:@"refresh_token"];
}

- (void)setUserId:(NSString *)userId{
    _userId = userId;
    
    [[NSUserDefaults standardUserDefaults] setObject:userId forKey:@"userId"];
}

- (void)setIsCloseTTS:(BOOL)isCloseTTS{
    
    _isCloseTTS = isCloseTTS;
    
    NSUserDefaults *myDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.liuwanshangjia1"];
    [myDefaults setBool:isCloseTTS forKey:@"isCloseTTS"];
}

- (void)loginOut{
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"refresh_token"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"access_token"];

}

- (void)setIsOpenAppNotification:(BOOL)isOpenAppNotification{
    _isOpenAppNotification = isOpenAppNotification;
    
    [[NSUserDefaults standardUserDefaults] setBool:isOpenAppNotification forKey:@"isOpenAppNotification"];
    
    
    [self OpenAppNotification:isOpenAppNotification];
}

#pragma mark - 推送添加别名
- (void)OpenAppNotification:(BOOL)isOpen{
    
    if (isOpen) {
        
        NSString *registerId = [[NSUserDefaults standardUserDefaults] objectForKey:@"JPUSHServiceRegisterid"];
        NewParams;
        [params setSafeObject:@"ios" forKey:@"client"];
        [params setSafeObject:[NSUUID UUID].UUIDString forKey:@"deviceId"];
        [params setSafeObject:registerId forKey:@"registerId"];
            
            ZZNetWorker.POST.zz_param(params).zz_setParamType(ZZNetWorkerParamTypeAppendAfterURL)
            .zz_url(@"/outside-biz/jpush/bind")
            .zz_completion(^(NSDictionary *data, NSError *error) {
                
            });
    }else{
        ZZNetWorker.POST.zz_param(@{}).zz_setParamType(ZZNetWorkerParamTypeAppendAfterURL)
        .zz_url(@"/outside-biz/jpush/unbind")
        .zz_completion(^(NSDictionary *data, NSError *error) {
            
        });
    }

}

- (LZUserType)lzUserType{
    return getLZUserTypeWithType(_usrType);
}

@end


@implementation SysUserModel


@end

@implementation MemberDetailModel

@end
