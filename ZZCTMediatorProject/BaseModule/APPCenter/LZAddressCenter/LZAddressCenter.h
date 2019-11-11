//
//  LZAddressCenter.h
//  ScanPurse
//
//  Created by zenglizhi on 2018/3/27.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LZAddressEnum.h"
#import "AddressApiProtocol.h"

@class LZAddressCenter;
@protocol AddressSelectDelegate <NSObject>

@required
- (void)Center:(LZAddressCenter *)center
      Province:(NSString *)province
            city:(NSString *)city
        district:(NSString *)district;
@end

@interface LZAddressCenter : NSObject

@property (nonatomic, weak) UIViewController <AddressSelectDelegate>*addressRootController;

@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *provinceCode;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *cityCode;
@property (nonatomic, strong) NSString *district;
@property (nonatomic, strong) NSString *districtCode;

@property (nonatomic, strong) id <AddressApiProtocol> apiRequest;

@property (nonatomic, strong) UINavigationController *addressNav;
@property (nonatomic, assign) AddressSelectType finishStep;

+ (LZAddressCenter *)gotoSelectAddressWithController:(UIViewController *)controller;

+ (LZAddressCenter *)gotoSelectAddressWithController:(UIViewController <AddressSelectDelegate>*)controller
apiRequest:(id <AddressApiProtocol>)apiRequest;

+ (LZAddressCenter *)gotoSelectAddressWithController:(UIViewController <AddressSelectDelegate>*)controller
                                                type:(AddressSelectType)type
                                          finishStep:(AddressSelectType)finishStep;

+ (LZAddressCenter *)gotoSelectAddressWithController:(UIViewController <AddressSelectDelegate>*)controller
                                          apiRequest:(id <AddressApiProtocol>)apiRequest
                                                type:(AddressSelectType)type
                                          finishStep:(AddressSelectType)finishStep;

/** superId 上一级 code*/
- (void)getDataWithType:(AddressSelectType)type
                superId:(NSString *)superId
                  block:(void (^)(NSArray *datas))block;

- (void)finishBack;
@end
