//
//  AppMessage.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/1/3.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "AppMessage.h"
#import "NoticeListViewModel.h"
#import "NoticeModel.h"

@implementation AppMessage

+ (AppMessage *)shareInstance{
    static AppMessage *message;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        if (message == nil) {
            message = [[AppMessage alloc]init];
        }
    });
    return message;
}

- (void)refreshUI{

    self.needRefreshUI = YES;

}

+ (void)getHomePresentNoticeWithBlock:(void(^)(NoticeModel *message))block{
    
    NoticeListViewModel *listVM = [NoticeListViewModel new];
    listVM.rows = @"1";
    listVM.showType = @"1";
    listVM.CompleteHandler = ^(BOOL isSuccess, BOOL hasMore, NSMutableArray *datas) {
        if (isSuccess) {
            
            if (datas.count) {
                NoticeModel *model = datas.firstObject;
                if (block) {
                    block(model);
                }
            }
        }
    };
    [listVM refreshData];
}

- (void)getNewNotice{
    
    NoticeListViewModel *listVM = [NoticeListViewModel new];
    listVM.rows = @"100";
    listVM.showType = @"2";
    listVM.CompleteHandler = ^(BOOL isSuccess, BOOL hasMore, NSMutableArray *datas) {
        if (isSuccess) {
            
            [self.messageArray removeAllObjects];
            [self.messageArray addObjectsFromArray:datas];
            
            [self refreshUI];
        }
    };
    [listVM refreshData];
    
}

- (void)addNewMessageWithDic:(NSDictionary *)dic{
    NoticeModel *model = [NoticeModel mj_objectWithKeyValues:dic];
    if (!IsNull(model.nid)) {
        [self.messageArray addObject:model];
        [self refreshUI];
    }
}

- (NSMutableArray *)messageTitleArray{
    NSMutableArray *arr = [NSMutableArray array];
    for (NoticeModel *message in self.messageArray) {
        [arr addObject:message.content];
    }
    
    return arr;
}

- (NSMutableArray *)messageArray{
    if (!_messageArray) {
        _messageArray = [NSMutableArray array];
    }
    return _messageArray;
}

@end
