//
//  CouponDetailViewModel.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/31.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "CouponDetailViewModel.h"
#import "CouponVipModel.h"

@implementation CouponDetailViewModel

- (NSInteger)startPage{
    return 0;
}

- (BOOL)refreshable{
    return NO;
}

- (void)requestDataWithCompleteHandler:(refreshBlock)handler{
    
    NewParams;
    
    [params setSafeObject:@(self.page) forKey:@"page"];
    [params setSafeObject:@"20" forKey:@"rows"];
    [params setSafeObject:CurrentUser.usrNo forKey:@"userId"];
    [params setSafeObject:self.couponId forKey:@"couponId"];
    [params setSafeObject:self.sortBy forKey:@"sortBy"];
    [params setSafeObject:self.orderBy forKey:@"orderBy"];
    
    ZZNetWorker.POST.zz_param(params)
    .zz_url(@"/coupon-biz/couponManage/queryVerifyList")
    .zz_isPostByURLSession(YES)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        
        if (model_net.success) {
            
            NSArray *arr = [CouponVipModel mj_objectArrayWithKeyValuesArray:model_net.data[@"records"]];
            if (self.isRefresh) {
                [self.dataArray removeAllObjects];
            }
            
            if (arr && arr.count) {
                [self.dataArray addObjectsFromArray:arr];
            }
            
        }
        
        if (handler) {
            handler(model_net.success,self.dataArray.count%20==0&&self.dataArray.count!=0,self.dataArray);
        }
    });
}

- (void)getDetailTopData{
    
    NewParams;
    
    [params setSafeObject:@"0" forKey:@"page"];
    [params setSafeObject:@"2" forKey:@"rows"];
    [params setSafeObject:CurrentUser.usrNo forKey:@"userId"];
    [params setSafeObject:self.couponId forKey:@"couponId"];
    
    ZZNetWorker.POST.zz_param(params).zz_willHandlerParam(NO)
    .zz_url(@"/coupon-biz/couponManage/queryStatisticsList")
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        
        if (model_net.success) {
            
            NSArray *arr = model_net.data[@"records"];
            NSDictionary *dic = arr.firstObject;
            
            self.distributedSum = [dic[@"distributedSum"] integerValue];
            self.verifySum = [dic[@"verifySum"] integerValue];
        }else {
            [SVProgressHUD showErrorWithStatus:model_net.message];
        }
    });
}

@end
