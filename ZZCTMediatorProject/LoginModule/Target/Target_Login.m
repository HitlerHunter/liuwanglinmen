//
//  Target_Login.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/9/10.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "Target_Login.h"

@implementation Target_Login

- (SDBaseNavigationController *)Action_loginViewController:(NSDictionary *)params
{
        // 因为action是从属于ModuleA的，所以action直接可以使用ModuleA里的所有声明
    SDBaseNavigationController *logVC = [[UIStoryboard storyboardWithName:@"Login" bundle:nil]instantiateViewControllerWithIdentifier:@"LoginNavigationController"];
    logVC.navigationBar.shadowImage = [UIImage new];
    [logVC.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:LZNavBarTitleColor}];
    return logVC;
}

@end
