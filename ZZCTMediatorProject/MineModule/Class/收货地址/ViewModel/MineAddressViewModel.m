//
//  MineAddressViewModel.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/11/19.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "MineAddressViewModel.h"
#import "MineAddressModel.h"

@implementation MineAddressViewModel

+ (void)removeAddressWithModel:(MineAddressModel *)model
                         block:(SimpleBoolBlock)block{
    
    
    NSString *url = [NSString stringWithFormat:@"/user-biz/receiverAddress/%@",model.Id];
    ZZNetWorker.DELETE.zz_param(@{})
    .zz_url(url)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        
        if (block) {
            block(model_net.success);
        }
    });
}

+ (void)addAddressWithModel:(MineAddressModel *)model block:(SimpleBoolBlock)block{
    
    NSDictionary *params = [model mj_JSONObject];
    
    ZZNetWorker.POST.zz_param(params)
    .zz_url(@"/user-biz/receiverAddress")
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        
        if (block) {
            block(model_net.success);
        }
    });
}

+ (void)editAddressWithModel:(MineAddressModel *)model
                       block:(SimpleBoolBlock)block{
    
    NSDictionary *params = [model mj_JSONObject];
    
    ZZNetWorker.PUT.zz_param(params)
    .zz_url(@"/user-biz/receiverAddress")
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        
        if (block) {
            block(model_net.success);
        }
    });
}

+ (void)getAddressListWithBlock:(SimpleObjBlock)block{
    
    ZZNetWorker.POST.zz_param(@{})
    .zz_url(@"/user-biz/receiverAddress/list")
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        
        if (model_net.success) {
            NSArray *datas = [MineAddressModel mj_objectArrayWithKeyValuesArray:model_net.data];
            if (block) {
                block(datas);
            }
        }
        
    });
}

+ (void)getDefaultAddressWithBlock:(SimpleObjBlock)block{
    
    ZZNetWorker.GET.zz_param(@{@"usrNo":CurrentUser.usrNo})
    .zz_url(@"/user-biz/receiverAddress/default")
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        
        if (model_net.success) {
            MineAddressModel *model = [MineAddressModel mj_objectWithKeyValues:model_net.data];
            if (block) {
                block(model);
            }
        }
        
    });
}
@end
