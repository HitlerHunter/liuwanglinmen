//
//  AppMethodCenter.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/7/13.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "AppMethodCenter.h"

@implementation AppMethodCenter

NSString *getPayWayNameWithCode(NSString *code){
    
    if (code.integerValue == 20) {
        return @"支付宝支付";
    }else if (code.integerValue == 10) {
        return @"微信支付";
    }
    
    return @"";
}


NSString * getBookOrderStatusTitleWithStatu(BookOrderStatus status){
    
    switch (status) {
        case BookOrderStatusSuccess:
            return @"交易成功";
            break;
        case BookOrderStatusFailure:
            return @"交易失败";
            break;
        case BookOrderStatusWaitingPay:
            return @"等待付款";
            break;
        case BookOrderStatusRefundSuccess:
            return @"退款成功";
            break;
        case BookOrderStatusRefundFailure:
            return @"退款失败";
            break;
        case BookOrderStatusWaitingRefund:
            return @"退款中";
            break;
            
        default:
            break;
    }
    
    return @"";
}

UIColor * getTextColorWithStatu(BookOrderStatus status){
    
    switch (status) {
        case BookOrderStatusSuccess:
            return rgb(53,53,53);
            break;
        case BookOrderStatusWaitingPay:
        case BookOrderStatusFailure:
            return [UIColor redColor];
            break;
        case BookOrderStatusRefundSuccess:
        case BookOrderStatusRefundFailure:
        case BookOrderStatusWaitingRefund:
        default:
            return rgb(53,53,53);
            break;
    }
    
    return rgb(53,53,53);
}

#pragma mark ------------- 积分明细 ---------------
NSString * getIntegralOrderStatusTitleWithStatu(IntegralOrderStatus status){
    
    switch (status) {
        case IntegralOrderStatusWaitingPay:
            return @"未支付";
            break;
        case IntegralOrderStatusSuccess:
            return @"交易成功";
            break;
        case IntegralOrderStatusClose:
            return @"交易关闭";
            break;
        case IntegralOrderStatusCancel:
            return @"交易撤销";
            break;
        case IntegralOrderStatusPaying:
            return @"支付中";
            break;
        case IntegralOrderStatusFailure:
            return @"交易失败";
            break;
        case IntegralOrderStatusIsRefund:
            return @"转入退款";
            break;
        case IntegralOrderStatusRefundSuccess:
            return @"退款成功";
            break;
        case IntegralOrderStatusRefundFailure:
            return @"退款失败";
            break;
        case IntegralOrderStatusWaitingRefund:
            return @"退款中";
            break;
        default:
            break;
    }
    
    return @"";
}

@end
