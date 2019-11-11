//
//  VipPersonViewModel.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/7/2.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "VipPersonViewModel.h"
#import "VipPersonModel.h"

@implementation VipPersonViewModel

- (void)requestDataWithCompleteHandler:(refreshBlock)handler{
    
    NewParams;
    
    [params setSafeObject:@(self.page) forKey:@"page"];
    [params setSafeObject:@"20" forKey:@"rows"];
    [params setSafeObject:self.orderByLastPayTime forKey:@"orderByLastPayTime"];
    [params setSafeObject:self.orderByPayTimes forKey:@"orderByPayTimes"];
    [params setSafeObject:self.orderByPayTotal forKey:@"orderByPayTotal"];
    [params setSafeObject:self.orderByRegisterTime forKey:@"orderByRegisterTime"];
    
    ZZNetWorker.POST.zz_param(params)
    .zz_url(@"/admin/user/open/memberList").zz_isPostByURLSession(YES)
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

@end
