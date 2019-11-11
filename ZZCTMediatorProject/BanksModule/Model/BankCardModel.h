//
//  BankCardModel.h
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2019/1/22.
//  Copyright © 2019 徐迪华. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BankCardModel : NSObject

@property (nonatomic, strong) NSString *cardNo;
@property (nonatomic, strong) NSString *bankName;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *idNumber;

/**
 用户银行卡类型 0信用卡，1储蓄卡
 */
@property (nonatomic, assign) NSInteger cardType;
/**
 预留手机号码
 */
@property (nonatomic, strong) NSString *resTel;
/**
 收益提现卡默认标识
 */
@property (nonatomic, assign) BOOL wdDefFlg;
/**
 银行卡额度
 */
@property (nonatomic, strong) NSString *cardLimit;
//账单日
@property (nonatomic, strong) NSString *billDate;
//还款日
@property (nonatomic, strong) NSString *repayDate;
//可用额度
@property (nonatomic, strong) NSString *balance;
//免息期
@property (nonatomic, strong) NSString *freedays;
//积分
@property (nonatomic, strong) NSString *totalPoint;

/**
 计划标识 0没有正在执行计划，1 有正在执行计划
 */
@property (nonatomic, strong) NSString *planFlag;

@end

NS_ASSUME_NONNULL_END
