//
//  AdvertManager.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/7/8.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "AdvertManager.h"
#import "BankCardManager.h"
#import "GoodsDetailViewController.h"

@implementation AdvertModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"Id":@"id"};
}

@end

@implementation AdvertManager
/** activity:活动页    home:首页   other:其他 */
+ (void)getAdvertWithType:(AdvertType)type block:(void (^)(NSArray <AdvertModel *>*arr))block{
    
    NewParams;
    [params setSafeObject:@1 forKey:@"page"];
    [params setSafeObject:@100 forKey:@"limit"];
    [params setSafeObject:@"orderByField" forKey:@"orderByField"];
    [params setSafeObject:@"1" forKey:@"valid"];
    
    
    if (type == AdvertTypeMine) {
        [params setSafeObject:@"activity" forKey:@"location"];
    }else if (type == AdvertTypeHome) {
        [params setSafeObject:@"home" forKey:@"location"];
    }else if (type == AdvertTypeOther) {
        [params setSafeObject:@"other" forKey:@"location"];
    }
    
    ZZNetWorker.GET.zz_url(@"/outside-biz/advertising/location").zz_param(params)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        
        if (model_net.success) {
            
            NSArray *array = model_net.data;
            NSArray *dataArray = [AdvertModel mj_objectArrayWithKeyValuesArray:array];
            
            
            if (block) {
                block(dataArray);
            }
        }
    });
}

+ (void)tapAdvertModel:(AdvertModel *)model withController:(UIViewController *)controller{
    
    if ([model.func isEqualToString:@"upgrade"]) {
        [(UITabBarController *)KeyWindow.rootViewController setSelectedIndex:2];
        return;
    }else if ([model.func isEqualToString:@"shopping"]) {
        GoodsDetailViewController *vc = [GoodsDetailViewController new];
        [controller.navigationController pushViewController:vc animated:YES];
        return;
    }else if ([model.func isEqualToString:@"cash"]) {
        APPCenterCheckRealName
        [self getBankCardNumberWithController:controller];
        return;
    }else if ([model.func isEqualToString:@"applycard"]) {
        
        NSString *url;
        if (CurrentUser.userLvl == 0) {
            url = model.remark;
        }else{
            url = model.redirectUrl;
        }
        url = [NSString stringWithFormat:@"%@?userNo=%@",url,CurrentUser.usrNo];
        H5CommonViewController *h5 = [[H5CommonViewController alloc] initWithNoEncodeUrl:url];
        [controller.navigationController pushViewController:h5 animated:YES];
        
        return;
    }else
    
    if (model.redirectFlag == 1 && !IsNull(model.redirectUrl) && model.redirectUrl.length > 0) {
        H5CommonViewController *h5 = [[H5CommonViewController alloc] initWithNoEncodeUrl:model.redirectUrl];
        [controller.navigationController pushViewController:h5 animated:YES];
    }
}

+ (void)getBankCardNumberWithController:(UIViewController *)controller{
    
    [BankCardManager getDefaultBankCard:^(DebitCardModel * _Nonnull debitCard) {
        [self getCashUrlWithCardNumber:debitCard.debitCardNo withController:controller];
    }];
}

+ (void)getCashUrlWithCardNumber:(NSString *)card withController:(UIViewController *)controller{
    
    NewParams;

    [params setSafeObject:card forKey:@"debitNo"];
    [params setSafeObject:[NSUUID UUID].UUIDString forKey:@"ep"];
    
    ZZNetWorker.GET.zz_url(@"/cash-biz/cash")
    .zz_param(params)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        
        if (model_net.success) {
            
            H5CommonViewController *h5 = [[H5CommonViewController alloc] initWithNoEncodeUrl:model_net.data];
            [controller.navigationController pushViewController:h5 animated:YES];
        }
    });
}

@end
