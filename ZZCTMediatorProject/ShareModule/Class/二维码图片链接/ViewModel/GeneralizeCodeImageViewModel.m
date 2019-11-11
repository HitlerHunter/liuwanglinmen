//
//  GeneralizeCodeImageViewModel.m
//  ScanPurse
//
//  Created by zenglizhi on 2018/4/4.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "GeneralizeCodeImageViewModel.h"

@implementation GeneralizeCodeImageViewModel

+ (void)requestDatas:(void (^)(NSArray *arr))block{
    
    ZZNetWorker.POST.zz_url(@"/outside-biz/shareInfo/list")
    .zz_param(@{}).zz_setParamType(ZZNetWorkerParamTypeFormData)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        
        ZZNetWorkModelWithJson(data);
        
        if (model_net.success) {

            NSArray *datas = [GeneralizeCodeImageModel mj_objectArrayWithKeyValuesArray:model_net.data];
            
            if (block) {
                block(datas);
            }
        }else{
            [SVProgressHUD showErrorWithStatus:model_net.message];
        }
        
    });
}
@end
