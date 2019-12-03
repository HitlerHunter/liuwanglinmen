//
//  MerchantManagerViewModel.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/11/22.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "MerchantManagerViewModel.h"
#import "MerchantManagerModel.h"

@implementation MerchantManagerViewModel

- (void)requestDataWithCompleteHandler:(refreshBlock)handler{
    
    NewParams;

    [params setSafeObject:@(self.page) forKey:@"page"];
    [params setSafeObject:@"20" forKey:@"rows"];
    [params setSafeObject:CurrentUser.usrNo forKey:@"upUserNo"];
    ZZNetWorker.POST.zz_param(params).zz_url(@"/merchant-biz/pmsMerchantInfo/getMerchantInfoAllPage")
    .zz_completion(^(NSDictionary *data, NSError *error) {
        [SVProgressHUD dismiss];
        ZZNetWorkModelWithJson(data);
        if (model_net.success) {
            NSArray *arr = [MerchantManagerModel mj_objectArrayWithKeyValuesArray:model_net.data[@"merchantSearchVOList"]];
            self.total = [NSString stringWithFormat:@"%@",model_net.data[@"total"]];
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

- (void)getTodayNewdataInfo{
    
    NewParams;
    [params setSafeObject:CurrentUser.usrNo forKey:@"upUserNo"];
    ZZNetWorker.POST.zz_param(params).zz_url(@"/merchant-biz/pmsMerchantInfo/getMerchantStatusNum")
    .zz_setParamType(ZZNetWorkerParamTypeAppendAfterURL)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        
        ZZNetWorkModelWithJson(data);
        if (model_net.success) {
            self.acStatus = [NSString stringWithFormat:@"%@",model_net.data[@"acStatus"]];
            self.merchantNum = [NSString stringWithFormat:@"%@",model_net.data[@"merchantNum"]];
            self.addMerchantNum = [NSString stringWithFormat:@"%@",model_net.data[@"newMerchantNum"]];
            self.reStatus = [NSString stringWithFormat:@"%@",model_net.data[@"reStatus"]];
            self.unStatus = [NSString stringWithFormat:@"%@",model_net.data[@"unStatus"]];
        }
        
    });
}

+ (void)getMerchantInfoWithUserNo:(NSString *)userNo
                            block:(void (^)(LZUserMerchant *merchant))block{
    
   [SVProgressHUD show]; ZZNetWorker.POST.zz_url(@"/merchant-biz/pmsMerchantInfo/getMerchantInfoByVo")
    .zz_param(@{@"userNo":userNo})
    .zz_completion(^(NSDictionary *data, NSError *error) {
        [SVProgressHUD dismiss];
        ZZNetWorkModelWithJson(data);
        
        if (model_net.success) {
            
            NSArray *arr = model_net.data;
            
            LZUserMerchant *merchant = nil;
            if (arr.count) {
                merchant = [LZUserMerchant mj_objectWithKeyValues:arr.firstObject];
            }
            
            if (block) {
                block(merchant);
            }
            
        }else{
            [SVProgressHUD showErrorWithStatus:model_net.message];
        }
        
    });
}
@end
