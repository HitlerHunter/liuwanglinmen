//
//  CTMediator+Level.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/11.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "CTMediator+Level.h"

NSString * const kCTMediatorTargetLevel = @"Level";
NSString * const kCTMediatorTargetLevelController = @"LevelController";

@implementation CTMediator (Level)

- (UIViewController *)CTMediator_LevelController
{
    UIViewController *viewController = [self performTarget:kCTMediatorTargetLevel
                                                    action:kCTMediatorTargetLevelController
                                                    params:@{}
                                         shouldCacheTarget:NO
                                        ];
    if ([viewController isKindOfClass:[UIViewController class]]) {
            // view controller 交付出去之后，可以由外界选择是push还是present
        return viewController;
    } else {
            // 这里处理异常场景，具体如何处理取决于产品
        return [SDBaseViewController new];
    }
}

@end
