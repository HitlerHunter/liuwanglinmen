//
//  NoticeListViewModel.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/9/21.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "NoticeListViewModel.h"
#import "NoticeModel.h"

@implementation NoticeListViewModel

- (instancetype)init{
    self = [super init];
    if (self) {
        self.rows = @"20";
    }
    return self;
}

- (NSInteger)startPage{
    return 0;
}

- (void)requestDataWithCompleteHandler:(refreshBlock)handler{
    
    NewParams;
    [params setSafeObject:@(self.page) forKey:@"page"];
    [params setSafeObject:self.rows forKey:@"rows"];
    [params setSafeObject:self.userNo forKey:@"userNo"];
    [params setSafeObject:@"0" forKey:@"aimUserId"];
    [params setSafeObject:self.type forKey:@"noticeType"];
    [params setSafeObject:self.showType forKey:@"showType"];
    
    ZZNetWorker.POST.zz_willHandlerParam(NO).zz_param(params)
    .zz_url(@"/payment-biz/noticeRecord/appPage")
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        
        if (model_net.success) {
            
            NSArray *arr = [NoticeModel mj_objectArrayWithKeyValuesArray:model_net.data[@"records"]];
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

#pragma mark - 操作
/**清空*/
+ (void)clearNoticeWithBlock:(void (^)(BOOL isSuccess))block{
    
    NSString *url = [NSString stringWithFormat:@"/payment-biz/noticeRecord/batchDeleteByUserNo/%@",CurrentUser.usrNo];
    ZZNetWorker.DELETE.zz_param(@{})
    .zz_url(url)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        
        if (block) {
            block(model_net.success);
        }
      
    });
}

/**删除*/
+ (void)removeNoticeWithNoticeId:(NSString *)noticeId
                           block:(void (^)(BOOL isSuccess))block{
    
    
    NSString *url = [NSString stringWithFormat:@"/payment-biz/noticeRecord/%@",noticeId];
    ZZNetWorker.DELETE.zz_param(@{})
    .zz_url(url)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        
        if (block) {
            block(model_net.success);
        }
      
    });
}
@end
