//
//  BookViewModel.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/9/25.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class BookSectionModel,OperatorManModel;
typedef void(^refreshBlock)(BOOL isSuccess,BOOL hasMore,NSMutableArray *datas);
@interface BookViewModel : NSObject

@property (nonatomic, assign) BOOL isRefresh;
@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) refreshBlock CompleteHandler;

@property (nonatomic, strong) NSMutableArray <BookSectionModel *> *dataArray;
@property (nonatomic, strong) NSMutableArray <OperatorManModel *> *operatorManArray;
@property (nonatomic, strong) NSMutableDictionary *params;

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong,nullable) NSString *isRefund;
@property (nonatomic, strong,nullable) NSString *operatorNo;
@property (nonatomic, strong,nullable) NSString *payWayCode;
@property (nonatomic, strong,nullable) NSString *status;

@property (nonatomic, strong) NSString *beginTime;
@property (nonatomic, strong) NSString *endTime;

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, assign) double totalAmount;
@property (nonatomic, assign) NSInteger orderCount;

- (void)loadMoreData;
- (void)refreshData;
- (void)requestDataWithCompleteHandler:(refreshBlock)handler;

@end

NS_ASSUME_NONNULL_END
