//
//  BookOrdSearchViewModel.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/9/27.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "BookOrdSearchViewModel.h"
#import "BookSectionModel.h"

@implementation BookOrdSearchViewModel

- (BOOL)refreshable{
    return NO;
}

- (NSInteger)startPage{
    return 0;
}

- (void)requestDataWithCompleteHandler:(refreshBlock)handler{
    
    NewParams;
    
    [params setSafeObject:@(self.page) forKey:@"page"];
    [params setSafeObject:@"20" forKey:@"rows"];
    [params setSafeObject:self.searchStr?self.searchStr:@"" forKey:@"lastFourWords"];
    [params setSafeObject:CurrentUser.usrNo forKey:@"userNo"];
    
    ZZNetWorker.POST.zz_param(params).zz_url(API_getOrderVoByLastFourWords)
    .zz_isPostByURLSession(YES).zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        
        if (model_net.success) {
            
            NSArray *arr = [BookListModel mj_objectArrayWithKeyValuesArray:model_net.data];
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
@end
