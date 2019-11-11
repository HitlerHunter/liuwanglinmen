//
//  LevelUpInputCell.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/16.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "LevelUpInputCell.h"

@interface LevelUpInputCell ()


@end

@implementation LevelUpInputCell

+ (LevelUpInputCell *)cellWithTitle:(NSString *)title
                        placeholder:(NSString *)placeholder{
    LevelUpInputCell *cell = [LevelUpInputCell new];
    cell.label_title.text = title;
    cell.textField.placeholder = placeholder;
    return cell;
}

- (void)initUI{
    self.backgroundColor = rgb(238,238,238);
    
    UILabel *label_title = [UILabel labelWithFont:Font_PingFang_SC_Medium(16) text:@"姓名" textColor:rgb(18,18,18)];
    [self addSubview:label_title];
    [label_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(0);
    }];
    
    UITextField *textField = [UITextField new];
    textField.placeholder = @"请输入姓名";
    textField.font = Font_PingFang_SC_Regular(16);
    [self addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(65);
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(0);
    }];
    self.lz_setView.lz_cornerRadius(3);
    
    _label_title = label_title;
    _textField = textField;
    
    
}

@end
