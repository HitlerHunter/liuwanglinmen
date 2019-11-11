//
//  VipConsumeRecordModel.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/7/2.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VipConsumeRecordModel : NSObject

@property (nonatomic, strong) NSString *orderAmount;
@property (nonatomic, strong) NSString *chargeAmount;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *dateStr;
@property (nonatomic, strong) NSString *operatorName;
@property (nonatomic, strong) NSString *payTypeName;
@property (nonatomic, strong) NSString *merchantOrderNo;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *remark;

@end

NS_ASSUME_NONNULL_END
