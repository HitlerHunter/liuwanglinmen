//
//  LevelUpViewModel.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/21.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "LevelUpViewModel.h"
#import "IPAddressHelper.h"

@interface LevelUpViewModel ()

@property (nonatomic, strong) NSDictionary *dic1;
@property (nonatomic, strong) NSDictionary *dic2;
@property (nonatomic, strong) NSDictionary *dic3;

@end

@implementation LevelUpViewModel

- (void)getLevelInfoConfigListWithLevel:(NSInteger)level
                                  block:(SimpleObjBlock)block{
    
    if (level == 1 && self.dic1 && block) {
        block(self.dic1);
        return;
    }else if (level == 2 && self.dic2 && block) {
        block(self.dic2);
        return;
    }else if (level == 3 && self.dic3 && block) {
        block(self.dic3);
        return;
    }
    
    NewParams;
    [params setSafeObject:@(level) forKey:@"lvl"];
    
    ZZNetWorker.POST.zz_param(params)
    .zz_url(@"/outside-biz/profitInfo/list")
    .zz_setParamType(ZZNetWorkerParamTypeFormData)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        
        if (model_net.success) {
            
            NSMutableDictionary *dic2 = [NSMutableDictionary dictionary];
            for (NSDictionary *dic in model_net.data[@"list"]) {
                [dic2 setObject:dic forKey:[NSString stringWithFormat:@"%@",dic[@"businessType"]]];
            }
            
            [dic2 setSafeObject:model_net.data[@"upgradeAmount"] forKey:@"upgradeAmount"];
            [dic2 setSafeObject:model_net.data[@"upgradeSourceAmount"] forKey:@"upgradeSourceAmount"];
            
            if (level == 1) {
                self.dic1 = dic2;
            }else if (level == 2) {
                self.dic2 = dic2;
            }else if (level == 3) {
                self.dic3 = dic2;
            }
            
            if (block) {
                block(dic2);
            }
        }
    });
}

+ (void)upLevelWithMoney:(NSString *)money
                   level:(NSString *)level
                   block:(SimpleObjBlock)block{
    [self upLevelWithMoney:money
                      area:nil
                     level:level
                     phone:nil
                      name:nil
                     block:block];
}

+ (void)upLevelWithMoney:(NSString *)money
                    area:(NSString *)area
                    level:(NSString *)level
                   phone:(NSString *)phone
                    name:(NSString *)name
                   block:(SimpleObjBlock)block{
    
    NewParams;
    [params setSafeObject:StrObj(money) forKey:@"orderAmt"];
    [params setSafeObject:[IPAddressHelper getNetworkIPAddress] forKey:@"spbillCreateIp"];
    [params setSafeObject:StrObj(phone) forKey:@"tel"];
    [params setSafeObject:level forKey:@"lvl"];
    [params setSafeObject:area forKey:@"upArea"];
    [params setSafeObject:StrObj(CurrentUser.usrNo) forKey:@"userNo"];
    [params setSafeObject:name forKey:@"upName"];
    
    [SVProgressHUD show];
    ZZNetWorker.POST.zz_willHandlerParam(NO)
    .zz_param(params)
    .zz_url(@"/payment-biz/order/upgradePay")
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        [SVProgressHUD dismiss];
        if (model_net.success) {
            NSDictionary *dict = model_net.data;
            
            if (area.length && phone.length) {
                if (block) {
                    block(data);
                }
                return ;
            }
            
            if ([dict isKindOfClass:[NSString class]]) {
                [SVProgressHUD showErrorWithStatus:model_net.data];
                return;
            }
            
            [AppPayManager shareInstance].currentPayType = AppPayTypeUplevel;
            [[AppPayManager shareInstance] WXPayWithDic:dict];
            
        }else{
            [SVProgressHUD showErrorWithStatus:model_net.message];
        }
    });
}

@end
