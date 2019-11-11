//
//  CTMediator+ModuleShareActions.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/10.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "CTMediator+ModuleShareActions.h"

NSString * const kCTMediatorTargetShare = @"Share";
NSString * const kCTMediatorTargetShareNavCtr = @"ShareNavController";

@implementation CTMediator (ModuleShareActions)

- (SDBaseNavigationController *)CTMediator_NavForShare
{
    SDBaseNavigationController *viewController = [self performTarget:kCTMediatorTargetShare
                                                              action:kCTMediatorTargetShareNavCtr
                                                              params:@{@"key":@"value"}
                                                   shouldCacheTarget:NO
                                                  ];
    if ([viewController isKindOfClass:[SDBaseNavigationController class]]) {
            // view controller 交付出去之后，可以由外界选择是push还是present
        return viewController;
    } else {
            // 这里处理异常场景，具体如何处理取决于产品
        return [[SDBaseNavigationController alloc] initWithRootViewController:[SDBaseViewController new]];
    }
}

@end
