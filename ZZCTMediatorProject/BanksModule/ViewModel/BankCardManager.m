//
//  BankCardManager.m
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2019/1/22.
//  Copyright © 2019 徐迪华. All rights reserved.
//

#import "BankCardManager.h"
#import "BankCardModel.h"

@implementation BankCardManager

+ (void)addCardWithType:(BankCardType)cardType
                 params:(NSDictionary *)params
                  block:(SimpleBoolBlock)block{
    
    NSString *url = @"/user-biz/creditCard";
    if (cardType == BankCardTypeDebit) {
        url = @"/user-biz/debitCard";
    }
    
    [SVProgressHUD showWithStatus:@"正在上传..."];
    ZZNetWorker.POST.zz_url(url).zz_willHandlerParam(NO)
    .zz_param(params)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        [SVProgressHUD dismiss];
        if (model_net.success) {
            if(block)block(YES);
        }else{
            [SVProgressHUD showErrorWithStatus:model_net.message];
        }
    });
    
}

+ (void)editCardWithType:(BankCardType)cardType
                  params:(NSDictionary *)params
                   block:(SimpleBoolBlock)block{
    
    NSString *url = @"/user-biz/creditCard";
    if (cardType == BankCardTypeDebit) {
        url = @"/user-biz/debitCard";
    }
    
    [SVProgressHUD showWithStatus:@"正在修改..."];
    ZZNetWorker.PUT.zz_url(url)
    .zz_param(params)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        [SVProgressHUD dismiss];
        if (model_net.success) {
            if(block)block(YES);
        }else{
            [SVProgressHUD showErrorWithStatus:model_net.message];
        }
    });
}

+ (void)removeCardWithType:(BankCardType)cardType
                    cardNo:(NSString *)cardNo
                     block:(SimpleBoolBlock)block{
    
    NSString *url = @"/user-biz/creditCard";
    if (cardType == BankCardTypeDebit) {
        url = @"/user-biz/debitCard";
    }
    url = [NSString stringWithFormat:@"%@/%@",url,cardNo];
    [SVProgressHUD showWithStatus:@"正在删除..."];
    
    ZZNetWorker.DELETE.zz_url(url)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        [SVProgressHUD dismiss];
        if (model_net.success) {
            if(block)block(YES);
        }else{
            [SVProgressHUD showErrorWithStatus:model_net.message];
        }
    });
    
    
}

+ (void)getDebitCardWithBlock:(SimpleObjBlock)block{
    
    [self getDebitCardWithStatus:@"0" block:^(NSArray *array) {
        if (block) {
            block(array);
        }
    }];
}

+ (void)getDefaultBankCard:(void (^)(DebitCardModel *debitCard))block{
    
    [self getDebitCardWithStatus:@"0" block:^(NSArray *array) {
        if (array.count && block) {
            block(array.firstObject);
        }else{
            [self getDebitCardWithStatus:@"2" block:^(NSArray *array1) {
                if (array1.count && block) {
                    block(array1.firstObject);
                }else if(block){
                    block(nil);
                }
            }];
        }
    }];
}


+ (void)getDebitCardWithStatus:(NSString *)status
                         block:(void (^)(NSArray *array))block{
    
    NewParams;
 
    [params setSafeObject:CurrentUser.usrNo forKey:@"usrNo"];
    [params setSafeObject:status forKey:@"state"];
    
    ZZNetWorker.POST.zz_willHandlerParam(NO)
    .zz_url(@"/user-biz/debitCard/page")
    .zz_param(params)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        
        if (model_net.success) {
            
            NSArray *arr = model_net.data[@"records"];
            NSArray *modelArray = [DebitCardModel mj_objectArrayWithKeyValuesArray:arr];
            if (block) {
                block(modelArray);
            }
        }
    });
}
@end
