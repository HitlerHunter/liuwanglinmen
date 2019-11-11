//
//  MineTeamViewModel.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/24.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "MineTeamViewModel.h"
#import "ManManagerModel.h"

@implementation MineTeamViewModel

+ (void)getMineTeamData:(void (^)(NSDictionary *dic
                                  ,NSArray <ManManagerModel *>*elseUserList
                                  ,NSArray <ManManagerModel *>*myUserList))block{
    
    ZZNetWorker.GET.zz_url(@"/user-biz/userRelation/findMyTeam")
    .zz_completion(^(NSDictionary *data, NSError *error) {
        
        ZZNetWorkModelWithJson(data);
        
        if (model_net.success) {
            NSArray *arr1 = [ManManagerModel mj_objectArrayWithKeyValuesArray:model_net.data[@"myUserList"]];
            NSArray *arr2 = [ManManagerModel mj_objectArrayWithKeyValuesArray:model_net.data[@"elseUserList"]];
            
            if (block) {
                block(model_net.data,arr2,arr1);
            }
        }
        
       
    });
}

@end
