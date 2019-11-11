//
//  SettingSwitchCell.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/28.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SettingSwitchCell : LZBaseTableViewCell

@property (nonatomic, strong) UISwitch *switch_;
@property (nonatomic, strong) void (^vauleChangedBlock)(BOOL isOn);
@end

NS_ASSUME_NONNULL_END
