//
//  AddressSelectViewController.h
//  ScanPurse
//
//  Created by zenglizhi on 2018/3/27.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "SDBaseViewController.h"
#import "LZAddressEnum.h"

@class LZAddressCenter;
@interface AddressSelectViewController : SDBaseViewController
@property (nonatomic, strong) LZAddressCenter *center;
- (instancetype)initWithType:(AddressSelectType)type
                     superId:(NSString *)superId
                      center:(LZAddressCenter *)center;
@end
