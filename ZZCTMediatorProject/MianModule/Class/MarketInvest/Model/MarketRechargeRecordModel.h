//
//  MarketRechargeRecordModel.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/8.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MarketRechargeRecordModel : NSObject

@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, strong) NSString *transNo;
@property (nonatomic, strong) NSString *merchName;
@property (nonatomic, strong) NSString *channel;
@property (nonatomic, strong) NSString *orderAmt;
@property (nonatomic, strong) NSString *operatorName;
@property (nonatomic, strong) NSString *createDate;
@property (nonatomic, strong) NSString *remark;
@property (nonatomic, strong) NSString *merchRemark;
@end

NS_ASSUME_NONNULL_END
