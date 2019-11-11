//
//  CTMediator+ModuleMainActions.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/8/21.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "CTMediator+ModuleMainActions.h"

NSString * const kCTMediatorTargetMain = @"Main";

NSString * const kCTMediatorActionMainNavCtr = @"mainViewController";
NSString * const kCTMediatorActionTenantDetail = @"detailViewController";
NSString * const kCTMediatorActionSKMManager = @"SKMManagerViewController";
NSString * const kCTMediatorActionSelectTenant = @"selectTenantController";
NSString * const kCTMediatorActionCouponListViewController = @"CouponListViewController";
NSString * const kCTMediatorActionNoticeCenterViewController = @"NoticeCenterViewController";

@implementation CTMediator (ModuleMainActions)

- (SDBaseNavigationController *)CTMediator_NavForMain
{
    SDBaseNavigationController *viewController = [self performTarget:kCTMediatorTargetMain
                                                              action:kCTMediatorActionMainNavCtr
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

- (UIViewController *)CTMediator_SKMManagerViewController
{
    UIViewController *viewController = [self performTarget:kCTMediatorTargetMain
                                                              action:kCTMediatorActionSKMManager
                                                              params:@{@"key":@"value"}
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



- (UIViewController *)CTMediator_TenantDetailViewController
{
    UIViewController *viewController = [self performTarget:kCTMediatorTargetMain
                                                    action:kCTMediatorActionTenantDetail
                                                    params:@{@"key":@"value"}
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

- (UIViewController *)CTMediator_CouponListViewController
{
    UIViewController *viewController = [self performTarget:kCTMediatorTargetMain
                                                    action:kCTMediatorActionCouponListViewController
                                                    params:@{@"key":@"value"}
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

- (UIViewController *)CTMediator_NoticeCenterViewControllerWithDefaultType:(NSString *)type
{
    UIViewController *viewController = [self performTarget:kCTMediatorTargetMain
                                                    action:kCTMediatorActionNoticeCenterViewController
                                                    params:@{@"type":type}
                                         shouldCacheTarget:NO
                                        ];
    if ([viewController isKindOfClass:[UIViewController class]]) {
            // view controller 交付出去之后，可以由外界选择是push还是present
        return viewController;
    } else {
            // 这里处理异常场景，具体如何处理取决于产品
        return [UIViewController new];
    }
}

@end
