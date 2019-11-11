//
//  CouponDateSettingViewController.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/29.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CouponDate : NSObject

@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;

@property (nonatomic, strong) NSString *startDateStr;
@property (nonatomic, strong) NSString *endDateStr;

@property (nonatomic, assign) BOOL isStart;
/**自选时间段*/
@property (nonatomic, assign) BOOL isCustomDate;
@end

@interface CouponDateSettingViewController : SDBaseViewController

@property (nonatomic, strong) CouponDate *model;
@property (nonatomic, strong) void (^didChangeBlock)(CouponDate *dateModel);
@end

NS_ASSUME_NONNULL_END
