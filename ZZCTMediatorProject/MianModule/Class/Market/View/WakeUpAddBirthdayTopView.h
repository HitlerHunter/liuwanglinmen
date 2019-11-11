//
//  WakeUpAddBirthdayTopView.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/25.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "SDBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface WakeUpAddBirthdayTopView : SDBaseView

@property (nonatomic, strong) UILabel *label_time;
@property (nonatomic, strong) UITextField *label_day;

@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *day;

@property (nonatomic, strong) UILabel *label_bottomLeft;
@property (nonatomic, strong) UILabel *label_bottomRight;

@end

NS_ASSUME_NONNULL_END
