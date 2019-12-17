//
//  MineOrderModel.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/12/25.
//  Copyright © 2018 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString *getOrdStatusTitleWithStatus(MineOrderStatus status);

@interface MineOrderModel : NSObject

@property (nonatomic, strong) NSString *Id;
@property (nonatomic, strong) NSString *addressId;
@property (nonatomic, strong) NSString *channel;
@property (nonatomic, strong) NSString *createTime;

@property (nonatomic, strong) NSString *expressCompany;
@property (nonatomic, strong) NSString *expressNo;
@property (nonatomic, assign) CGFloat goodsCode;

@property (nonatomic, strong) NSString *goodsCount;
@property (nonatomic, strong) NSString *goodsName;

@property (nonatomic, strong) NSString *goodsPrice;

@property (nonatomic, strong) NSString *goodsSpecs;
@property (nonatomic, strong) NSString *goodsType;
@property (nonatomic, strong) NSString *orderAmt;
@property (nonatomic, strong) NSString *payDate;

@property (nonatomic, strong) NSString *picture;
@property (nonatomic, strong) NSString *remark;

@property (nonatomic, assign) MineOrderStatus status;
@property (nonatomic, strong) NSString *transNo;
@property (nonatomic, strong) NSString *updateTime;
@property (nonatomic, strong) NSString *usrNo;

@property (nonatomic, strong) NSString *provName;
@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, strong) NSString *areaName;
@property (nonatomic, strong) NSString *streetName;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *userName;

@property (nonatomic, strong) NSDictionary *preOrderParams;

@end

NS_ASSUME_NONNULL_END
