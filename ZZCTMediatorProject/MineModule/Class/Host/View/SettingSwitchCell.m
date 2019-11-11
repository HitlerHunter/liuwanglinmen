//
//  SettingSwitchCell.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/28.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "SettingSwitchCell.h"

@implementation SettingSwitchCell

- (void)initUI{
    UISwitch *swi = [UISwitch new];
    swi.onTintColor = rgb(255,81,0);
    _switch_ = swi;
    
    [self.contentView addSubview:swi];
    [swi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_equalTo(-15);
    }];
    
    [_switch_ addTarget:self action:@selector(switchVauleChanged:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addBottomLine];
    [self setBottomLineX:15];
    [self setBottomlineSpacingRightX:15];
}

- (void)switchVauleChanged:(UISwitch *)sender {
    if (_vauleChangedBlock) {
        _vauleChangedBlock(sender.isOn);
    }
}

@end
