//
//  CouponInputMoneyCell.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/28.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "CouponInputMoneyCell.h"

@implementation CouponInputMoneyCell

- (void)initUI{
    
    self.backgroundColor = LZWhiteColor;
    
    UILabel *title_label = [UILabel labelWithFontSize:16 textColor:rgb(53,53,53)];
    UILabel *right_label = [UILabel labelWithFont:Font_PingFang_SC_Regular(16) text:@"折" textColor:rgb(53,53,53)];
    UILabel *center_label = [UILabel labelWithFont:Font_PingFang_SC_Regular(16) text:@"元，打" textColor:rgb(53,53,53)];
    UILabel *left_label = [UILabel labelWithFont:Font_PingFang_SC_Regular(16) text:@"消费满" textColor:rgb(53,53,53)];
    
    UITextField *textField = [UITextField new];
    textField.backgroundColor = LZBackgroundColor;
    textField.font = Font_PingFang_SC_Regular(14);
    textField.lz_setView.lz_cornerRadius(2);
    textField.placeholder = @"例：500";
    textField.maxLength = 6;
    textField.textColor = UIColor.orangeColor;
    textField.textAlignment = NSTextAlignmentCenter;
    textField.keyboardType = UIKeyboardTypeDecimalPad;
    
    UITextField *textField2 = [UITextField new];
    textField2.backgroundColor = LZBackgroundColor;
    textField2.font = Font_PingFang_SC_Regular(14);
    textField2.lz_setView.lz_cornerRadius(2);
    textField2.placeholder = @"例：5.5";
    textField2.maxLength = 5;
    textField2.textColor = UIColor.orangeColor;
    textField2.textAlignment = NSTextAlignmentCenter;
    textField2.keyboardType = UIKeyboardTypeDecimalPad;
    
    [self addSubview:title_label];
    [self addSubview:textField];
    [self addSubview:textField2];
    [self addSubview:right_label];
    [self addSubview:center_label];
    [self addSubview:left_label];
    
    
    [title_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self);
        make.width.mas_equalTo(80);
    }];
    
    [right_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(self);
    }];
    
    [textField2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(right_label.mas_left).offset(-5);
        make.centerY.mas_equalTo(self);
        make.width.mas_greaterThanOrEqualTo(40);
    }];
    
    [center_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(textField2.mas_left).offset(-5);
        make.centerY.mas_equalTo(self);
    }];
    
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(center_label.mas_left).offset(-5);
        make.centerY.mas_equalTo(self);
        make.width.mas_greaterThanOrEqualTo(40);
        }];
    
    [left_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(textField.mas_left).offset(-5);
        make.centerY.mas_equalTo(self);
    }];
    
    _title_label = title_label;
    _textField = textField;
    _textField2 = textField2;
}

- (void)setTitle:(NSString *)title{
    _title_label.text = title;
}

- (void)setText:(NSString *)text{
    self.textField.text = text;
}

- (void)setText2:(NSString *)text2{
    self.textField2.text = text2;
}

- (NSString *)text{
    return self.textField.text;
}

- (NSString *)text2{
    return self.textField2.text;
}

@end
