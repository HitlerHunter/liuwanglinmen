//
//  IntegralRecordViewModel.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/7/8.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "IntegralRecordViewModel.h"
#import "IntegralRecordModel.h"

@implementation IntegralRecordViewModel

- (void)requestDataWithCompleteHandler:(refreshBlock)handler{
    
    NewParams;
    
    [params setSafeObject:@(self.page) forKey:@"page"];
    [params setSafeObject:@"20" forKey:@"rows"];
    [params setSafeObject:self.type?self.type:@"all" forKey:@"type"];
    [params setSafeObject:self.yearMonth forKey:@"dateMonth"];
    
    ZZNetWorker.GET.zz_param(params).zz_url(@"/admin/wallet/open/merchantBalanceRecord")
    .zz_isPostByURLSession(YES).zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        
        if (model_net.success) {
            NSMutableArray *arr = [IntegralRecordSectionModel mj_objectArrayWithKeyValuesArray:model_net.data[@"records"]];
            if (arr.count == 1) {
                IntegralRecordSectionModel *model = arr.firstObject;
                if (!model.listOrders.count) {
                    if (self.isRefresh) {
                        [self.dataArray removeAllObjects];
                    }
                    
                    [self.dataArray addObject:model];
                    
                    [self.tableView.mj_header endRefreshing];
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    
                    if (self.tableView.mj_footer) {
                        self.tableView.mj_footer = nil;
                    }
                    
                    [self.tableView reloadData];
                    return ;
                }
            }
            
            if (self.isRefresh) {
                [self.dataArray removeAllObjects];
            }else{
                IntegralRecordSectionModel *lastModel = self.dataArray.lastObject;
                IntegralRecordSectionModel *firstModel = arr.firstObject;
                
                NSString *lastTime = lastModel.createTime;
                NSString *firstTime = firstModel.createTime;
                if ([lastTime isEqualToString:firstTime]) {
                    if (![arr isKindOfClass:[NSMutableArray class]]) {
                        arr = [NSMutableArray arrayWithArray:arr];
                    }
                    NSMutableArray *lastList = [NSMutableArray arrayWithArray:lastModel.listOrders];
                    [lastList addObjectsFromArray:firstModel.listOrders];
                    lastModel.listOrders = lastList;
                    [arr removeObjectAtIndex:0];
                }
            }
            
            [self.dataArray addObjectsFromArray:arr];
            
            [self.tableView reloadData];
        }
        
        [self.tableView.mj_header endRefreshing];
        
        NSInteger total = [model_net.data[@"total"] integerValue];
        if (self.page*20 >= total) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.tableView.mj_footer endRefreshing];
        }
        
        if (self.dataArray.count == 0 && self.tableView.mj_footer) {
            self.tableView.mj_footer = nil;
        }else if (self.dataArray.count > 0 && self.tableView.mj_footer == nil){
            @weakify(self);
            self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                @strongify(self);
                [self loadMoreData];
            }];
        }
    });
    
}

@end
