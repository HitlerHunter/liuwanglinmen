//
//  MarketBoardManager.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/25.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "MarketBoardManager.h"
#import "MarketBoardCreateViewController.h"

 NSString *getMarketBoardTypeTitleWithTypeStr(NSString *typeStr){
     if ([typeStr isEqualToString:MarketPlanTypeWakeUpString]) {
         return MarketPlanTypeWakeUpTitle;
     }else if ([typeStr isEqualToString:MarketPlanTypeBirthdayString]) {
         return MarketPlanTypeBirthdayTitle;
     }else if ([typeStr isEqualToString:MarketPlanTypeCustomString]) {
         return MarketPlanTypeCustomTitle;
     }
     
     return @"";
 };

NSString *getMarketBoardTypeStrWithTypeTitle(NSString *title){
    if ([title isEqualToString:MarketPlanTypeWakeUpTitle]) {
        return MarketPlanTypeWakeUpString;
    }else if ([title isEqualToString:MarketPlanTypeBirthdayTitle]) {
        return MarketPlanTypeBirthdayString;
    }else if ([title isEqualToString:MarketPlanTypeCustomTitle]) {
        return MarketPlanTypeCustomString;
    }
    
    return MarketPlanTypeCustomString;
};

@interface MarketBoardManager ()


@end

@implementation MarketBoardManager

+ (MarketBoardManager *)shareInstance{
    static MarketBoardManager *manager;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        if (manager == nil) {
            manager = [[MarketBoardManager alloc]init];
//            [manager requestPublicBoardData];
            [manager requestMineBoardData];
            
        }
    });
    return manager;
}

- (void)refreshData{
//    [self requestPublicBoardData];
    [self requestMineBoardData];
}


- (NSMutableArray *)getMineBoardArrayWithType:(NSString *)type{
    NSMutableArray *arr = [NSMutableArray array];
    for (MarketBoardCellModel *model in self.mineBoardArray) {
        if ([model.businessType isEqualToString:type]) {
            [arr addObject:model.modelCopy];
        }
    }
    
    return arr;
}

- (NSMutableArray *)getMineBoardArrayWithOutUnpassByType:(NSString *)type{
    NSMutableArray *arr = [NSMutableArray array];
    for (MarketBoardCellModel *model in self.mineBoardArray) {
        if ([model.businessType isEqualToString:type] && model.status == MarketBoardStatusSuccess) {
            [arr addObject:model.modelCopy];
        }
    }
    
    return arr;
}

- (NSMutableArray *)getPublicBoardArrayWithType:(NSString *)type{
    NSMutableArray *arr = [NSMutableArray array];
    for (MarketBoardCellModel *model in self.publicBoardArray) {
        if ([model.businessType isEqualToString:type]) {
            [arr addObject:model.modelCopy];
        }
    }
    
    return arr;
}

- (NSMutableArray *)mineBoardArray{
    if (!_mineBoardArray) {
        _mineBoardArray = [NSMutableArray array];
    }
    return _mineBoardArray;
}

- (NSMutableArray *)publicBoardArray{
    if (!_publicBoardArray) {
        _publicBoardArray = [NSMutableArray array];
    }
    return _publicBoardArray;
}

#pragma mark - 获取模板
- (void)requestPublicBoardData{
    
    NewParams;
 
    ZZNetWorker.POST
    .zz_willHandlerParam(NO).zz_param(params)
    .zz_url(@"/outside-biz/smsMarketingTemplate/page")
    .zz_isPostByURLSession(YES)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        
        [self.publicBoardArray removeAllObjects];
        
        if (model_net.success) {
            NSArray *arr = [MarketBoardCellModel mj_objectArrayWithKeyValuesArray:model_net.data[@"records"]];
            [self.publicBoardArray addObjectsFromArray:arr];
            self.changed ++;
        }
    });
}

- (void)requestMineBoardData{
    
    NewParams;

    ZZNetWorker.POST
    .zz_willHandlerParam(NO).zz_param(params)
    .zz_url(@"/outside-biz/smsMarketingTemplate/page")
    .zz_isPostByURLSession(YES)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        
        if (model_net.success) {
            [self.mineBoardArray removeAllObjects];
            
            NSArray *arr = [MarketBoardCellModel mj_objectArrayWithKeyValuesArray:model_net.data[@"records"]];
            [self.mineBoardArray addObjectsFromArray:arr];
            self.changed ++;
        }
    });
}

#pragma mark - 添加模板
- (void)addBoard:(MarketBoardCellModel *)board returnBlock:(void (^)(BOOL isSuccess))returnBlock{
    
    NewParams;
    [params setSafeObject:board.businessType forKey:@"businessType"];
    [params setSafeObject:board.templateContent forKey:@"templateContent"];
    [params setSafeObject:board.templateHead forKey:@"templateHead"];
    [params setSafeObject:board.userName forKey:@"userName"];
    
    ZZNetWorker.POST.zz_param(params).zz_url(@"/outside-biz/smsMarketingTemplate")
    .zz_setParamType(ZZNetWorkerParamTypeAppendAfterURL)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        
        if (model_net.success) {
            [self requestMineBoardData];
        }else{
            [SVProgressHUD showErrorWithStatus:@"添加模板失败，稍后重试或检查内容是否含有非法字符"];
        }
        if (returnBlock) {
            returnBlock(model_net.success);
        }
    });
}

#pragma mark - 删除模板
- (void)removeBoard:(MarketBoardCellModel *)board{
    
    NSString *urlStr = [NSString stringWithFormat:@"/outside-biz/smsMarketingTemplate/%@",board.Id];

    ZZNetWorker.DELETE.zz_param(@{}).zz_url(urlStr)
    .zz_isPostByURLSession(YES)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        
        if (model_net.success) {
            [self.mineBoardArray removeObject:board];
            self.changed ++;
        }else{
            [SVProgressHUD showErrorWithStatus:@"删除模板失败，请稍后再试"];
        }
    });
    
}

#pragma mark - 编辑模板
- (void)editBoard:(MarketBoardCellModel *)board returnBlock:(void (^)(BOOL isSuccess))returnBlock{
    
    NewParams;
    [params setSafeObject:board.businessType forKey:@"businessType"];
    [params setSafeObject:board.templateContent forKey:@"templateContent"];
    [params setSafeObject:board.templateHead forKey:@"templateHead"];
    [params setSafeObject:board.Id forKey:@"id"];
    
    ZZNetWorker.PUT.zz_param(params).zz_url(@"/general/tbSmsTemplate")
    .zz_isPostByURLSession(YES)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        
        //让本地同步
        if (returnBlock) {
            returnBlock(model_net.success);
        }
        
        if (model_net.success) {
            self.changed ++;
            //重新请求数据
            [self requestMineBoardData];
        }else{
            [SVProgressHUD showErrorWithStatus:@"修改模板失败，请稍后再试"];
        }
        
    });
    
}
@end


