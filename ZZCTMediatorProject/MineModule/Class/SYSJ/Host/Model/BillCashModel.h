//
//  BillCashModel.h
//  ScanPurse
//
//  Created by zenglizhi on 2018/3/28.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BillCashModel : NSObject

/**
 * 交易流水id
 */
@property (nonatomic, strong) NSString *tranId;
/**
 *交易类型 7 不可查看详情 （境外分润）
 */
@property (nonatomic, strong) NSString *tranType;
/**
 * 交易日期
 */
@property (nonatomic, strong) NSString *txnDate;
/**
 * 交易金额
 */
@property (nonatomic, strong) NSString *txnAmount;
/**
 * 分润
 */
@property (nonatomic, strong) NSString *profit;

@property (nonatomic, strong) NSString *showTime;
@end
