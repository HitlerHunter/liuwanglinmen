//
//  EditShopViewModel.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/9/4.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "EditShopViewModel.h"
#import "EditShopModel.h"

@implementation EditShopViewModel

/**根据商户id查询店铺信息*/
+ (void)getShopInfoWithBlock:(GetShopModelBlock)block{

    NewParams;
    [params setSafeObject:CurrentUser.usrNo forKey:@"id"];
    
    [SVProgressHUD show];
    ZZNetWorker.POST.zz_param(params)
    .zz_url(@"/coupon-biz/tbStore/queryStoreById")
    .zz_isPostByURLSession(YES).zz_setParamType(ZZNetWorkerParamTypeAppendAfterURL)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        [SVProgressHUD dismiss];
        if (model_net.success) {
            EditShopModel *model = [EditShopModel mj_objectWithKeyValues:model_net.data];
            if (IsNull(model.Id)) {
                model.editType = EditShopTypeAdd;
            }else{
                model.editType = EditShopTypeEdit;
            }
            
            if (block) {
                block(model);
            }
        }else{
            [SVProgressHUD showErrorWithStatus:model_net.message];
        }
        
    });
}


/**修改店铺信息*/
+ (void)editShopInfoWithShopModel:(EditShopModel *)shopModel Block:(SimpleBoolBlock)block{
    
    id json =  [shopModel mj_JSONObject];
    NSLog(@"editShop mj_JSONObject:\n %@",json);
    
    [SVProgressHUD show];
    ZZNetWorker.POST.zz_param(json)
    .zz_url(@"/coupon-biz/tbStore/updateStore")
    .zz_isPostByURLSession(YES)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        [SVProgressHUD dismiss];
        if (model_net.success) {
            [SVProgressHUD showSuccessWithStatus:model_net.message];
            if (block) {
                block(model_net.success);
            }
        }else{
            [SVProgressHUD showErrorWithStatus:model_net.message];
        }
        
    });
}

/**添加店铺信息*/
+ (void)creatShopInfoWithShopModel:(EditShopModel *)shopModel Block:(SimpleBoolBlock)block{
    
    id json =  [shopModel mj_JSONObject];
    NSLog(@"addShop mj_JSONObject:\n %@",json);
    
    [SVProgressHUD show];
    ZZNetWorker.POST.zz_param(json)
    .zz_url(@"/coupon-biz/tbStore/addStore")
    .zz_isPostByURLSession(YES)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        [SVProgressHUD dismiss];
        if (model_net.success) {
            [SVProgressHUD showSuccessWithStatus:model_net.message];
            if (block) {
                block(model_net.success);
            }
        }else{
            [SVProgressHUD showErrorWithStatus:model_net.message];
        }
        
    });
}
@end
