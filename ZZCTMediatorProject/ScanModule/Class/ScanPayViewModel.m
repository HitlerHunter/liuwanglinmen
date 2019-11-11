//
//  ScanPayViewModel.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/10/6.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "ScanPayViewModel.h"

@implementation ScanPayViewModel

+ (void)payWithCode:(NSString *)code
              money:(NSString *)money
             remark:(NSString *)remark
              block:(SimpleObjMsgBoolBlock)block{
    
    NSString *payWayUrl = @"/payment-biz/order/hftxPay";
    NSString *goodsName = GOODS_Name_Alipay;
    NSString *payType = @"W1";
    if ([code hasPrefix:@"28"]) { //aliPay
        payType = @"A1";
    }else if ([code hasPrefix:@"10"] ||
              [code hasPrefix:@"11"] ||
              [code hasPrefix:@"12"] ||
              [code hasPrefix:@"13"] ||
              [code hasPrefix:@"14"] ||
              [code hasPrefix:@"15"] ){//wechat
        goodsName = GOODS_Name_wechatPay;
    }else{
        
    }
    
    NewParams;
    [params setSafeObject:payType forKey:@"payType"];
    [params setSafeObject:CurrentUser.usrNo forKey:@"userNo"];
    
    [params setSafeObject:code forKey:@"authCode"];
    [params setSafeObject:goodsName forKey:@"goods_name"];
    [params setSafeObject:money forKey:@"orderAmt"];
    [params setSafeObject:@"FKM" forKey:@"payInterface"];
    
    ZZNetWorker.POST.zz_url(payWayUrl).zz_param(params)
    .zz_isPostByURLSession(YES)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        
        if (error) {
            if(block) block(nil,@"收款失败",NO);
        }else{
            
            if ([model_net.data isKindOfClass:[NSDictionary class]]) {
                if(block) block(model_net.data,model_net.message,model_net.success);
            }else if([model_net.data isKindOfClass:[NSString class]]){
                NSData *data = [model_net.data dataUsingEncoding:NSUTF8StringEncoding];
                    //将返回的数据转成json数据格式
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];
                if(block) block(dic,model_net.message,model_net.success);
            }else{
                if(block) block(nil,@"收款失败",NO);
            }
            
            
        }
        
    });
}

@end
