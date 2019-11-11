//
//  RewardStatusViewController.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/21.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class RewardRecordModel;
@interface RewardStatusViewController : SDBaseViewController

@property (nonatomic, strong) UINavigationController *nav;

- (instancetype)initWithModel:(RewardRecordModel *)model;
@end

NS_ASSUME_NONNULL_END
