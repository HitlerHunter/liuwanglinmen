//
//  MessageTaskViewModel.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/7/3.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "MessageTaskViewModel.h"
#import "MessageSendRecordModel.h"

@implementation MessageTaskViewModel

- (BOOL)refreshable{
    return NO;
}

- (void)requestDataWithCompleteHandler:(refreshBlock)handler{
    
    NewParams;
    [params setSafeObject:@(self.page) forKey:@"page"];
    [params setSafeObject:@20 forKey:@"limit"];
    [params setSafeObject:@([CurrentUser.usrNo integerValue]) forKey:@"usrNo"];
    
    if (_isWaitingSend) {
        //未执行
        [params setSafeObject:@"1" forKey:@"taskStatus"];
    }else{
      
        [params setSafeObject:@"2,3" forKey:@"taskStatus"];
    }
    
    ZZNetWorker.POST.zz_willHandlerParam(NO).zz_param(params)
    .zz_url(@"/outside-biz/smsMarketingTask/page")
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        
        if (model_net.success) {
            
            NSArray *arr = [MessageSendRecordModel mj_objectArrayWithKeyValuesArray:model_net.data[@"records"]];
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

#pragma mark - 编辑任务
+ (void)editTask:(MessageSendRecordModel *)task returnBlock:(void (^)(BOOL isSuccess))returnBlock{
    
    NewParams;
    [params setSafeObject:@(task.taskStatus) forKey:@"taskStatus"];
    [params setSafeObject:task.Id forKey:@"id"];
    
    ZZNetWorker.PUT.zz_param(params).zz_url(@"/general/tbSmsTask")
    .zz_isPostByURLSession(YES)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        
        if (model_net.success) {
                //让本地同步
            if (returnBlock) {
                returnBlock(model_net.success);
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"修改任务失败，请稍后再试"];
        }
        
    });
    
}

#pragma mark - 通过id查询tag名称
+ (void)getTagNameWithId:(NSString *)tagId returnBlock:(void (^)(NSString *TagName))returnBlock{
    
    NewParams;
    [params setSafeObject:tagId forKey:@"id"];
    
    ZZNetWorker.GET.zz_param(params).zz_url(@"/admin/tags/getById")
    .zz_isPostByURLSession(YES)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        
        if (model_net.success) {
                //让本地同步
            if (returnBlock) {
                returnBlock(model_net.data[@"name"]);
            }
        }
        
    });
    
}
@end
