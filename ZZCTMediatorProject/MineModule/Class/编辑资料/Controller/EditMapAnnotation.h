//
//  EditMapAnnotation.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/9/3.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface EditMapAnnotation : NSObject<MKAnnotation>
    //遵循协议后,必须实现的三个属性
    //经纬度
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;//为什么使用assign
    //主标题
@property (nonatomic, copy) NSString* title;
    //副标题
@property (nonatomic, copy) NSString *subtitle;
@end

NS_ASSUME_NONNULL_END
