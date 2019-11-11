//
//  CTMediator+ModuleBookActions.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/9/15.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "CTMediator.h"

@interface CTMediator (ModuleBookActions)

- (UIViewController *)CTMediator_BookViewController;
- (void)CTMediator_ShowOrdDetailWithOrdID:(NSString *)ordID nav:(UINavigationController *)nav;

/**
 mine - 获取今日数据
 @param block return block
 */
- (void)CTMediator_getTodayDataWithOperatorNo:(NSString *)operatorNo block:(void (^)(id orderCount,id totalAmount))block;
@end

