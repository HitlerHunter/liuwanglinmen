//
//  Target_Level.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/11.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "Target_Level.h"
#import "LevelViewController.h"

@implementation Target_Level

- (UIViewController *)Action_LevelController:(NSDictionary *)params
{
        // 因为action是从属于ModuleA的，所以action直接可以使用ModuleA里的所有声明
    LevelViewController *vc = [LevelViewController new];
    return vc;
}

@end
