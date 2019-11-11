//
//  CashRecordViewModel.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/12/26.
//  Copyright © 2018 zenglizhi. All rights reserved.
//

#import "CashRecordViewModel.h"
#import "CashRecordModel.h"

@implementation CashRecordViewModel

- (void)requestDataWithCompleteHandler:(refreshBlock)handler{
    
    NewParams;

//    [params setSafeObject:@(self.page) forKey:@"pages"];
//    [params setSafeObject:@"20" forKey:@"size"];
    [params setSafeObject:self.category forKey:@"state"];
    [params setSafeObject:CurrentUser.usrNo forKey:@"usrNo"];
    
    ZZNetWorker.POST.zz_willHandlerParam(NO).zz_param(params)
    .zz_url(@"/account-biz/withdrawRecord/page")
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        
        if (model_net.success) {
            
            NSArray *arr = [CashRecordModel mj_objectArrayWithKeyValuesArray:model_net.data[@"records"]];
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
