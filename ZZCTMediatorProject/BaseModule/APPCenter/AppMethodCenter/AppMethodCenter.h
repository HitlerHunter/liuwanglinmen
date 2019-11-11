//
//  AppMethodCenter.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/7/13.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppMethodCenter : NSObject

extern NSString *getPayWayNameWithCode(NSString *code);

#pragma mark ------------- 账目 ---------------
typedef NS_ENUM(NSUInteger, BookOrderStatus) {
    BookOrderStatusSuccess = 1,
    BookOrderStatusClose = 2,
    BookOrderStatusCancel = 3,
    /**等待付款*/
    BookOrderStatusWaitingPay = 4,
    BookOrderStatusFailure = 5,
    
    /**退款成功*/
    BookOrderStatusRefundSuccess = 7,
    /**退款失败*/
    BookOrderStatusRefundFailure = 9,
    /**退款中*/
    BookOrderStatusWaitingRefund = 8,
    
    BookOrderStatusUnknow = 100,
};

extern NSString * getBookOrderStatusTitleWithStatu(BookOrderStatus status);
extern UIColor * getTextColorWithStatu(BookOrderStatus status);


#pragma mark ------------- 积分明细 ---------------
typedef NS_ENUM(NSUInteger, IntegralOrderStatus) {
    /**等待付款*/
    IntegralOrderStatusWaitingPay = 0,
    
    IntegralOrderStatusSuccess = 1,
    /**交易关闭*/
    IntegralOrderStatusClose = 2,
    /**交易撤销*/
    IntegralOrderStatusCancel = 3,
    /**支付中*/
    IntegralOrderStatusPaying = 4,
    IntegralOrderStatusFailure = 5,
    
    
    /**转入退款*/
    IntegralOrderStatusIsRefund = 6,
    /**退款成功*/
    IntegralOrderStatusRefundSuccess = 7,
    /**退款失败*/
    IntegralOrderStatusRefundFailure = 9,
    /**退款中*/
    IntegralOrderStatusWaitingRefund = 8,
};

extern NSString * getIntegralOrderStatusTitleWithStatu(IntegralOrderStatus status);
@end

NS_ASSUME_NONNULL_END
