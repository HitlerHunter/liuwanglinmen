//
//  MarketMessagePayManager.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/6.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "MarketMessagePayManager.h"
#import "IPAddressHelper.h"
#import <WechatOpenSDK/WXApi.h>
#import "AppPayManager.h"

@implementation MarketMessagePayManager

- (void)requestOrder{
    
    NewParams;
    [params setSafeObject:CurrentUser.usrNo forKey:@"platformMerchId"];
    [params setSafeObject:self.money forKey:@"orderAmt"];
    [params setSafeObject:self.smsCount forKey:@"smsCount"];
    [params setSafeObject:[IPAddressHelper getNetworkIPAddress] forKey:@"spbillCreateIp"];
    [params setSafeObject:self.remark forKey:@"remark"];
    
    [SVProgressHUD show];
    ZZNetWorker.GET.zz_param(params).zz_url(@"/pay/wxPay/appPay")
    .zz_isPostByURLSession(YES)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        [SVProgressHUD dismiss];
        if (model_net.success) {
            NSDictionary *dict = model_net.data;
            
            [AppPayManager shareInstance].currentPayType = AppPayTypeMarketMessage;
            
            NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
            
            //调起微信支付
            PayReq* req             = [[PayReq alloc] init];
            req.partnerId           = [dict objectForKey:@"partnerid"];
            req.prepayId            = [dict objectForKey:@"prepayid"];
            req.nonceStr            = [dict objectForKey:@"noncestr"];
            req.timeStamp           = stamp.intValue;
            req.package             = [dict objectForKey:@"package"];
            req.sign                = [dict objectForKey:@"sign"];
            [WXApi sendReq:req];
        }
    });
}

@end
