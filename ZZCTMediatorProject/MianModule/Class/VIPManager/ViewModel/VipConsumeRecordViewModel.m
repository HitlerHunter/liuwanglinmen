//
//  VipConsumeRecordViewModel.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/7/2.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "VipConsumeRecordViewModel.h"
#import "VipConsumeRecordModel.h"

@implementation VipConsumeRecordViewModel

- (void)requestDataWithCompleteHandler:(refreshBlock)handler{
    
    NewParams;
    [params setSafeObject:@(self.page) forKey:@"page"];
    [params setSafeObject:@"20" forKey:@"rows"];
    [params setSafeObject:self.userId forKey:@"userNo"];
    
    ZZNetWorker.GET.zz_param(params)
    .zz_url(@"/payment-biz/order/getOrderRecords")
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        
        if (model_net.success) {
            
            self.sumCount = model_net.data[@"sumCount"];
            self.sumOrderAmt = model_net.data[@"sumOrderAmt"];
            
            NSArray *arr = [VipConsumeRecordModel mj_objectArrayWithKeyValuesArray:model_net.data[@"orderRecords"]];
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
