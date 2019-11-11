//
//  CouponViewModel.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/30.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "CouponViewModel.h"
#import "CouponModel.h"

@implementation CouponViewModel

/**新增优惠券*/
+ (void)creatCouponWithCouponModel:(CouponModel *)model block:(SimpleObjMsgBoolBlock)block{
    
    model.createUserId = CurrentUser.usrNo;
    id params =  [model mj_JSONObject];
    NSLog(@"CouponModel mj_JSONObject:\n %@",params);
    
    ZZNetWorker.POST.zz_param(params)
    .zz_url(@"/coupon-biz/coupon/addCoupon")
    .zz_isPostByURLSession(YES)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        
        if (block) {
            block(data,model_net.msg,model_net.success);
        }
        
        
    });
}


/**发布优惠券*/
+ (void)publishCouponWithCouponModel:(CouponModel *)model
                         userIdArray:(NSArray *)userIdArray
                               block:(SimpleObjMsgBoolBlock)block{
    
    NewParams;
    
    [params setSafeObject:model.Id forKey:@"couponId"];
    [params setSafeObject:CurrentUser.usrNo forKey:@"userId"];
    [params setSafeObject:userIdArray forKey:@"appUserList"];

    ZZNetWorker.POST.zz_param(params)
    .zz_url(@"/coupon-biz/couponManage/couponDistribution")
    .zz_isPostByURLSession(YES)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        
        if (block) {
            block(model_net.data,model_net.msg,model_net.success);
        }
        
        
    });
}


/**删除优惠券*/
+ (void)removeCouponWithCouponModel:(CouponModel *)model
                              block:(SimpleObjMsgBoolBlock)block{
    
    NewParams;
    [params setSafeObject:model.Id forKey:@"id"];
    
    ZZNetWorker.POST.zz_param(params)
    .zz_url(@"/coupon-biz/coupon/deleteCouponById")
    .zz_setParamType(ZZNetWorkerParamTypeFormData)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        
        if (block) {
            block(data,model_net.msg,model_net.success);
        }
        
    });
}

/**上下架优惠券*/
+ (void)upDownCouponWithCouponModel:(CouponModel *)model
                              block:(SimpleObjMsgBoolBlock)block{
    
    NewParams;
    [params setSafeObject:model.Id forKey:@"id"];
    
    if (model.couponStatus.integerValue == 1) {
        [params setSafeObject:@"2" forKey:@"couponStatus"];
    }else if (model.couponStatus.integerValue == 2) {
        [params setSafeObject:@"1" forKey:@"couponStatus"];
    }
    
    ZZNetWorker.POST.zz_param(params)
    .zz_url(@"/coupon-biz/coupon/couponStatusChange")
    .zz_setParamType(ZZNetWorkerParamTypeFormData)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        
        if (block) {
            block(data,model_net.msg,model_net.success);
        }
        
    });
}

@end
