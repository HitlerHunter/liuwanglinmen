//
//  RewardCityModel.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/21.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RewardCityModel : NSObject


@property (nonatomic, strong) NSString *shopLog;
@property (nonatomic, strong) NSString *shopType;
@property (nonatomic, strong) NSString *distance;
@property (nonatomic, strong) NSString *shopName;
@property (nonatomic, strong) NSString *shopMobile;
@property (nonatomic, strong) NSString *shopProvince;
@property (nonatomic, strong) NSString *shopCity;
@property (nonatomic, strong) NSString *shopArea;
@property (nonatomic, strong) NSString *shopAddress;

@property (nonatomic, strong) NSString *showAddress;
@property (nonatomic, strong) NSString *showDistance;
@end

NS_ASSUME_NONNULL_END
