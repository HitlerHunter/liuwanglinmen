//
//  MineInfoEditInputCell.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/14.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "MineInfoEditInputCell.h"

@implementation MineInfoEditInputCell

- (void)initUI{
    
        //title
    UILabel *label1 = [UILabel labelWithFont:Font_PingFang_SC_Bold(15) text:@"" textColor:rgb(53,53,53)];
    [self addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(0);
    }];
    _titleLabel = label1;
    
    UITextField *textField = [UITextField new];
    textField.placeholder = @"未设置";
    textField.font = Font_PingFang_SC_Regular(14);
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(92);
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(0);
    }];
    
    _textField = textField;
    
    [self addTopLine];
    [self setTopLineX:15];
}

@end
