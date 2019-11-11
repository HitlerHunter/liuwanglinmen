//
//  DataManagerViewModel.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/7/5.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "DataManagerViewModel.h"
#import "DataManagerModel.h"

@implementation DataManagerViewModel

- (void)getLineDataAddAllDataWithBlock:(void (^)(NSArray <DataManagerModel *>*dataArray))block{
    
    NewParams;
    [params setSafeObject:self.merchantNo forKey:@"operatorId"];
    [params setSafeObject:CurrentUserMerchant.pmsMerchantInfo.Id forKey:@"merchantNo"];//商户id
    [params setSafeObject:self.day forKey:@"day"];
    
    ZZNetWorker.GET.zz_url(@"/payment-biz/statistic/txnStatisticsAppByDate").zz_param(params)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        
        if (model_net.success) {
            
            self.sumDictionary = model_net.data[@"sum"];
            
            NSArray *arr = [DataManagerModel mj_objectArrayWithKeyValuesArray:model_net.data[@"records"]];
            [self.dataArray removeAllObjects];
            
            if (arr && arr.count) {
                [self.dataArray addObjectsFromArray:arr];
            }
            
            NSArray *array = self.sumDictionary[@"sumWxAli"];
            
            if (array.count == 0) {
                self.payWay_wechatDictionary = @{};
                self.payWay_alipayDictionary = @{};
            }
            
            for (NSDictionary *dic  in array) {
                if ([dic[@"payType"] isEqualToString:@"10"]) {
                    self.payWay_wechatDictionary = dic;
                }else{
                    self.payWay_alipayDictionary= dic;
                }
            }
            
            if (block) {
                block(self.dataArray);
            }
        }
    });
}

- (void)getPaywayDataWithBlock:(void (^)(void))block{
    
    NewParams;
    [params setSafeObject:self.merchantNo forKey:@"operatorId"];
    [params setSafeObject:CurrentUser.usrNo forKey:@"merchantNo"];//商户id
    [params setSafeObject:self.day forKey:@"day"];
    
    ZZNetWorker.GET.zz_url(@"/admin/statistics/payTypeStatisticsRate").zz_param(params)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        
        if (model_net.success) {
            
            NSArray *array = model_net.data;
            
            if (array.count == 0) {
                self.payWay_wechatDictionary = @{};
                self.payWay_alipayDictionary = @{};
            }
            
            for (NSDictionary *dic  in array) {
                if ([dic[@"payType"] isEqualToString:@"10"]) {
                    self.payWay_wechatDictionary = dic;
                }else{
                    self.payWay_alipayDictionary= dic;
                }
            }
           
            if (block) {
                block();
            }
        }
    });
}


- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
