//
//  CashRecordModel.h
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2018/7/6.
//  Copyright © 2018年 徐迪华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CashRecordModel : NSObject

/**
 * 交易流水id
 */
@property (nonatomic, strong) NSString *tranId;

@property (nonatomic, strong) NSString *applyAmt;
@property (nonatomic, strong) NSString *arrivalAmt;
@property (nonatomic, strong) NSString *auditUsrNo;
@property (nonatomic, strong) NSString *bankName;
@property (nonatomic, strong) NSString *bankNo;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *feeRate;
@property (nonatomic, strong) NSString *feeSingle;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *remitType;
@property (nonatomic, strong) NSString *explains;

@property (nonatomic, assign) NSInteger state;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *userType;
@property (nonatomic, strong) NSString *usrNo;

@property (nonatomic, strong) NSString *showTime;
@end
