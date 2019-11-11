//
//  ZZCLGeocoder.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/9/4.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN
@class ZZCLAddressModel;
typedef void(^ZZLocationBlock)(NSDictionary *dic);
typedef void(^ZZSearchBlock)(NSArray <ZZCLAddressModel *>* dataArray,NSArray *addressArray);

static NSString * const ZZLocationLatitudeKey = @"ZZLocationLatitudeKey";//经度
static NSString * const ZZLocationLongitudeKey = @"ZZLocationLongitudeKey";//维度

static NSString * const ZZLocationCountryKey = @"ZZLocationCountryKey";
static NSString * const ZZLocationStateKey = @"ZZLocationStateKey";//省
static NSString * const ZZLocationCityKey = @"ZZLocationCityKey";
static NSString * const ZZLocationDistrictKey = @"ZZLocationDistrictKey";//区
static NSString * const ZZLocationStreetKey = @"ZZLocationStreetKey";
static NSString * const ZZLocationNameKey = @"ZZLocationNameKey";//具体地址

static NSString * const ZZLocationAllMessageKey = @"ZZLocationAllMessageKey";//拼接完成
static NSString * const ZZLocationStreetNameKey = @"ZZLocationAllMessageKey";//街道+具体地址

@interface ZZCLGeocoder : CLGeocoder

@property (nonatomic,copy) NSString *currentCity;//城市
@property (nonatomic,copy) NSString *strLatitude;//经度
@property (nonatomic,copy) NSString *strLongitude;//维度

- (void)reverseGeocodeLocation:(CLLocation *)location block:(ZZLocationBlock)block;
/**搜索*/
- (void)geocodeAddressString:(NSString *)addressString block:(ZZSearchBlock)block;
@end

@interface ZZCLAddressModel : NSObject

@property (nonatomic) CLLocationCoordinate2D centerCoordinate;
@property (nonatomic,strong) NSString *address;
//@property (nonatomic,strong) NSString *strLongitude;

@end


NS_ASSUME_NONNULL_END
