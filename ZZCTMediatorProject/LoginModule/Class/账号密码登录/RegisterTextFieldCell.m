//
//  RegisterTextFieldCell.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/10.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "RegisterTextFieldCell.h"

@interface RegisterTextFieldCell ()

@property (nonatomic, assign) RegisterTextFieldCellStyle style;


@end

@implementation RegisterTextFieldCell

- (instancetype)initWithStyle:(RegisterTextFieldCellStyle)style{
    self = [super init];
    if (self) {
        _style = style;
        [self initUI2];
    }
    return self;
}

- (void)initUI2{
    
    self.backgroundColor = LZWhiteColor;
    
    UITextField *textField = [UITextField new];
    textField.font = Font_PingFang_SC_Regular(16);
    textField.textColor = rgb(53,53,53);
    
    [self addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerY.mas_equalTo(self);
        make.right.mas_equalTo(self);
    }];
    _textField = textField;
    
    [self addBottomLine];
    
    if (_style == RegisterTextFieldCellStyleSecureTextEntry) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:UIImageName(@"eye_open") forState:UIControlStateNormal];
        [btn setImage:UIImageName(@"eye_colse") forState:UIControlStateSelected];
        
        btn.frame = CGRectMake(0, 0, 40, 40);
        textField.rightView = btn;
        textField.rightViewMode = UITextFieldViewModeAlways;
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self btnClick:btn];
    }else if (_style == RegisterTextFieldCellStyleCode) {
            //view2
        SDBaseView *view2 = [[SDBaseView alloc] initWithFrame:CGRectMake(0, 0, 110, 40)];
        [self addSubview:view2];

        UIButton *btn_code = [UIButton buttonWithFontSize:16 text:@"获取验证码" textColor:rgb(255,81,0)];
        [view2 addSubview:btn_code];
        [btn_code mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.height.mas_equalTo(30);
            make.centerY.mas_equalTo(0);
            make.width.mas_equalTo(100);
        }];
        _getCodeBtn = btn_code;
        
        UIView *line = [UIView new];
        line.backgroundColor = rgb(198,198,198);
        [view2 addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(10);
            make.bottom.mas_equalTo(-10);
            make.width.mas_equalTo(1);
        }];
        
        [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(40);
            make.centerY.mas_equalTo(0);
            make.width.mas_equalTo(110);
        }];
        
        textField.rightView = view2;
        textField.rightViewMode = UITextFieldViewModeAlways;
        
        [_getCodeBtn addTarget:self action:@selector(getVerCode) forControlEvents:UIControlEventTouchUpInside];
        
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.maxLength = 6;
        _textField.placeholder = @"请输入短信验证码";
    }
}

- (void)btnClick:(UIButton *)btn{
    btn.selected = !btn.isSelected;
    _textField.secureTextEntry = btn.isSelected;
}

- (void)getVerCode{
    
    if (_getCodeBlock) {
        _getCodeBlock();
    }
}

- (NSString *)text{
    return _textField.text;
}

- (void)setMaxLength:(NSInteger)maxLength{
    _textField.maxLength = maxLength;
}

- (void)setPlaceholder:(NSString *)placeholder{
    _textField.placeholder = placeholder;
}

- (void)setTitle:(NSString *)title{
    _title = title;
    
    UILabel *lab1 = [UILabel labelWithFont:Font_PingFang_SC_Medium(14) text:title textColor:rgb(53,53,53) textAlignment:NSTextAlignmentCenter];
    lab1.frame = CGRectMake(0, 0, 100, 20);
    _textField.leftView = lab1;
    _textField.leftViewMode = UITextFieldViewModeAlways;
}

@end
