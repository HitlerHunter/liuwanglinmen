//
//  AMAddressModel.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/11/2.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LZAddressModelProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface AMAddressModel : NSObject <LZAddressModelProtocol>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *code;

@property (nonatomic, strong) NSString *provinceName;
@property (nonatomic, strong) NSString *provinceCode;
@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, strong) NSString *cityCode;

@end

NS_ASSUME_NONNULL_END
