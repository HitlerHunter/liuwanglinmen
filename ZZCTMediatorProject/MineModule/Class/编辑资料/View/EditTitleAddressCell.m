//
//  EditTitleAddressCell.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/9/2.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "EditTitleAddressCell.h"

@implementation EditTitleAddressCell

- (void)initUI{
    
    self.backgroundColor = LZWhiteColor;
    
    UILabel *title_label = [UILabel labelWithFontSize:14 textColor:rgb(101,101,101)];
    UILabel *text_label = [UILabel labelWithFontSize:14 textColor:rgb(53,53,53)];
    text_label.textAlignment = NSTextAlignmentRight;
    text_label.numberOfLines = 2;
    UIImageView *rightIcon = [UIImageView viewWithImage:UIImageName(@"more_gray")];
    UIImageView *leftIcon = [UIImageView viewWithImage:UIImageName(@"edit_location")];
    _rightIcon = rightIcon;
    
    [self addSubview:title_label];
    [self addSubview:text_label];
    [self addSubview:rightIcon];
    [self addSubview:leftIcon];
    
    [title_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self);
        make.width.mas_equalTo(80);
    }];
    
    [rightIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(self);
        make.width.mas_equalTo(7);
    }];
    
    [text_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(rightIcon.mas_left).offset(-10);
        make.centerY.mas_equalTo(self);
        make.width.mas_lessThanOrEqualTo(kScreenWidth-130);
    }];
    
    [leftIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(text_label.mas_left).offset(-5);
        make.centerY.mas_equalTo(self);
        
    }];
    
    _title_label = title_label;
    _text_label = text_label;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap)];
    [self addGestureRecognizer:tap];
}

- (void)didTap{
    if (_tapBlock) {
        _tapBlock();
    }
}

- (void)setTitle:(NSString *)title{
    _title_label.text = title;
}

- (void)setText:(NSString *)text{
    _text = text;
    self.text_label.text = text;
    
    if ([text isEqualToString:@"未设置"]) {
        self.text_label.textColor = UIColor.grayColor;
    }else{
        self.text_label.textColor = rgb(53,53,53);
    }
}


@end
