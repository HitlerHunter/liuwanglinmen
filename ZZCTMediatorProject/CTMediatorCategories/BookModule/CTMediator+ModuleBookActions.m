//
//  CTMediator+ModuleBookActions.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/9/15.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "CTMediator+ModuleBookActions.h"

NSString * const kCTMediatorTargetBook = @"Book";

NSString * const kCTMediatorActionBookController = @"bookViewController";
NSString * const kCTMediatorActionShowOrdDetailVC = @"showOrdDetailViewController";


NSString * const kCTMediatorActionGetToDayData = @"getTodayData";

@implementation CTMediator (ModuleBookActions)

- (UIViewController *)CTMediator_BookViewController
{
    UIViewController *viewController = [self performTarget:kCTMediatorTargetBook
                                                              action:kCTMediatorActionBookController
                                                              params:@{@"key":@"value"}
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

- (void)CTMediator_ShowOrdDetailWithOrdID:(NSString *)ordID nav:(UINavigationController *)nav
{
    [self performTarget:kCTMediatorTargetBook
                 action:kCTMediatorActionShowOrdDetailVC
                 params:@{@"ordID":ordID,
                          @"nav":nav,
                          }
      shouldCacheTarget:NO
     ];
}


- (void)CTMediator_getTodayDataWithOperatorNo:(NSString *)operatorNo block:(void (^)(id orderCount,id totalAmount))block{
    NewParams;
    [params setSafeObject:operatorNo forKey:@"operatorNo"];
    [params setSafeObject:block forKey:@"block"];
    
    [params setSafeObject:[self configBeginDate] forKey:@"beginTime"];
    [params setSafeObject:[self configEndDate] forKey:@"endTime"];
    
    [self performTarget:kCTMediatorTargetBook
                 action:kCTMediatorActionGetToDayData
                 params:params
      shouldCacheTarget:NO
     ];
}


- (NSString *)configBeginDate{
    NSDate *beginDate = [NSDate date];
    NSString *beginStr = [beginDate formatYMDWithSeparate:@"-"];
    beginStr = [beginStr stringByAppendingString:@" 00:00:00"];
    return beginStr;
}

- (NSString *)configEndDate{
    
    NSDate *endDate = [NSDate date];
    NSString *endStr = [endDate formatYMDWithSeparate:@"-"];
    endStr = [endStr stringByAppendingString:@" 23:59:59"];
    
    return endStr;
}
@end
