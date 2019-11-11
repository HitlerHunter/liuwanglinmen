//
//  CouponSendRecordModel.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/31.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CouponSendRecordModel : NSObject

@property (nonatomic, strong) NSString *couponName;
@property (nonatomic, strong) NSString *couponType;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *distributionId;
@property (nonatomic, strong) NSString *distributionNum;

@end

NS_ASSUME_NONNULL_END
