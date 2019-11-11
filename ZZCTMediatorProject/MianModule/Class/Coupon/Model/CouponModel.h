//
//  CouponModel.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/29.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@class CouponModel;
/**类型*/
extern NSString *getCouponTypeStrWithType(NSString *type);
/**状态*/
extern NSString *getCouponStatusStrWithStatus(NSString *status);
/**折扣*/
extern NSString *getCouponDiscountStrWithDiscount(NSString *discount);
extern NSString *getCouponDiscountStrWithDiscountFloat(CGFloat discount);

extern NSString *getCouponMessageWithCoupon(CouponModel *coupon);
/**满100元打9.8折 最高优惠20元*/
extern NSString *getCouponMessageStyle2WithCoupon(CouponModel *coupon);
/**预发数量 -> xx张*/
extern NSString *getCouponCountMessageWithCoupon(CouponModel *coupon);

@interface CouponModel : NSObject

@property (nonatomic, strong) NSString *Id;
@property (nonatomic, strong) NSString *couponName;
@property (nonatomic, strong) NSString *couponStatus;
@property (nonatomic, strong) NSString *couponType;

@property (nonatomic, assign) CGFloat couponAmount;
@property (nonatomic, assign) CGFloat couponLowerAmount;
@property (nonatomic, assign) CGFloat couponDiscount;
@property (nonatomic, assign) CGFloat couponHigherAmount;

/**可发优惠券*/
@property (nonatomic, assign,readonly) NSInteger canUseCouponNum;
@property (nonatomic, assign) NSInteger couponNum;
@property (nonatomic, assign) NSInteger activeNum;
@property (nonatomic, assign) NSInteger usedNum;

@property (nonatomic, assign) NSInteger validDateType;

@property (nonatomic, strong) NSString *startDate;
@property (nonatomic, strong) NSString *endDate;

@property (nonatomic, assign) NSInteger validDays;
@property (nonatomic, assign) NSInteger shareNum;
@property (nonatomic, assign) NSInteger receiveType;

@property (nonatomic, strong) NSString *applyShop;
@property (nonatomic, strong) NSString *shopUserNo;
@property (nonatomic, strong) NSString *createUserId;
@property (nonatomic, strong) NSString *remark;

@end

NS_ASSUME_NONNULL_END
