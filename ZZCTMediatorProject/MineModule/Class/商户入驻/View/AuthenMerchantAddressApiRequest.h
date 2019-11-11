//
//  AuthenMerchantAddressApiRequest.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/11/2.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddressApiProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface AuthenMerchantAddressApiRequest : NSObject <AddressApiProtocol>

@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *provinceCode;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *cityCode;
@property (nonatomic, strong) NSString *district;
@property (nonatomic, strong) NSString *districtCode;

- (void)getDataWithType:(AddressSelectType)type
                superId:(NSString *)superId
                  block:(void (^)(NSArray *datas))block;

@end

NS_ASSUME_NONNULL_END
