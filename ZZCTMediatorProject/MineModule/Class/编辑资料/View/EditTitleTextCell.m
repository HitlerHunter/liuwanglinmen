//
//  EditTitleTextCell.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/9/3.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "EditTitleTextCell.h"

@implementation EditTitleTextCell

- (void)initUI{
    
    self.backgroundColor = LZWhiteColor;
    
    UILabel *title_label = [UILabel labelWithFontSize:14 textColor:rgb(101,101,101)];
    UILabel *text_label = [UILabel labelWithFontSize:14 textColor:rgb(53,53,53)];
    text_label.textAlignment = NSTextAlignmentRight;
    text_label.numberOfLines = 2;
    UIImageView *rightIcon = [UIImageView viewWithImage:UIImageName(@"more_gray")];
    _rightIcon = rightIcon;
    
    [self addSubview:title_label];
    [self addSubview:text_label];
    [self addSubview:rightIcon];
    
    
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
        make.left.mas_equalTo(title_label.mas_right).offset(10);
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
}

- (void)setHiddenIcon:(BOOL)hiddenIcon{
    _rightIcon.hidden = YES;
    
    [_text_label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(self.title_label.mas_right)
        .offset(10);
    }];
}
@end
