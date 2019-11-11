//
//  RewardCityViewModel.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/21.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "RewardCityViewModel.h"
#import "RewardCityModel.h"
#import "ZZLocationManager.h"

@implementation RewardCityViewModel

+ (void)getCityRewardWithBlock:(SimpleObjBlock)block{
    
    [[ZZLocationManager shareInstance] start:^(NSDictionary * _Nonnull dic) {
        NSString *city = dic[ZZLocationCityKey];
        NSString *longitude = dic[ZZLocationLongitudeKey];
        NSString *latitude = dic[ZZLocationLatitudeKey];
        
        NewParams;
        [params setSafeObject:city forKey:@"cityName"];
        [params setSafeObject:longitude forKey:@"longitude"];
        [params setSafeObject:latitude forKey:@"latitude"];
        
        [SVProgressHUD show];
        ZZNetWorker.POST.zz_param(params)
        .zz_setParamType(ZZNetWorkerParamTypeFormData)
        .zz_url(@"/merchant-biz/merchantUserUpdate/selectCityMerchantUpdateInfo")
        .zz_completion(^(NSDictionary *data, NSError *error) {
            ZZNetWorkModelWithJson(data);
            [SVProgressHUD dismiss];
            if (model_net.success) {
                NSArray *arr = [RewardCityModel mj_objectArrayWithKeyValuesArray:model_net.data];
                if (block) {
                    block(arr);
                }
            }else {
                [SVProgressHUD showErrorWithStatus:model_net.message];
            }
            
        });
        
    }];
    
}

@end
