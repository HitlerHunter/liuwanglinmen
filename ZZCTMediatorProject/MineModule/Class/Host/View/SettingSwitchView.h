//
//  SettingSwitchView.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/9/20.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "SDBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SettingSwitchView : SDBaseView

@property (nonatomic, strong) UISwitch *switch_;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, assign) BOOL isOn;
@property (nonatomic, strong) void (^vauleChangedBlock)(BOOL isOn);
@end

NS_ASSUME_NONNULL_END
