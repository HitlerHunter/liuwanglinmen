//
//  CTMediator+ModuleMineActions.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/9/17.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "CTMediator+ModuleMineActions.h"

NSString * const kCTMediatorTargetMine = @"Mine";

NSString * const kCTMediatorActionMineNavCtr = @"mineNavController";
NSString * const kCTMediatorActionSelectStore = @"selectStoreController";
NSString * const kCTMediatorActionFormDataManagerController = @"FormDataManagerController";
NSString * const kCTMediatorActionManManagerController = @"ManManagerController";
NSString * const kCTMediatorActionOrderRecordController = @"OrderRecordController";
NSString * const kCTMediatorActionGoodsManageController = @"GoodsManageController";
NSString * const kCTMediatorActionEditShopInfoViewController = @"pushEditShopInfoViewController";

NSString * const kCTMediatorActionGetOperatorMans = @"getOperatorMans";

@implementation CTMediator (ModuleMineActions)

- (SDBaseNavigationController *)CTMediator_NavForMine
{
    SDBaseNavigationController *viewController = [self performTarget:kCTMediatorTargetMine
                                                              action:kCTMediatorActionMineNavCtr
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

- (UIViewController *)CTMediator_FormDataManagerController
{
    UIViewController *viewController = [self performTarget:kCTMediatorTargetMine
                                                    action:kCTMediatorActionFormDataManagerController
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

- (UIViewController *)CTMediator_ManManagerController
{
    UIViewController *viewController = [self performTarget:kCTMediatorTargetMine
                                                    action:kCTMediatorActionManManagerController
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


- (UIViewController *)CTMediator_SelectStoreWithDataArray:(NSArray *)dataArray block:(void (^)(NSInteger index,NSString *storeName))block
{
    
    UIViewController *viewController = [self performTarget:kCTMediatorTargetMine
                                                        action:kCTMediatorActionSelectStore
                                                        params:@{@"block":block,
                                                                 @"dataArray":dataArray,
                                                                 }
                                             shouldCacheTarget:YES
                                            ];
    if ([viewController isKindOfClass:[UIViewController class]]) {
            // view controller 交付出去之后，可以由外界选择是push还是present
        return viewController;
    } else {
            // 这里处理异常场景，具体如何处理取决于产品
        return [UIViewController new];
    }
}

- (void)CTMediator_getOperatorMansWithBlock:(void (^)(NSArray *datas))block{
    
    [self performTarget:kCTMediatorTargetMine
                 action:kCTMediatorActionGetOperatorMans
                 params:@{@"block":block}
      shouldCacheTarget:NO
     ];
}

- (void)CTMediator_EditShopInfoViewControllerWithNav:(UINavigationController *)nav
{
    if (!nav) {
        return;
    }
    [self performTarget:kCTMediatorTargetMine
                 action:kCTMediatorActionEditShopInfoViewController
                 params:@{@"nav":nav}
      shouldCacheTarget:NO
     ];
    
}
@end
