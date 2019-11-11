//
//  DealDirectionModel.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/9/28.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DealDirectionType) {
    DealDirectionTypeMoney,
    DealDirectionTypeCount,
};

@interface DealDirectionModel : NSObject
@property (nonatomic, strong) NSString *time;
@property (nonatomic, assign) double tradingAmount;
@property (nonatomic, assign) NSInteger tradingCount;
@end

@interface DealDirectionSectionModel : NSObject
@property (nonatomic,strong) NSArray <DealDirectionModel *> *datas;
@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) NSMutableArray *values;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subtitle;
@property (nonatomic, strong) NSString *yAxisTitle;
@property (nonatomic, assign) DealDirectionType type;

@property (nonatomic, strong) NSArray *colorsArray;

@end
NS_ASSUME_NONNULL_END
