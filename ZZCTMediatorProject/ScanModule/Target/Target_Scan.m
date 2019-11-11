//
//  Target_Scan.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/9/14.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "Target_Scan.h"
#import "ScanViewController.h"

@implementation Target_Scan

- (UIViewController *)Action_ScanViewController:(NSDictionary *)params
{
    ScanViewController *scanVC = [[ScanViewController alloc] init];
    scanVC.navigationItem.title = params[@"title"];
    scanVC.money = params[@"money"];
    scanVC.remark = params[@"remark"];
    return scanVC;
}
@end
