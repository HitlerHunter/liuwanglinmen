//
//  LoginViewModel.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/9/29.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "LoginViewModel.h"

@implementation LoginViewModel

//用户名/手机号/邮箱
+ (void)loginWithPhone:(NSString *)phone pswd:(NSString *)pswd block:(void (^)(NSDictionary *data, NSError *error))block{
    NewParams;
    [params setSafeObject:phone forKey:@"principal"];
    [params setSafeObject:pswd forKey:@"password"];
    [params setSafeObject:@"6w" forKey:@"appId"];
    [self loginWithParams:params URL:API_Login block:block];
}

+ (void)loginWithPhone:(NSString *)phone
                  code:(NSString *)code
               codeKey:(NSString *)codeKey
                 block:(void (^)(NSDictionary *data, NSError *error))block{
    NewParams;
    [params setSafeObject:phone forKey:@"principal"];
    [params setSafeObject:code forKey:@"smsCode"];
    [params setSafeObject:codeKey forKey:@"key"];
    [params setSafeObject:@"6w" forKey:@"appId"];
    [self loginWithParams:params URL:API_LoginWithCode block:block];
}

+ (void)loginWithParams:(NSDictionary *)params URL:(NSString *)URL block:(void (^)(NSDictionary *data, NSError *error))block{
    
    ZZNetWorker.POST.zz_param(params).zz_url(URL)
    .zz_authorization(@"")
    .zz_setParamType(ZZNetWorkerParamTypeFormData)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        if(block)block(data,error);
    });
}

+ (void)registerWithParams:(NSDictionary *)params block:(void (^)(NSDictionary *data, NSError *error))block{
    
    ZZNetWorker.POST.zz_param(params).zz_url(API_register)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        if(block)block(data,error);
    });
}

@end
