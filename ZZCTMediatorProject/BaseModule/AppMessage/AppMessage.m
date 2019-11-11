//
//  AppMessage.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/1/3.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "AppMessage.h"

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

+ (void)getHomePresentNoticeWithBlock:(void(^)(HomeMessageModel *message))block{
    
    NewParams;
    [params setSafeObject:@"merchant" forKey:@"aimUserId"];//商户：merchant 代理商：agent
    
    [params setSafeObject:@"1" forKey:@"showType"];
    
    ZZNetWorker.GET.zz_param(params).zz_url(@"/admin/app/showNotice")
    .zz_isPostByURLSession(YES)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        if (model_net.success) {
            
            HomeMessageModel *model = [HomeMessageModel mj_objectWithKeyValues:model_net.data];
   
            if (block) {
                block(model);
            }
            
        }
        
    });
}

- (void)getNewNotice{
    
    NewParams;
    [params setSafeObject:@"merchant" forKey:@"aimUserId"];//商户：merchant 代理商：agent
    
    [params setSafeObject:@"2" forKey:@"showType"];
    
    ZZNetWorker.GET.zz_param(params).zz_url(@"/admin/app/showNotices")
    .zz_isPostByURLSession(YES)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        if (model_net.success) {
            
            NSArray *arr = [HomeMessageModel mj_objectArrayWithKeyValuesArray:model_net.data];
            [self.messageArray removeAllObjects];
            [self.messageArray addObjectsFromArray:arr];
            
            [self refreshUI];
        }
        
    });
}

- (void)addNewMessageWithDic:(NSDictionary *)dic{
    HomeMessageModel *model = [HomeMessageModel mj_objectWithKeyValues:dic];
    if (!IsNull(model.Id)) {
        [self.messageArray addObject:model];
        [self refreshUI];
    }
}

- (NSMutableArray *)messageTitleArray{
    NSMutableArray *arr = [NSMutableArray array];
    for (HomeMessageModel *message in self.messageArray) {
        [arr addObject:message.title];
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
