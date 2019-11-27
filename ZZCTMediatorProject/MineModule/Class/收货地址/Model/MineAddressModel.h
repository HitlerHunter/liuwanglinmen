//
//  MineAddressModel.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/11/19.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineAddressModel : NSObject

@property (nonatomic, strong) NSString *Id;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *areaName;
@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *provName;
@property (nonatomic, strong) NSString *streetName;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *usrNo;
@property (nonatomic, assign) BOOL isDefault;
@property (nonatomic, assign) BOOL delFlag;

@property (nonatomic, strong) NSString *showAddress;
@end

NS_ASSUME_NONNULL_END
