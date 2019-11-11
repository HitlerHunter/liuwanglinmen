//
//  BaseRefreshViewModel.h
//  Youdoneed
//
//  Created by 曾立志 on 2017/7/24.
//  Copyright © 2017年 李凌辉. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^refreshBlock)(BOOL isSuccess,BOOL hasMore,NSMutableArray *datas);
@interface BaseRefreshViewModel : NSObject

/**是否提供刷新功能*/
@property (nonatomic, assign, readonly) BOOL refreshable;

@property (nonatomic, assign) BOOL isRefresh;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign, readonly) NSInteger startPage;

@property (nonatomic, strong) refreshBlock CompleteHandler;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, weak) UITableView *tableView;

- (void)loadMoreData;
- (void)refreshData;
- (void)requestDataWithCompleteHandler:(refreshBlock)handler;
@end
