//
//  BookViewModel.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/9/25.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "BookViewModel.h"
#import "BookSectionModel.h"
#import "OperatorManModel.h"

@implementation BookViewModel

- (void)loadMoreData{
    _page += 1;
    _isRefresh = NO;
    [self requestDataWithCompleteHandler:self.CompleteHandler];
}

- (void)refreshData{
    _page = 0;
    _isRefresh = YES;
    [self requestDataWithCompleteHandler:self.CompleteHandler];
}

- (void)requestDataWithCompleteHandler:(refreshBlock)handler{
    
    [self.params removeAllObjects];
    
    [self.params setSafeObject:@(self.page) forKey:@"page"];
    [self.params setSafeObject:@(20) forKey:@"rows"];
    [self.params setSafeObject:self.beginTime forKey:@"startTime"];
    [self.params setSafeObject:self.endTime forKey:@"endTime"];
    
    [self.params setSafeObject:self.payWayCode forKey:@"payType"];
    [self.params setSafeObject:self.status forKey:@"orderStatus"];
    
    if ([AppCenter powerCheck]) {
        [self.params setSafeObject:self.operatorNo?self.operatorNo:CurrentUser.usrNo forKey:@"userNo"];
    }else{
        [self.params setSafeObject:self.operatorNo?self.operatorNo:CurrentUser.usrNo forKey:@"userNo"];
    }
    
    ZZNetWorker.POST.zz_param(self.params).zz_url(API_getOrderListVo)
    .zz_isPostByURLSession(YES).zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);

        [self.tableView.mj_header endRefreshing];
        
        if (model_net.success) {
            NSMutableArray *arr = [BookSectionModel mj_objectArrayWithKeyValuesArray:model_net.data];
            if (arr.count == 1) {
                BookSectionModel *model = arr.firstObject;
                if (!model.listOrders.count) {
                    if (self.isRefresh) {
                        [self.dataArray removeAllObjects];
                    }
                    
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    [self.tableView reloadData];
                    return ;
                }
            }
            
            if (self.isRefresh) {
                [self.dataArray removeAllObjects];
            }else{
                BookSectionModel *lastModel = self.dataArray.lastObject;
                BookSectionModel *firstModel = arr.firstObject;
                
                NSString *lastTime = [lastModel.createTime substringToIndex:10];
                NSString *firstTime = [firstModel.createTime substringToIndex:10];
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
            
            NSInteger count = 0;
            for (BookSectionModel *sectionModel in arr) {
                count += sectionModel.listOrders.count;
            }
            
            if (count<20){
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
                return;
            }
            
        }

        [self.tableView.mj_footer endRefreshing];
    });
    
}


#pragma mark - lazy
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)operatorManArray{
    if (!_operatorManArray) {
        _operatorManArray = [NSMutableArray array];
    }
    return _operatorManArray;
}

- (NSMutableDictionary *)params{
    if (!_params) {
        _params = [NSMutableDictionary dictionary];
    }
    return _params;
}
@end
