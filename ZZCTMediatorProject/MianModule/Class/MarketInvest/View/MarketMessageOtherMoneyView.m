//
//  MarketMessageOtherMoneyView.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/26.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "MarketMessageOtherMoneyView.h"

@implementation MarketMessageOtherMoneyView

- (void)initUI{
    [self addTopLine];
    [self setTopLineX:15];
    
    self.backgroundColor = LZWhiteColor;
    
    UILabel *lab = [UILabel labelWithFontSize:14 text:@"其他金额" textColor:rgb(53,53,53)];
    [self addSubview:lab];
    
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self);
        make.height.mas_equalTo(16);
    }];
    
    UITextField *textField = [[UITextField alloc] init];
    textField.textColor = rgb(255,81,0);
    textField.font = Font_PingFang_SC_Medium(18);
    textField.keyboardType = UIKeyboardTypeNumberPad;
    [self addSubview:textField];
    _textField = textField;
    
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lab.mas_right).offset(10);
        make.centerY.mas_equalTo(self);
        make.height.mas_equalTo(16);
        make.width.mas_greaterThanOrEqualTo(60);
    }];
    
    UILabel *lable_info = [UILabel labelWithFontSize:14 text:@"" textColor:rgb(152,152,152)];
    [self addSubview:lable_info];
    _label_info = lable_info;
    
    [lable_info mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(textField.mas_right).offset(10);
        make.centerY.mas_equalTo(self);
        make.height.mas_equalTo(16);
    }];
    
    NSMutableAttributedString *attPlaceholder = [[NSMutableAttributedString alloc] initWithString:@"请输入金额" attributes:@{NSFontAttributeName:Font_PingFang_SC_Regular(14),NSForegroundColorAttributeName:rgb(152,152,152)}];
    textField.attributedPlaceholder = attPlaceholder;
    
    [textField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        if (x.integerValue == 0) {
            lable_info.text = @"";
        }else {
            lable_info.text = [NSString stringWithFormat:@"(预计到账%ld条)",[[MarketMessageManager shareInstance] messageCountWithMoney:x]];
        }
    }];
}

@end
