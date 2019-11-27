//
//  MarketMessagePayManager.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/6.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "MarketMessagePayManager.h"
#import "IPAddressHelper.h"

@implementation MarketMessagePayManager

- (void)requestOrder{
    
    NewParams;
    [params setSafeObject:CurrentUser.usrNo forKey:@"userNo"];
    [params setSafeObject:self.money forKey:@"orderAmt"];
    [params setSafeObject:self.smsCount forKey:@"goodsCount"];
    [params setSafeObject:[IPAddressHelper getNetworkIPAddress] forKey:@"spbillCreateIp"];
    
    [SVProgressHUD show];
    ZZNetWorker.POST.zz_param(params).zz_url(@"/payment-biz/order/rechargePay")
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        [SVProgressHUD dismiss];
        if (model_net.success) {
            NSDictionary *dict = model_net.data;
            
            [AppPayManager shareInstance].currentPayType = AppPayTypeMarketMessage;
            [[AppPayManager shareInstance] WXPayWithDic:dict];

        }
    });
}

@end
