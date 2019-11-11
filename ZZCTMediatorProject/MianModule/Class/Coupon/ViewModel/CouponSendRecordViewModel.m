//
//  CouponSendRecordViewModel.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/31.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "CouponSendRecordViewModel.h"
#import "CouponSendRecordModel.h"

@implementation CouponSendRecordViewModel

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
    [params setSafeObject:self.couponId forKey:@"couponId"];
    [params setSafeObject:CurrentUser.usrNo forKey:@"userId"];
//    [params setSafeObject:@"1424215" forKey:@"userId"];
    
    ZZNetWorker.POST.zz_param(params)
    .zz_url(@"/coupon-biz/couponManage/queryDistributionList")
    .zz_isPostByURLSession(YES)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        
        if (model_net.success) {
            
            NSArray *arr = [CouponSendRecordModel mj_objectArrayWithKeyValuesArray:model_net.data[@"records"]];
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
