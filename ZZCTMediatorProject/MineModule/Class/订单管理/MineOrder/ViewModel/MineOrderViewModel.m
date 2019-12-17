//
//  MineOrderViewModel.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/12/25.
//  Copyright © 2018 zenglizhi. All rights reserved.
//

#import "MineOrderViewModel.h"
#import "MineOrderModel.h"

@implementation MineOrderViewModel

- (void)requestDataWithCompleteHandler:(refreshBlock)handler{
    
    NewParams;
    [params setSafeObject:self.orderStatus forKey:@"status"];
    [params setSafeObject:@(self.page) forKey:@"page"];
    [params setSafeObject:@"20" forKey:@"limit"];
    
    ZZNetWorker.POST.zz_param(params).zz_url(@"/outside-biz/expressInfo/page")
    .zz_completion(^(NSDictionary *data, NSError *error) {
        [SVProgressHUD dismiss];
        ZZNetWorkModelWithJson(data);
        if (model_net.success) {
            NSArray *arr = [MineOrderModel mj_objectArrayWithKeyValuesArray:model_net.data[@"records"]];
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

+ (void)cancelOrderWithOrderId:(NSString *)orderId block:(SimpleBoolBlock)block{
    
    ZZNetWorker.POST.zz_param(@{@"orderId":orderId}).zz_url(@"")
    .zz_baseUrl(BaseURL).zz_completion(^(NSDictionary *data, NSError *error) {
        [SVProgressHUD dismiss];
        ZZNetWorkModelWithJson(data);
        if (model_net.success) {
            if (block) {
                block(YES);
            }
        }
        
    });
}
/**确认收货*/
+ (void)sureOrderHasGetGoodsWithOrderId:(NSString *)orderId block:(SimpleBoolBlock)block{
    
    ZZNetWorker.POST.zz_param(@{@"orderId":orderId}).zz_url(@"")
    .zz_isPostByURLSession(YES)
    .zz_baseUrl(BaseURL).zz_completion(^(NSDictionary *data, NSError *error) {
        
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

//
+ (void)submitOrderWithReceiveAddrId:(NSString *)receiveAddrId
                          productIds:(NSArray <NSDictionary *> *)productIds
                          agentUserNo:(NSString *)agentUserNo
                          Block:(SimpleObjBoolBlock)block{
    
    NewParams;
    [params setSafeObject:receiveAddrId forKey:@"receiveAddrId"];
    [params setSafeObject:productIds forKey:@"productVoList"];
    [params setSafeObject:agentUserNo forKey:@"agentUserNo"];
    
    ZZNetWorker.POST.zz_param(params).zz_url(@"")
    .zz_baseUrl(BaseURL).zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        if (model_net.success) {
            if (block) {
                block(model_net.data,model_net.success);
            }
        }else{
            [SVProgressHUD showErrorWithStatus:model_net.message];
        }
    });
}

+ (void)submitOrderWithResource:(NSString *)resource
                  receiveAddrId:(NSString *)receiveAddrId
                shoppingCartIds:(NSArray <NSString *> *)shoppingCartIds
                          Block:(SimpleObjBoolBlock)block{
    
    NewParams;
    [params setSafeObject:resource forKey:@"orderResource"];
    [params setSafeObject:receiveAddrId forKey:@"receiveAddrId"];
    [params setSafeObject:shoppingCartIds forKey:@"shoppingCartIds"];
    
    ZZNetWorker.POST.zz_param(params).zz_url(@"")
    .zz_baseUrl(BaseURL).zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        if (block) {
            block(model_net.data,model_net.success);
        }
    });
}

+ (void)getOrderDetailWithOrderId:(NSString *)orderId block:(SimpleObjBlock)block{
    
    NSString *url = [NSString stringWithFormat:@"/outside-biz/expressInfo/%@",orderId];
    ZZNetWorker.GET.zz_param(@{}).zz_url(url)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        [SVProgressHUD dismiss];
        ZZNetWorkModelWithJson(data);
        MineOrderModel *model = [MineOrderModel mj_objectWithKeyValues:model_net.data];
        if (model_net.success) {
            if (block) {
                block(model);
            }
        }else{
            [SVProgressHUD showErrorWithStatus:model_net.message];
        }
        
    });
}

+ (void)sureHasPayWithOrderId:(NSString *)orderId block:(SimpleObjBlock)block{
    
    ZZNetWorker.POST.zz_param(@{@"orderNo":orderId}).zz_url(@"")
    .zz_baseUrl(BaseURL).zz_completion(^(NSDictionary *data, NSError *error) {
        [SVProgressHUD dismiss];
        ZZNetWorkModelWithJson(data);
        if (model_net.success) {
            if (block) {
                block(model_net.message);
            }
        }else{
            [SVProgressHUD showErrorWithStatus:model_net.message];
        }
        
    });
}

@end
