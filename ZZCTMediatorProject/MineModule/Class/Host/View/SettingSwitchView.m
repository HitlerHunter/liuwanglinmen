//
//  SettingSwitchView.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/9/20.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "SettingSwitchView.h"

@implementation SettingSwitchView

- (void)initUI{
    
    self.backgroundColor = LZWhiteColor;
    
    UISwitch *swi = [UISwitch new];
    swi.onTintColor = rgb(255,81,0);
    _switch_ = swi;
    
    [self addSubview:swi];
    [swi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(-15);
    }];
    
    [_switch_ addTarget:self action:@selector(switchVauleChanged:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *lab = [UILabel labelWithFont:Font_PingFang_SC_Regular(14) text:@"" textColor:rgb(53, 53, 53)];
    _titleLabel = lab;
    [self addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(15);
    }];
}

- (void)switchVauleChanged:(UISwitch *)sender {
    if (_vauleChangedBlock) {
        _vauleChangedBlock(sender.isOn);
    }
}

- (void)setIsOn:(BOOL)isOn{
    _switch_.on = isOn;
}

- (BOOL)isOn{
    return _switch_.isOn;
}

@end
