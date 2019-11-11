//
//  IntegralRecordModel.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/7/8.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IntegralRecordModel : NSObject

@property (nonatomic, strong) NSString *operateData;
@property (nonatomic, strong) NSString *operatorId;
@property (nonatomic, strong) NSString *operatorName;

@property (nonatomic, strong) NSString *balance;
@property (nonatomic, strong) NSString *resultData;
@property (nonatomic, strong) NSString *fee;
@property (nonatomic, strong) NSString *orderAmt;
@property (nonatomic, strong) NSString *rebAmt;

@property (nonatomic, strong) NSString *payType;
@property (nonatomic, assign) IntegralOrderStatus orderStatus;

@property (nonatomic, strong) NSString *logId;
//800 是减少  transaction 增加
@property (nonatomic, strong) NSString *logType;

@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *bodyId;
@property (nonatomic, strong) NSString *category;

@end

@interface IntegralRecordSectionModel : NSObject
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, assign) NSInteger orderCount;
@property (nonatomic, assign) double totalAmount;
@property (nonatomic, strong) NSArray <IntegralRecordModel *> *listOrders;

@end

NS_ASSUME_NONNULL_END
