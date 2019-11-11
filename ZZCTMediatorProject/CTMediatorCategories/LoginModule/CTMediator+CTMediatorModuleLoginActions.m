//
//  CTMediator+CTMediatorModuleLoginActions.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/9/10.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "CTMediator+CTMediatorModuleLoginActions.h"

NSString * const kCTMediatorTargetLogin = @"Login";

NSString * const kCTMediatorActionLoginViewController = @"loginViewController";

@implementation CTMediator (CTMediatorModuleLoginActions)

- (SDBaseNavigationController *)CTMediator_viewControllerForLogin
{
    SDBaseNavigationController *viewController = [self performTarget:kCTMediatorTargetLogin
                                                    action:kCTMediatorActionLoginViewController
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

- (void)CTMediator_showLoginViewController{
    
    [self CTMediator_showLoginViewController:nil];
}

- (void)CTMediator_showLoginViewController:(void (^)(void))block{
    
    UIView *lastView = KeyWindow.rootViewController.view;
    if ([KeyWindow.rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)KeyWindow.rootViewController;
        
        UIViewController *vc = [nav.viewControllers firstObject];
        if ([NSStringFromClass(vc.class) isEqualToString:@"loginViewController"]) {
            return;
        }
    }
    
    SDBaseNavigationController *logVC = [self CTMediator_viewControllerForLogin];
    KeyWindow.rootViewController = logVC;
    
    if(lastView)[KeyWindow addSubview:lastView];
    
    logVC.view.mj_y = kScreenHeight;
    logVC.view.alpha = 0;
    
    [UIView animateWithDuration:0.5 animations:^{
        lastView.alpha = 0;
        logVC.view.mj_y = 0;
        logVC.view.alpha = 1;
    } completion:^(BOOL finished) {
        [lastView removeFromSuperview];
        if(block) block();
    }];
}
@end
