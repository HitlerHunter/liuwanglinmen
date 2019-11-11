//
//  MarketMessageManager.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/26.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "MarketMessageManager.h"

@implementation MarketMessageManager

+ (MarketMessageManager *)shareInstance{
    static MarketMessageManager *manager;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        if (manager == nil) {
            manager = [[MarketMessageManager alloc]init];
            [manager updateMessageInfo];
        }
    });
    return manager;
}

- (void)updateMessageInfo{
    
    NewParams;
    [params setSafeObject:CurrentUser.usrNo forKey:@"userId"];
    [params setSafeObject:@"6" forKey:@"walletType"];
    
    ZZNetWorker.POST.zz_param(params).zz_url(@"/admin/wallet/open/getWalletBalancePage")
    .zz_isPostByURLSession(YES)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        
        if (model_net.success) {
            
            NSArray *arr = model_net.data[@"records"];
            if (arr.count) {
                NSDictionary *dic = arr.firstObject;
                
                NSString *balance = [NSString formatFloatString:dic[@"balance"]];
                self.messageCount = [balance integerValue];
                self.changed ++;
            }
            
        }
    });
    
}

- (NSString *)messageCountStr{
    NSString *count = [NSString stringWithFormat:@"%ld",(long)self.messageCount];
    return count;
}

- (void)getMessageRechargeRule:(void (^)(BOOL isSuccess))block{
    
    NewParams;
    [params setSafeObject:@"sms" forKey:@"serverType"];
     ZZNetWorker.GET.zz_param(params)
//    .zz_baseUrl(@"http://192.168.1.190:8080")
    .zz_url(@"/general/tbSmsRechargeRule/sms")
    .zz_isPostByURLSession(YES)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        
        if (model_net.success) {
            self.messagePrice = [[NSString formatFloatString:model_net.data[@"price"]] doubleValue];
            self.remark = model_net.data[@"remark"];
            
            if (block) {
                block(YES);
            }
        }
    });
    
}

- (NSInteger)messageCountWithMoney:(NSString *)money{
    if (money.floatValue == 0) {
        return 0;
    }
    return (NSInteger)(money.floatValue/self.messagePrice);
}


@end
