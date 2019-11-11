//
//  CTMediator+ModuleScanActions.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/9/14.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "CTMediator+ModuleScanActions.h"

NSString * const kCTMediatorTargetScan = @"Scan";

NSString * const kCTMediatorActionScanViewController = @"ScanViewController";

@implementation CTMediator (ModuleScanActions)

- (UIViewController *)CTMediator_ScanViewControllerWithMoney:(NSString *)money remark:(NSString *)remark
{
    UIViewController *viewController = [self performTarget:kCTMediatorTargetScan
                                                              action:kCTMediatorActionScanViewController
                                                              params:@{@"title":@"扫一扫",
                                                                       @"money":money,
                                                                       @"remark":remark?remark:@"",
                                                                       }
                                                   shouldCacheTarget:NO
                                                  ];
    if ([viewController isKindOfClass:[UIViewController class]]) {
            // view controller 交付出去之后，可以由外界选择是push还是present
        
        return viewController;
    } else {
            // 这里处理异常场景，具体如何处理取决于产品
        return UIViewController.new;
    }
}

@end
