//
//  IPAddressHelper.h
//  ScanPurse
//
//  Created by zenglizhi on 2018/4/12.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IPAddressHelper : NSObject

#pragma mark - 获取设备当前网络IP地址
+ (NSString *)getNetworkIPAddress;
@end
