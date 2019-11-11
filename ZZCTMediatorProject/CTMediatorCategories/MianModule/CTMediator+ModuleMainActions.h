//
//  CTMediator+ModuleMainActions.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/8/21.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "CTMediator.h"

@interface CTMediator (ModuleMainActions)

- (SDBaseNavigationController *)CTMediator_NavForMain;
- (UIViewController *)CTMediator_SKMManagerViewController;
- (UIViewController *)CTMediator_TenantDetailViewController;
- (UIViewController *)CTMediator_CouponListViewController;
- (UIViewController *)CTMediator_NoticeCenterViewControllerWithDefaultType:(NSString *)type;
@end
