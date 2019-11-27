//
//  CTMediator+ModuleMineActions.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/9/17.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "CTMediator.h"

@interface CTMediator (ModuleMineActions)

- (SDBaseNavigationController *)CTMediator_NavForMine;
/**报表管理*/
- (UIViewController *)CTMediator_FormDataManagerController;
/**收银员管理*/
- (UIViewController *)CTMediator_ManManagerController;
/**选择店铺*/
- (UIViewController *)CTMediator_SelectStoreWithDataArray:(NSArray *)dataArray block:(void (^)(NSInteger index,NSString *storeName))block;
/**获取收银员列表*/
- (void)CTMediator_getOperatorMansWithBlock:(void (^)(NSArray *datas))block;
/**店铺信息编辑资料*/
- (void)CTMediator_EditShopInfoViewControllerWithNav:(UINavigationController *)nav;
- (UIViewController *)CTMediator_OrderManagerController;
@end
