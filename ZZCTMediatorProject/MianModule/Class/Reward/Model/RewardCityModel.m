//
//  RewardCityModel.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/21.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "RewardCityModel.h"

@implementation RewardCityModel

- (NSString *)showAddress{
    if (!_showAddress) {
//        if (self.shopProvince) {
//            _showAddress = self.shopProvince;
//        }
        
        if (self.shopCity) {
            _showAddress = self.shopCity;
        }
        
        if (self.shopArea) {
            _showAddress = [_showAddress stringByAppendingString:self.shopArea];
        }
        
        if (self.shopAddress) {
            _showAddress = [_showAddress stringByAppendingString:self.shopAddress];
        }
        
    }
    return _showAddress;
}


- (NSString *)showDistance{
    if (_distance.doubleValue < 1000) {
        return [NSString stringWithFormat:@"< %.2lf m",_distance.doubleValue];
    }
    return [NSString stringWithFormat:@"< %.2lf km",_distance.doubleValue/1000.0];
}

@end
