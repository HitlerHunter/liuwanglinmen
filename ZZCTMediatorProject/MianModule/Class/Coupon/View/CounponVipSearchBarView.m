//
//  CounponVipSearchBarView.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/30.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "CounponVipSearchBarView.h"

@interface CounponVipSearchBarView ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UILabel *label_message;

@end

@implementation CounponVipSearchBarView

- (void)initUI{
    
    UIView *bgView = [UIView new];
    bgView.backgroundColor = LZWhiteColor;
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.right.mas_equalTo(-15);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(30);
    }];
    bgView.lz_setView.lz_cornerRadius(3);
    
    UITextField *textField = [UITextField new];
    textField.placeholder = @"请输入昵称/手机号";
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
    
    UILabel *label_message = [UILabel labelWithFont:Font_PingFang_SC_Medium(12) text:@"" textColor:rgb(101,101,101) textAlignment:NSTextAlignmentCenter];
    [self addSubview:label_message];
    [label_message mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bgView.mas_bottom).offset(10);
        make.right.left.mas_equalTo(bgView);
    }];
    
    _textField = textField;
    _label_message = label_message;
}

- (void)setVipNumber:(NSInteger)vipNumber
        couponNumber:(NSInteger)couponNumber{
    
    NSMutableString *str = [[NSMutableString alloc] init];
    
    if (vipNumber>0) {
        [str appendString:[NSString stringWithFormat:@"共%ld位会员",vipNumber]];
    }else{
        [str appendString:@"暂无会员"];
    }
    
    if (couponNumber >= 0) {
        [str appendString:[NSString stringWithFormat:@"，可发优惠券%ld张",couponNumber]];
    }
    
    _label_message.text = str;
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
    
    return YES;
}

@end
