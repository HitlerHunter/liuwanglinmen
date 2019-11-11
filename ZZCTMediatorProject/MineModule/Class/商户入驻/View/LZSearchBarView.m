//
//  LZSearchBarView.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/11/1.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "LZSearchBarView.h"

@interface LZSearchBarView ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField;

@end

@implementation LZSearchBarView

- (void)initUI{
    
    UIView *bgView = [UIView new];
    bgView.backgroundColor = LZWhiteColor;
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-15);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(30);
    }];
    bgView.lz_setView.lz_cornerRadius(3);
    
    UITextField *textField = [UITextField new];
    textField.placeholder = @"请输入银行";
    textField.font = Font_PingFang_SC_Regular(13);
    textField.delegate = self;
    textField.returnKeyType = UIReturnKeySearch;
    [bgView addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(3);
        make.right.mas_equalTo(-5);
        make.left.mas_equalTo(8);
        make.bottom.mas_equalTo(-3);
    }];
    
    _textField = textField;
    
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    if (_didReturnBlock) {
        _didReturnBlock(textField.text);
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (_didReturnBlock) {
        _didReturnBlock(textField.text);
    }
    
    [textField resignFirstResponder];
    return YES;
}

@end
