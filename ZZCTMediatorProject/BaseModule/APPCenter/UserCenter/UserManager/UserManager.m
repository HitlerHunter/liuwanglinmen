//
//  UserManager.m
//  ScanPurse
//
//  Created by zenglizhi on 2018/3/15.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "UserManager.h"
#import <JPUSHService.h>
#import "MerchantManagerViewModel.h"

@interface UserManager ()

@end

@implementation UserManager

+ (UserManager *)shareInstance{
    static UserManager *helper;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        if (helper == nil) {
            helper = [[UserManager alloc]init];
        }
    });
    return helper;
}

- (LZUser *)user{
    if (!_user) {
        _user = [LZUser new];
    }
    return _user;
}




- (void)refreshToken:(void (^)(BOOL isTokenValid))block{
    
    if (!CurrentUser.refresh_token.length) {
        if (block) {
            block(NO);
        }
        return;
    }
    
    NewParams;
    [params setSafeObject:CurrentUser.refresh_token forKey:@"refreshToken"];
    
    ZZNetWorker.GET.zz_param(params).zz_url(API_refreshToken)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        
        ZZNetWorkModelWithJson(data);
        BOOL isTokenValid = NO;
        
        if (model_net.success) {
            CurrentUser.access_token = model_net.data[@"accessToken"];
            CurrentUser.refresh_token = model_net.data[@"refreshToken"];

            isTokenValid = YES;
            
            [self getUserInfo:^(BOOL isSuccess) {
                if (block) {
                    block(isSuccess);
                }
            }];
            
        }else{
            if (block) {
                block(isTokenValid);
            }
        }
        
        
        
    });
}

- (void)getUserInfo:(void (^)(BOOL isSuccess))block{
    
    [[self class] refreshUserInfo:^(BOOL isSuccess, LZUser *user) {
        if (isSuccess) {
            self.user = user;
            [self getUserWallet];
            
            @weakify(self);
            [self getUserMerchant:^(LZUserMerchant *merchant) {
                @strongify(self);
               self.merchant = merchant;
            }];
        }
        
        if (block) {
            block(isSuccess);
        }
    }];
}

- (void)refreshUserLevelAndTypeInfo{
    
    [[self class] refreshUserInfo:^(BOOL isSuccess, LZUser *user) {
        if (isSuccess) {
            self.user.usrType = user.usrType;
            self.user.userLvl = user.userLvl;
        }
    }];
}

+ (void)refreshUserInfo:(void (^)(BOOL isSuccess,LZUser *user))block{
    
    if (!CurrentUser.access_token.length) {
        if (block) {
            block(NO,nil);
        }
        return;
    }
    
    ZZNetWorker.GET.zz_url(API_getUserInfo)
    .zz_setParamType(ZZNetWorkerParamTypeAppendAfterURL)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        
        ZZNetWorkModelWithJson(data);
        
        if (model_net.success) {

            LZUser *user = [LZUser mj_objectWithKeyValues:model_net.data];
            user.currentUserInfoDic = data;
            if (block) {
                block(model_net.success,user);
            }
            
        }else{
            [SVProgressHUD showErrorWithStatus:model_net.message];
        }
        
        
    });
}

- (void)getUserWallet{
    
    ZZNetWorker.GET.zz_url(@"/account-biz/wallet/1")
    .zz_completion(^(NSDictionary *data, NSError *error) {
        
        ZZNetWorkModelWithJson(data);
        
        if (model_net.success) {
            
            LZUserWallet *wallet = [LZUserWallet mj_objectWithKeyValues:model_net.data];
            
            self.wallet = wallet;
        }else{
            [SVProgressHUD showErrorWithStatus:model_net.message];
        }
        
    });
}

- (void)getUserMerchant:(void (^)(LZUserMerchant *merchant))block{
    
    [MerchantManagerViewModel getMerchantInfoWithUserNo:self.user.usrNo block:^(LZUserMerchant * _Nonnull merchant) {
        if (merchant == nil) {
            NSString *key = [NSString stringWithFormat:@"%@_merchantJson",CurrentUser.usrNo];
            NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:key];
            if (dic) {
                merchant = [LZUserMerchant mj_objectWithKeyValues:dic];
                merchant.pmsMerchantInfo.status = @"-1";
            }else{
                merchant = [LZUserMerchant creatMerchant];
            }
        }
        
        merchant.canEdit = YES;
        if (merchant.pmsMerchantInfo.status.integerValue == 5) {
            merchant.canEdit = NO;
        }
        
        if (block) {
            block(merchant);
        }
    }];
}

- (void)changeUserInfo:(NSDictionary *)params block:(void (^)(void))block{
    
    ZZNetWorker.PUT.zz_url(@"/user-biz/sysUser")
    .zz_param(params)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        
        ZZNetWorkModelWithJson(data);
        
        if (model_net.success) {
            
            if (block) {
                block();
            }
            
        }else{
            [SVProgressHUD showErrorWithStatus:model_net.message];
        }
        
    });
}

@end
