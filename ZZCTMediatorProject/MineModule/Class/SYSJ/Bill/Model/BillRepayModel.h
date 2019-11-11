//
//  BillRepayModel.h
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2018/7/18.
//  Copyright © 2018年 徐迪华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BillRepayModel : NSObject

@property (nonatomic, strong) NSString *tranId;
@property (nonatomic, strong) NSString *tmSmp;
@property (nonatomic, strong) NSString *cnlNo;
@property (nonatomic, strong) NSString *channelName;
@property (nonatomic, strong) NSString *tranSts;
@property (nonatomic, strong) NSString *txnAmt;
@property (nonatomic, strong) NSString *txnRate;
@property (nonatomic, strong) NSString *feeAmt;
@property (nonatomic, strong) NSString *txnCardNo;
@property (nonatomic, strong) NSString *clrCardNo;
@property (nonatomic, strong) NSString *retMsg;

@property (nonatomic, strong) NSString *showTime;
@property (nonatomic, assign) BOOL isToday;
@end
