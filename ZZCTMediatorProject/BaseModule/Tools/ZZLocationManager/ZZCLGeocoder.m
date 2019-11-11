//
//  ZZCLGeocoder.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/9/4.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "ZZCLGeocoder.h"

@interface ZZCLGeocoder ()

@property (nonatomic, strong) NSMutableDictionary *dic;
@end

@implementation ZZCLGeocoder

- (void)reverseGeocodeLocation:(CLLocation *)location block:(ZZLocationBlock)block{
    
        //地理反编码 可以根据坐标(经纬度)确定位置信息(街道 门牌等)
    @weakify(self);
    [self reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        @strongify(self);
        if (placemarks.count >0) {
            CLPlacemark *placeMark = placemarks[0];
            self.currentCity = placeMark.locality;
            if (!self.currentCity) {
                self.currentCity = @"无法定位当前城市";
            }
            [self.dic removeAllObjects];
            
            [self.dic setSafeObject:@(location.coordinate.latitude) forKey:ZZLocationLatitudeKey];
            [self.dic setSafeObject:@(location.coordinate.longitude) forKey:ZZLocationLongitudeKey];
            
            [self.dic setSafeObject:placeMark.country forKey:ZZLocationCountryKey];
            [self.dic setSafeObject:placeMark.addressDictionary[@"State"] forKey:ZZLocationStateKey];
            [self.dic setSafeObject:placeMark.addressDictionary[@"City"] forKey:ZZLocationCityKey];
            [self.dic setSafeObject:placeMark.addressDictionary[@"SubLocality"] forKey:ZZLocationDistrictKey];
            [self.dic setSafeObject:placeMark.addressDictionary[@"Thoroughfare"] forKey:ZZLocationStreetKey];
            [self.dic setSafeObject:placeMark.addressDictionary[@"Name"] forKey:ZZLocationNameKey];
            
            
            NSMutableString *str = [NSMutableString string];
            NSMutableString *StreetNameStr = [NSMutableString string];
            if (self.dic[ZZLocationStateKey]) {
                [str appendString:self.dic[ZZLocationStateKey]];
            }
            if (self.dic[ZZLocationCityKey]) {
                [str appendString:self.dic[ZZLocationCityKey]];
            }
            if (self.dic[ZZLocationDistrictKey]) {
                [str appendString:self.dic[ZZLocationDistrictKey]];
            }
            if (self.dic[ZZLocationStreetKey]) {
                [str appendString:self.dic[ZZLocationStreetKey]];
                [StreetNameStr appendString:self.dic[ZZLocationStreetKey]];
                
            }
            if (self.dic[ZZLocationNameKey]) {
                if (![self.dic[ZZLocationStreetKey] isEqualToString:self.dic[ZZLocationNameKey]]) {
                    //街道和具体地址相同时就不拼接了
                    [StreetNameStr appendString:self.dic[ZZLocationNameKey]];
                }
                [str appendString:self.dic[ZZLocationNameKey]];
                
            }
            
            [self.dic setSafeObject:str forKey:ZZLocationAllMessageKey];
            [self.dic setSafeObject:StreetNameStr forKey:ZZLocationStreetNameKey];
            
            SDLog(@"%@",self.dic);
            if (block) {
                block(self.dic);
            }
            
        }else if (error == nil && placemarks.count){
            
            NSLog(@"NO location and error return");
        }else if (error){
            
            NSLog(@"loction error:%@",error);
        }
    }];
}

- (void)geocodeAddressString:(NSString *)addressString block:(ZZSearchBlock)block{
    [self geocodeAddressString:addressString completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
       
        NSMutableArray *addressArray = [NSMutableArray array];
        NSMutableArray *titleArray = [NSMutableArray array];
        for (CLPlacemark *placeMark in placemarks) {
            ZZCLAddressModel *model = [ZZCLAddressModel new];
            model.centerCoordinate = placeMark.location.coordinate;
            model.address = placeMark.addressDictionary[@"Name"];
            [addressArray addObject:model];
            [titleArray addObject:model.address];
        }
        if (block) {
            block(addressArray,titleArray);
        }
    }];
}

- (NSMutableDictionary *)dic{
    if (!_dic) {
        _dic = [NSMutableDictionary dictionary];
    }
    return _dic;
}
@end

@implementation ZZCLAddressModel

@end
