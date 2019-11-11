//
//  AddressModel.h
//  ScanPurse
//
//  Created by zenglizhi on 2018/3/27.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LZAddressModelProtocol.h"

@interface LZAddressModel : NSObject <LZAddressModelProtocol>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *code;

@property (nonatomic, strong) NSString *siteName;
@property (nonatomic, strong) NSString *siteCode;

@end
