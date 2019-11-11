//
//  AppPayManager.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/7.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "AppPayManager.h"

@implementation AppPayManager

+ (AppPayManager *)shareInstance{
    static AppPayManager *manager;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        if (manager == nil) {
            manager = [[AppPayManager alloc]init];
        }
    });
    return manager;
}

#pragma mark - WXApiDelegate
- (void)onResp:(BaseResp *)resp
{
    if([resp isKindOfClass:[PayResp class]]){
        
            //支付返回结果，实际支付结果需要去微信服务器端查询
        AppPayStatus status = AppPayStatusCancel;
        switch (resp.errCode) {
            case WXSuccess:
                status = AppPayStatusSuccess;
                break;
            case WXErrCodeSentFail:
                status = AppPayStatusFailue;
                break;
            case WXErrCodeUserCancel:
                status = AppPayStatusCancel;
                break;
                
            default:
                break;
        }
        
        NSString *name = @"name";
        if (self.currentPayType == AppPayTypeUplevel) {
            name = WXPayFinishedUplevelNotificationName;
        }else if (self.currentPayType == AppPayTypeMarketMessage) {
            name = WXPayFinishedMarketMessageNotificationName;
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:name object:@(status)];
    }
}
@end
