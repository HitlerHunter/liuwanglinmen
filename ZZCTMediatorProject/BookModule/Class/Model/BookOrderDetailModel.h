//
//  BookOrderDetailModel.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/7/5.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface BookOrderDetailModel : NSObject

@property (nonatomic, strong) NSString *agentMerchProfit;
@property (nonatomic, strong) NSString *channel;
@property (nonatomic, strong) NSString *channelFee;
@property (nonatomic, strong) NSString *createDate;
@property (nonatomic, strong) NSString *fee;
@property (nonatomic, strong) NSString *feeRate;

@property (nonatomic, strong) NSString *marketingFee;
@property (nonatomic, strong) NSString *merchId;
@property (nonatomic, strong) NSString *merchName;
@property (nonatomic, strong) NSString *merchProfit;
@property (nonatomic, strong) NSString *merchType;

//操作员
@property (nonatomic, strong) NSString *operatorId;
@property (nonatomic, strong) NSString *operatorName;

@property (nonatomic, strong) NSString *openId;
@property (nonatomic, strong) NSString *orderAmt;
@property (nonatomic, strong) NSString *orderId;

@property (nonatomic, strong) NSString *payDate;
@property (nonatomic, strong) NSString *payType;
@property (nonatomic, strong) NSString *payTypeDetail;

@property (nonatomic, strong) NSString *platforProfit;
@property (nonatomic, strong) NSString *qrcodeUrl;
@property (nonatomic, strong) NSString *remark;
@property (nonatomic, strong) NSString *merchRemark;
@property (nonatomic, strong) NSString *settleType;

@property (nonatomic, strong) NSString *settlementAmt;
@property (nonatomic, strong) NSString *thirdOrderNo;
@property (nonatomic, strong) NSString *transNo;
@property (nonatomic, strong) NSString *orgTransNo;

@property (nonatomic, assign) BookOrderStatus orderStatus;
@property (nonatomic, strong, readonly) NSString *statuStr;

@property (nonatomic, strong) NSString *showDate;
@end

NS_ASSUME_NONNULL_END
