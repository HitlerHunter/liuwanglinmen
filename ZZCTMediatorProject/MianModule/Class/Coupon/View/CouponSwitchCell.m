//
//  CouponSwitchCell.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/28.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "CouponSwitchCell.h"

@implementation CouponSwitchCell

- (void)initUI{
    
    self.backgroundColor = LZWhiteColor;
    
    UILabel *title_label = [UILabel labelWithFontSize:16 textColor:rgb(53,53,53)];

    UISwitch *sw = [[UISwitch alloc] init];
    
    [self addSubview:title_label];
    [self addSubview:sw];

    
    [title_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self);
    }];
    
   
    [sw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(self);
    }];
    
    
    _title_label = title_label;
    _switch_ = sw;
    
}


- (void)setTitle:(NSString *)title{
    _title_label.text = title;
}

- (void)setIsSelected:(BOOL)isSelected{
    _switch_.on = isSelected;
}

- (BOOL)isSelected{
    return _switch_.on;
}

@end
