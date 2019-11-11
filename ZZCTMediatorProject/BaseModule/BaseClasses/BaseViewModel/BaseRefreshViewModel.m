//
//  BaseRefreshViewModel.m
//  Youdoneed
//
//  Created by 曾立志 on 2017/7/24.
//  Copyright © 2017年 李凌辉. All rights reserved.
//

#import "BaseRefreshViewModel.h"

@interface BaseRefreshViewModel ()

@end

@implementation BaseRefreshViewModel

- (void)loadMoreData{
    _page += 1;
    _isRefresh = NO;
    [self requestDataWithCompleteHandler:self.CompleteHandler];
}

- (void)refreshData{
    _page = self.startPage;
    _isRefresh = YES;
    [self requestDataWithCompleteHandler:self.CompleteHandler];
}

- (NSInteger)startPage{
    return 1;
}

- (BOOL)refreshable{
    return YES;
}

- (void)requestDataWithCompleteHandler:(refreshBlock)handler{
  
}

- (void)setTableView:(UITableView *)tableView{
    _tableView = tableView;
    
    @weakify(self);
    self.CompleteHandler = ^(BOOL isSuccess, BOOL hasMore, NSMutableArray *datas) {
        @strongify(self);
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if (!hasMore) {
            self.tableView.mj_footer = nil;
        }
        
        if (datas.count == 0) {
            self.tableView.mj_footer = nil;
        }else if (self.tableView.mj_footer == nil && hasMore){
            [self setTableViewRefreshLoad];
        }
        if (isSuccess) {
            [self.tableView reloadData];
        }
    };
    
    [self setTableViewRefreshLoad];
    
}

- (void)setTableViewRefreshLoad{
    WeakSelf(weakSelf);
    
    if (self.refreshable) {
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf refreshData];
        }];
    }
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
}

#pragma mark - lazy
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
