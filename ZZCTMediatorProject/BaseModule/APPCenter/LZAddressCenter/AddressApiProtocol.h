//
//  AddressApiProtocol.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/11/2.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LZAddressEnum.h"
NS_ASSUME_NONNULL_BEGIN

@protocol AddressApiProtocol <NSObject>

@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *provinceCode;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *cityCode;
@property (nonatomic, strong) NSString *district;
@property (nonatomic, strong) NSString *districtCode;

@required
- (void)getDataWithType:(AddressSelectType)type
                superId:(NSString *)superId
                  block:(void (^)(NSArray *datas))block;
@end

NS_ASSUME_NONNULL_END
