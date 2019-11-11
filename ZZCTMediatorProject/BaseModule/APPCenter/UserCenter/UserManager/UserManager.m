//
//  UserManager.m
//  ScanPurse
//
//  Created by zenglizhi on 2018/3/15.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "UserManager.h"
#import <JPUSHService.h>
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
    
    if (!CurrentUser.access_token.length) {
        if (block) {
            block(NO);
        }
        return;
    }
    
    ZZNetWorker.GET.zz_url(API_getUserInfo)
    .zz_isPostByURLSession(YES)
    .zz_setParamType(ZZNetWorkerParamTypeAppendAfterURL)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        
        ZZNetWorkModelWithJson(data);
        
        BOOL isTokenValid = NO;
        if (model_net.success) {

            LZUser *user = [LZUser mj_objectWithKeyValues:model_net.data];
            if (user.sysUser.lzUserType == LZUserTypeUnknow) {
                [SVProgressHUD showErrorWithStatus:@"该账号无登录权限！"];
                 
            }else{
                isTokenValid = YES;
                self.user = user;
                [self getUserWallet];
                
                @weakify(self);
                [self getUserMerchant:^(LZUserMerchant *merchant) {
                    @strongify(self);
                   self.merchant = merchant;
                }];
            }
            
        }else{
            [SVProgressHUD showErrorWithStatus:model_net.message];
        }
        
        if (block) {
            block(isTokenValid);
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
    
    ZZNetWorker.POST.zz_url(@"/merchant-biz/pmsMerchantInfo/getMerchantInfoByVo")
    .zz_param(@{@"userNo":self.user.usrNo})
    .zz_completion(^(NSDictionary *data, NSError *error) {
        
        ZZNetWorkModelWithJson(data);
        
        if (model_net.success) {
            
            NSArray *arr = model_net.data;
            
            LZUserMerchant *merchant = nil;
            if (arr.count) {
                merchant = [LZUserMerchant mj_objectWithKeyValues:arr.firstObject];
            }else{
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
            
        }else{
            [SVProgressHUD showErrorWithStatus:model_net.message];
        }
        
    });
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
