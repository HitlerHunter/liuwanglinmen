//
//  CouponListViewModel.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/29.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "CouponListViewModel.h"
#import "CouponModel.h"

@implementation CouponListViewModel

- (void)refreshData{
    self.page = 0;
    self.isRefresh = YES;
    [self requestDataWithCompleteHandler:self.CompleteHandler];
}

- (void)requestDataWithCompleteHandler:(refreshBlock)handler{
    
    NewParams;
    
    [params setSafeObject:@(self.page) forKey:@"page"];
    [params setSafeObject:@"20" forKey:@"rows"];
    [params setSafeObject:CurrentUser.usrNo forKey:@"createUserId"];
//    [params setSafeObject:@"1424215" forKey:@"shopUserNo"];
    [params setSafeObject:self.couponStatus forKey:@"couponStatus"];
    [params setSafeObject:self.couponType forKey:@"couponType"];
    
    ZZNetWorker.POST.zz_param(params)
    .zz_url(@"/coupon-biz/coupon/queryCouponPage")
    .zz_isPostByURLSession(YES)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        
        if (model_net.success) {
            
            NSArray *arr = [CouponModel mj_objectArrayWithKeyValuesArray:model_net.data[@"records"]];
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

@end
