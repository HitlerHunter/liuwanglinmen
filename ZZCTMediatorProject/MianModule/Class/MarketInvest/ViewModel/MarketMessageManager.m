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
    NSString *url = [NSString stringWithFormat:@"/account-biz/smsAllowance/%@",CurrentUser.usrNo];
    ZZNetWorker.GET.zz_param(params).zz_url(url)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        
        if (model_net.success) {
            
            NSDictionary *dic = model_net.data;
            
            NSString *balance = [NSString formatFloatString:dic[@"balance"]];
            self.messageCount = [balance integerValue];
            self.totalIncome = [balance integerValue];
            self.totalSpend = [balance integerValue];
            self.changed ++;
            
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
