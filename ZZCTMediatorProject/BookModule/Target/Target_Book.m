//
//  Target_Book.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/9/15.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "Target_Book.h"
#import "OrdDetailViewController.h"
#import "BookViewModel.h"
#import "BookViewController.h"
#import "BookOrderDetailModel.h"

@implementation Target_Book

- (UIViewController *)Action_bookViewController:(NSDictionary *)params
{
        // 因为action是从属于ModuleA的，所以action直接可以使用ModuleA里的所有声明
    BookViewController *vc = [BookViewController new];
    return vc;
}

- (void)Action_showOrdDetailViewController:(NSDictionary *)params
{
    UINavigationController *nav = params[@"nav"];
    
    NSMutableDictionary *params1 = [NSMutableDictionary dictionary];
    [params1 setSafeObject:params[@"ordID"] forKey:@"transNo"];
    
    [SVProgressHUD show];
    ZZNetWorker.GET.zz_param(params1)
    .zz_url(API_getOrderDetailVoByOrderNo)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        [SVProgressHUD dismiss];
        ZZNetWorkModelWithJson(data);
        
        if (model_net.success) {
            BookOrderDetailModel *model = [BookOrderDetailModel mj_objectWithKeyValues:model_net.data];
            OrdDetailViewController *detailVC = [[OrdDetailViewController alloc] initWithModel:model];
            [nav pushViewController:detailVC animated:YES linearBackId:LinearBackId_Order];
        }
    });
}


@end
