//
//  WakeUpAddBirthdayController.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/25.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, MarketPlanType) {
    MarketPlanTypeWakeUp,
    MarketPlanTypeBirthday,
};
@interface WakeUpAddBirthdayController : SDBaseViewController

- (instancetype)initWithMarketPlanType:(MarketPlanType)type;
@end

NS_ASSUME_NONNULL_END
