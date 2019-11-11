//
//  Target_Mine.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/9/17.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "Target_Mine.h"
#import "SelectStoreViewController.h"

#import "Mine1ViewController.h"
#import "DataCollectionViewController.h"

#import "EditShopInfoViewController.h"
#import "EditShopModel.h"
#import "EditShopViewModel.h"

@implementation Target_Mine

- (SDBaseNavigationController *)Action_mineNavController:(NSDictionary *)params
{
        // 因为action是从属于ModuleA的，所以action直接可以使用ModuleA里的所有声明
    SDBaseNavigationController *mainVC = [[SDBaseNavigationController alloc] initWithRootViewController:[Mine1ViewController new]];
    mainVC.navigationBar.shadowImage = [UIImage new];
    return mainVC;
}

- (UIViewController *)Action_selectStoreController:(NSDictionary *)params
{
    SelectStoreViewController *VC = [[SelectStoreViewController alloc] initWithDataArray:params[@"dataArray"]];
    VC.block = params[@"block"];
    VC.modalPresentationStyle = UIModalPresentationOverFullScreen;
    return VC;
}

- (UIViewController *)Action_FormDataManagerController:(NSDictionary *)params
{
    DataCollectionViewController *vc = [DataCollectionViewController new];

    return vc;
}



- (void)Action_pushEditShopInfoViewController:(NSDictionary *)params
{
    UINavigationController *nav = params[@"nav"];
    [EditShopViewModel getShopInfoWithBlock:^(EditShopModel * _Nonnull shopModel) {
        EditShopInfoViewController *vc = [[EditShopInfoViewController alloc] initWithShopModel:shopModel];
        [nav pushViewController:vc animated:YES];
    }];
    
}

@end
