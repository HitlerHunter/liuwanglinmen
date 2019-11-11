//
//  CouponViewModel.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/30.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class CouponModel;
@interface CouponViewModel : NSObject

/**新增优惠券*/
+ (void)creatCouponWithCouponModel:(CouponModel *)model block:(SimpleObjMsgBoolBlock)block;

/**发布优惠券*/
+ (void)publishCouponWithCouponModel:(CouponModel *)model
                         userIdArray:(NSArray *)userIdArray
                               block:(SimpleObjMsgBoolBlock)block;
/**删除优惠券*/
+ (void)removeCouponWithCouponModel:(CouponModel *)model
                              block:(SimpleObjMsgBoolBlock)block;

/**上下架优惠券*/
+ (void)upDownCouponWithCouponModel:(CouponModel *)model
                              block:(SimpleObjMsgBoolBlock)block;
@end

NS_ASSUME_NONNULL_END
