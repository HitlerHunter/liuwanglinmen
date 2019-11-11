//
//  ZZLocationManager.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/10/23.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZCLGeocoder.h"
NS_ASSUME_NONNULL_BEGIN


@interface ZZLocationManager : NSObject

+ (ZZLocationManager *)shareInstance;

- (void)start:(ZZLocationBlock)block;
- (void)stop;
@end

NS_ASSUME_NONNULL_END
