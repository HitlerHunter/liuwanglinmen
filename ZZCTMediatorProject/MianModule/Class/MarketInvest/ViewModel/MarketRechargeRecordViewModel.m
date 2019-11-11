//
//  MarketRechargeRecordViewModel.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/8.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "MarketRechargeRecordViewModel.h"
#import "MarketRechargeRecordModel.h"

@implementation MarketRechargeRecordViewModel

- (BOOL)refreshable{
    return NO;
}

- (void)requestDataWithCompleteHandler:(refreshBlock)handler{
    
    NewParams;
    
    [params setSafeObject:@(self.page) forKey:@"page"];
    [params setSafeObject:@"20" forKey:@"rows"];
    [params setSafeObject:CurrentUser.usrNo forKey:@"userNo"];
    [params setSafeObject:@"01" forKey:@"orderStatus"];
    [params setSafeObject:@"wx" forKey:@"channel"];//只有微信充值
    
    ZZNetWorker.POST.zz_param(params)
    .zz_url(@"/payment-biz/order/orderQuery").zz_isPostByURLSession(YES)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        
        if (model_net.success) {
            
            NSArray *arr = [MarketRechargeRecordModel mj_objectArrayWithKeyValuesArray:model_net.data[@"records"]];
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
