//
//  RewardRecordViewModel.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/25.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "RewardRecordViewModel.h"
#import "RewardRecordModel.h"

@implementation RewardRecordViewModel

- (void)requestDataWithCompleteHandler:(refreshBlock)handler{
    
    NewParams;
    
    [params setSafeObject:@(self.page) forKey:@"page"];
    [params setSafeObject:@"20" forKey:@"rows"];
    [params setSafeObject:CurrentUserMerchant.pmsMerchantInfo.Id forKey:@"merchantId"];
    
    ZZNetWorker.POST.zz_param(params)
    .zz_url(@"/merchant-biz/merchantUserUpdate/selectMerchantUpdateInfoPage")
    .zz_isPostByURLSession(YES)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        
        if (model_net.success) {
            
            NSArray *arr = [RewardRecordModel mj_objectArrayWithKeyValuesArray:model_net.data[@"records"]];
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
