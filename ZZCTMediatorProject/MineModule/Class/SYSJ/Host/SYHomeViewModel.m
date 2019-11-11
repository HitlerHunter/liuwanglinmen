//
//  SYHomeViewModel.m
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2019/3/13.
//  Copyright © 2019 徐迪华. All rights reserved.
//

#import "SYHomeViewModel.h"
#import "SYHomeListModel.h"

@implementation SYHomeViewModel

+(void)getTypeList:(SimpleObjBlock)block{
    
    ZZNetWorker.GET.zz_url(@"/profit-biz/profitType")
    .zz_completion(^(NSDictionary *data, NSError *error) {
        
        ZZNetWorkModelWithJson(data);
        if (model_net.success) {
            
            NSArray *arr = model_net.data;
            NSMutableDictionary *localDic = [NSMutableDictionary dictionary];
            for (NSDictionary *dic in arr) {
                [localDic setSafeObject:dic[@"typeName"] forKey:[NSString stringWithFormat:@"%@",dic[@"typeId"]]];
            }
            
            [[NSUserDefaults standardUserDefaults] setObject:localDic forKey:@"localProfitTypeDic"];
            
            if (block) {
                block(model_net.data);
            }
        }else{
            [SVProgressHUD showErrorWithStatus:model_net.message];
        }
        
    });
}


- (void)requestDataWithCompleteHandler:(refreshBlock)handler{
    
    NewParams;
    
    [params setSafeObject:@(self.page) forKey:@"page"];
    [params setSafeObject:@"20" forKey:@"limit"];
    [params setSafeObject:self.type forKey:@"flowType"];
    
  
    ZZNetWorker.POST.zz_url(@"/view-biz/profitDetailView/page")
    .zz_willHandlerParam(NO).zz_param(params)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        
        ZZNetWorkModelWithJson(data);
        NSArray *arr;
        if (model_net.success) {
                arr = [SYHomeListModel mj_objectArrayWithKeyValuesArray:model_net.data[@"records"]];
            if (self.isRefresh) {
                [self.dataArray removeAllObjects];
            }
            
            if (arr && arr.count) {
                [self.dataArray addObjectsFromArray:arr];
            }
        }
        
        if (handler) {
            handler(model_net.success,self.dataArray.count%20==0&&arr.count!=0,self.dataArray);
        }
        
    });
}

@end
