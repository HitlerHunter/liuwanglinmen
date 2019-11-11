//
//  AMAddressModel.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/11/2.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "AMAddressModel.h"

@implementation AMAddressModel

- (NSString *)name{
    if (IsNull(_cityName)) {
        return _provinceName;
    }
    return _cityName;
}

- (NSString *)code{
    if (IsNull(_cityCode)) {
        return _provinceCode;
    }
    return _cityCode;
}

@end
