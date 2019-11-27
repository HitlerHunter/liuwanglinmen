//
//  VipPersonViewModel.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/7/2.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "VipPersonViewModel.h"
#import "VipPersonModel.h"
#import "VipPersonDetailModel.h"

@implementation VipPersonViewModel

- (void)requestDataWithCompleteHandler:(refreshBlock)handler{
    
    NewParams;
    
    [params setSafeObject:@(self.page) forKey:@"page"];
    [params setSafeObject:@"20" forKey:@"limit"];
    [params setSafeObject:self.isDesc forKey:@"isDesc"];
    [params setSafeObject:self.isAsc forKey:@"isAsc"];
    [params setSafeObject:CurrentUser.usrNo forKey:@"receiptUsrNo"];
    
    ZZNetWorker.POST.zz_willHandlerParam(NO).zz_param(params)
    .zz_url(@"/view-biz/memberStatisticsView/page")
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        
        if (model_net.success) {
            
            NSArray *arr = [VipPersonModel mj_objectArrayWithKeyValuesArray:model_net.data[@"records"]];
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


/**
 删除vip
 */
+ (void)deleteVipWithVipID:(NSString *)manId block:(SimpleBoolBlock)block{
    
    if (!manId) {
        return;
    }
    
    NewParams;
    [params setSafeObject:manId forKey:@"deleteUserId"];
    [params setSafeObject:CurrentUser.memberDetail.userId forKey:@"merchantId"];
    
    ZZNetWorker.POST.zz_url(@"/admin/user/open/deleteMerchantAccount").zz_param(params)
    .zz_isPostByURLSession(YES).zz_setParamType(ZZNetWorkerParamTypeAppendAfterURL)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        if (model_net.success) {
            if (block) {
                block(YES);
            }
        }else{
            [SVProgressHUD showErrorWithStatus:model_net.message];
        }
    });
}

+ (void)getVipDetailWithVipID:(NSString *)manId
                        block:(SimpleObjBlock)block{
    
    if (!manId) {
        return;
    }
    
    NewParams;
    [params setSafeObject:manId forKey:@"txnUsrNo"];
    ZZNetWorker.GET
    .zz_url(@"/view-biz/memberStatisticsView/detail")
    .zz_param(params)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        if (model_net.success) {
            
            VipPersonDetailModel *model = [VipPersonDetailModel mj_objectWithKeyValues:model_net.data];
            if (block) {
                block(model);
            }
        }else{
            [SVProgressHUD showErrorWithStatus:model_net.message];
        }
    });
}

@end
