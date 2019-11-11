//
//  Target_Share.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/10.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "Target_Share.h"
#import "ShareViewController.h"

@implementation Target_Share

- (SDBaseNavigationController *)Action_ShareNavController:(NSDictionary *)params
{
        // 因为action是从属于ModuleA的，所以action直接可以使用ModuleA里的所有声明
    SDBaseNavigationController *mainVC = [[SDBaseNavigationController alloc] initWithRootViewController:[ShareViewController new]];
    mainVC.navigationBar.shadowImage = [UIImage new];
    return mainVC;
}

@end
