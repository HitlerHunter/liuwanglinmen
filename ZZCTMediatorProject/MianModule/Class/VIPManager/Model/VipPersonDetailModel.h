//
//  VipPersonDetailModel.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/11/22.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VipPersonDetailModel : NSObject

@property (nonatomic, strong) NSString *areaName;
@property (nonatomic, strong) NSString *birth;
@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, strong) NSString *consumerAmt;
@property (nonatomic, strong) NSString *consumerTimes;
@property (nonatomic, strong) NSString *lastTxnTime;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *nickUrl;
@property (nonatomic, strong) NSString *provName;

@property (nonatomic, strong) NSString *registerTime;
@property (nonatomic, assign) NSInteger sex;
@property (nonatomic, assign) NSInteger userLvl;
@property (nonatomic, strong) NSString *usrName;
@property (nonatomic, strong) NSString *usrNo;
@property (nonatomic, strong) NSString *usrType;

@end

NS_ASSUME_NONNULL_END
