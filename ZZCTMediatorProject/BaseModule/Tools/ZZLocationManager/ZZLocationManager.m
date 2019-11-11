//
//  ZZLocationManager.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/10/23.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "ZZLocationManager.h"
#import <CoreLocation/CoreLocation.h>

@interface ZZLocationManager ()<CLLocationManagerDelegate>

@property (nonatomic,strong ) CLLocationManager *locationManager;//定位服务
@property (nonatomic,strong ) ZZCLGeocoder *geoCoder;
@property (nonatomic, assign) BOOL canLocation;

@property (nonatomic, strong) ZZLocationBlock block;

@end

@implementation ZZLocationManager


+ (ZZLocationManager *)shareInstance{
    static ZZLocationManager *manager;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        if (manager == nil) {
            manager = [[ZZLocationManager alloc]init];
        }
    });
    return manager;
}

- (void)start:(ZZLocationBlock)block{
    self.canLocation = YES;
    self.block = block;
    [self locatemap];
}

- (void)stop{
    [_locationManager stopUpdatingLocation];
}

- (void)locatemap{
    
    if ([CLLocationManager locationServicesEnabled]) {
        
        self.geoCoder.currentCity = [[NSString alloc]init];
        [self.locationManager startUpdatingLocation];
    }
}

- (CLLocationManager *)locationManager{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc]init];
        _locationManager.delegate = self;
        [_locationManager requestAlwaysAuthorization];
        [_locationManager requestWhenInUseAuthorization];
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 5.0;
        
    }
    return _locationManager;
}
- (ZZCLGeocoder *)geoCoder{
    if (!_geoCoder) {
        _geoCoder = [[ZZCLGeocoder alloc] init];
    }
    return _geoCoder;
}

#pragma mark - 定位失败
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    [SVProgressHUD showErrorWithStatus:@"请在设置中打开定位!"];
}

#pragma mark - 定位成功
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    [self stop];
    
    CLLocation *currentLocation = [locations lastObject];
        //当前的经纬度
    SDLog(@"\n 当前的经纬度 %f,%f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);
        //这里的代码是为了判断didUpdateLocations调用了几次 有可能会出现多次调用 为了避免不必要的麻烦 在这里加个if判断 如果大于1.0就return
    
    if (!self.canLocation){//如果调用已经一次，不再执行
        return;
    }
    
    self.canLocation = NO;
    
    //地理反编码 可以根据坐标(经纬度)确定位置信息(街道 门牌等)
    [self.geoCoder reverseGeocodeLocation:currentLocation block:self.block];
}


@end
