//
//  Target_Main.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/8/21.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "Target_Main.h"
//#import "HomeViewController.h"
#import "Home2ViewController.h"
#import "CollectionMoneyViewController.h"
#import "CouponListViewController.h"
#import "NoticeCenterViewController.h"

@implementation Target_Main

- (SDBaseNavigationController *)Action_mainViewController:(NSDictionary *)params
{
        // 因为action是从属于ModuleA的，所以action直接可以使用ModuleA里的所有声明
    SDBaseNavigationController *mainVC = [[SDBaseNavigationController alloc] initWithRootViewController:[Home2ViewController new]];
    mainVC.navigationBar.shadowImage = [UIImage new];
//    [mainVC.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:LZNavBarTitleColor}];
    return mainVC;
}



- (UIViewController *)Action_SKMManagerViewController:(NSDictionary *)params
{
    CollectionMoneyViewController *vc = [CollectionMoneyViewController new];
    return vc;
}

- (UIViewController *)Action_detailViewController:(NSDictionary *)params
{
        // 因为action是从属于ModuleA的，所以action直接可以使用ModuleA里的所有声明
    UIViewController *VC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MainUserInfoVC"];
    
    return VC;
}

- (UIViewController *)Action_CouponListViewController:(NSDictionary *)params
{
    CouponListViewController *vc = [CouponListViewController new];
    return vc;
}

- (UIViewController *)Action_NoticeCenterViewController:(NSDictionary *)params
{
    NSString *type = params[@"type"];
    NoticeCenterViewController *vc = [[NoticeCenterViewController alloc] initWithType:type];
    return vc;
}

@end
