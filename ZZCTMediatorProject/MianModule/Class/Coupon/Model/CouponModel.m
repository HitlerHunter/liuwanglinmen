//
//  CouponModel.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/29.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "CouponModel.h"

@implementation CouponModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"Id":@"id"};
}

NSString *getCouponTypeStrWithType(NSString *type){
    if ([type isEqualToString:@"1"]) {
        return @"代金券";
    }else if ([type isEqualToString:@"2"]) {
        return @"折扣券";
    }
    
    return @"";
}

NSString *getCouponStatusStrWithStatus(NSString *status){
    if ([status isEqualToString:@"1"]) {
        return @"待上架";
    }else if ([status isEqualToString:@"2"]) {
        return @"已上架";
    }else if ([status isEqualToString:@"3"]) {
        return @"已失效";
    }else if ([status isEqualToString:@"4"]) {
        return @"已删除";
    }
    
    return @"";
}


NSString *getCouponDiscountStrWithDiscount(NSString *discount){
    
    discount = [NSString formatFloatString:discount];
    
    if ([discount hasSuffix:@"0"]) {
        discount = [discount substringToIndex:discount.length-1];
    }
    
    if ([discount hasSuffix:@"0"]) {
        discount = [discount substringToIndex:discount.length-2];
    }
    
    return discount;
}

NSString *getCouponDiscountStrWithDiscountFloat(CGFloat discount){
    
    return getCouponDiscountStrWithDiscount(@(discount).stringValue);
}

NSString *getCouponMessageWithCoupon(CouponModel *coupon){
    
    NSString *message = @"";
    if ([coupon.couponType isEqualToString:@"2"]) {//折扣券
        
        if (coupon.couponHigherAmount > 0) {
            
            message = [NSString stringWithFormat:@"消费满%@元可用，最高抵扣%@元",getCouponDiscountStrWithDiscountFloat(coupon.couponLowerAmount),getCouponDiscountStrWithDiscountFloat(coupon.couponHigherAmount)];
        }else{
            message = [NSString stringWithFormat:@"消费满%@元可用",getCouponDiscountStrWithDiscountFloat(coupon.couponLowerAmount)];
        }
        
    }else if ([coupon.couponType isEqualToString:@"1"]) {
        message = [NSString stringWithFormat:@"消费满%@元可用",getCouponDiscountStrWithDiscountFloat(coupon.couponLowerAmount)];
    }
    
    return message;
}

NSString *getCouponMessageStyle2WithCoupon(CouponModel *coupon){
    
    NSString *message = @"";
    
    NSString *discount = getCouponDiscountStrWithDiscountFloat(coupon.couponDiscount);
    
    if ([coupon.couponType isEqualToString:@"2"]) {
        
        if (coupon.couponHigherAmount > 0) {//折扣券
            message = [NSString stringWithFormat:@"满%@元打%@折\n最高优惠%@元",getCouponDiscountStrWithDiscountFloat(coupon.couponLowerAmount),discount,getCouponDiscountStrWithDiscountFloat(coupon.couponHigherAmount)];
        }else{
            
            message = [NSString stringWithFormat:@"满%@元打%@折",getCouponDiscountStrWithDiscountFloat(coupon.couponLowerAmount),discount];
        }
        
    }else if ([coupon.couponType isEqualToString:@"1"]) {
        message = [NSString stringWithFormat:@"满%@元抵扣%@元",getCouponDiscountStrWithDiscountFloat(coupon.couponLowerAmount),getCouponDiscountStrWithDiscountFloat(coupon.couponAmount)];
    }
    
    return message;
}

NSString *getCouponCountMessageWithCoupon(CouponModel *coupon){
    if (coupon.couponNum == -1) {
        return @"不限数量";
    }else{
        return [NSString stringWithFormat:@"%ld张",coupon.couponNum];
    }
}

- (NSInteger)canUseCouponNum{
    if (self.couponNum > 0) {
        return self.couponNum - self.activeNum;
    }
    return self.couponNum;
}
@end
