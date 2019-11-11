//
//  AuthenMerchantAddressApiRequest.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/11/2.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "AuthenMerchantAddressApiRequest.h"
#import "AMAddressModel.h"

@implementation AuthenMerchantAddressApiRequest

- (void)getDataWithType:(AddressSelectType)type
                superId:(NSString *)superId
                  block:(void (^)(NSArray *datas))block{
    NewParams;
    [params setSafeObject:@"" forKey:@"cityCode"];
    [params setSafeObject:@"" forKey:@"provinceCode"];
    [params setSafeObject:@"" forKey:@"areaCode"];
    
    if (type == AddressSelectTypeProvince) {
        [self getProvinceDataWithSuperId:@"" block:block];
    }else if (type == AddressSelectTypeCity) {
        [self getCityDataWithSuperId:superId block:block];
    }else if (type == AddressSelectTypeDistrict) {
        [self getDistrictDataWithSuperId:superId block:block];
    }else if (type == AddressSelectTypeStreet) {
        [self getStreetDataWithSuperId:superId block:block];
    }
}

/** superId 上一级 code 获取省*/
- (void)getProvinceDataWithSuperId:(NSString *)superId
                             block:(void (^)(NSArray *datas))block{
    
    NewParams;
    [params setSafeObject:@"" forKey:@"cityCode"];
    [params setSafeObject:@"" forKey:@"provinceCode"];
    [params setSafeObject:@"" forKey:@"areaCode"];
    
    [self getDataWithParams:params url:@"/merchant-biz/rpSysAreaAll/getSysAreaProvinceList" block:block];
}
/** superId 省的code 获取市*/
- (void)getCityDataWithSuperId:(NSString *)superId
                         block:(void (^)(NSArray *datas))block{
    NewParams;
    [params setSafeObject:@"" forKey:@"cityCode"];
    [params setSafeObject:@"" forKey:@"provinceCode"];
    [params setSafeObject:@"" forKey:@"areaCode"];
    [params setSafeObject:superId forKey:@"provinceCode"];
    
    [self getDataWithParams:params url:@"/merchant-biz/rpSysAreaAll/getSysAreaCityList" block:block];
    
}
/** superId 市的code 获取区县*/
- (void)getDistrictDataWithSuperId:(NSString *)superId
                             block:(void (^)(NSArray *datas))block{
    
}

- (void)getStreetDataWithSuperId:(NSString *)superId
                             block:(void (^)(NSArray *datas))block{
    
}

- (void)getDataWithParams:(NSDictionary *)params
                  url:(NSString *)url
                  block:(void (^)(NSArray *datas))block{
    
    ZZNetWorker.GET.zz_param(params)
    .zz_url(url)
    .zz_isPostByURLSession(YES)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        
        if (model_net.success) {
            
            NSArray *arr = [AMAddressModel mj_objectArrayWithKeyValuesArray:model_net.data];
            
            if(block) block(arr);
            
        }
        
        if(block) block(nil);
    });
}

@end
