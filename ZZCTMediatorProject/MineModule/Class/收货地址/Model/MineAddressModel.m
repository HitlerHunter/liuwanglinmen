//
//  MineAddressModel.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/11/19.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "MineAddressModel.h"

@implementation MineAddressModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"Id":@"id"};
}

- (NSString *)showAddress{
    if (!_showAddress) {
        _showAddress = @"";
        
        if (!IsNull(self.provName)) {
            _showAddress = self.provName;
        }
        
        if (!IsNull(self.cityName)) {
//            _showAddress = [_showAddress stringByAppendingString:@" "];
            _showAddress = [_showAddress stringByAppendingString:self.cityName];
        }
        
        if (!IsNull(self.areaName)) {
//            _showAddress = [_showAddress stringByAppendingString:@" "];
            _showAddress = [_showAddress stringByAppendingString:self.areaName];
        }
        
        if (!IsNull(self.streetName)) {
//            _showAddress = [_showAddress stringByAppendingString:@" "];
            _showAddress = [_showAddress stringByAppendingString:self.streetName];
        }
        
        if (!IsNull(self.address)) {
//            _showAddress = [_showAddress stringByAppendingString:@" "];
            _showAddress = [_showAddress stringByAppendingString:self.address];
        }
    }
    return _showAddress;
}
@end
