//
//  ChangePswdCell.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/28.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "ChangePswdCell.h"

@implementation ChangePswdCell

- (void)initUI{
    
    [self addBottomLine];
    [self setBottomLineX:15];
    [self setBottomlineSpacingRightX:15];
    
    UILabel *label_title = [UILabel labelWithFontSize:14 text:@"" textColor:rgb(53,53,53)];
    UITextField *tf = [UITextField new];
    UIButton *rightBtn = [UIButton new];
    
    [rightBtn setImage:UIImageName(@"eye_open") forState:UIControlStateNormal];
    [rightBtn setImage:UIImageName(@"eye_colse") forState:UIControlStateSelected];
    
    _label_title = label_title;
    _textField = tf;
    
    [self.contentView addSubview:label_title];
    [self.contentView addSubview:tf];
    [self.contentView addSubview:rightBtn];
    
    [label_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self.contentView);
        make.width.mas_equalTo(70);
    }];
    
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    [tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label_title.mas_right).offset(15);
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_equalTo(rightBtn.mas_left).offset(-15);
    }];
    
    [rightBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.selected = YES;
    _textField.secureTextEntry = YES;
}

- (void)btnClick:(UIButton *)btn{
    btn.selected = !btn.isSelected;
    
    _textField.secureTextEntry = btn.selected;
}

@end
