//
//  CouponChoiceCell.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/28.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "CouponChoiceCell.h"

@implementation CouponChoiceCell

- (void)initUI{
    
    self.backgroundColor = LZWhiteColor;
    
    UILabel *title_label = [UILabel labelWithFontSize:16 textColor:rgb(53,53,53)];
    UILabel *text_label = [UILabel labelWithFontSize:16 textColor:rgb(53,53,53)];
    text_label.textAlignment = NSTextAlignmentRight;
    UIImageView *rightIcon = [UIImageView new];
    rightIcon.highlighted = YES;
    rightIcon.image = UIImageName(@"board_unSelected");
    rightIcon.highlightedImage = UIImageName(@"board_selected");
    
    [self addSubview:title_label];
    [self addSubview:text_label];
    [self addSubview:rightIcon];
    
    [title_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self);
        make.width.mas_equalTo(80);
    }];
    
    [text_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(self);
    }];
    
    [rightIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(text_label.mas_left).offset(-5);
        make.centerY.mas_equalTo(self);
    }];
    
    
    
    _title_label = title_label;
    _text_label = text_label;
    _rightIcon = rightIcon;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCell)];
    [self addGestureRecognizer:tap];
}

- (void)tapCell{
    _rightIcon.highlighted = !_rightIcon.isHighlighted;
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

- (void)setIsSelected:(BOOL)isSelected{
    _rightIcon.highlighted = isSelected;
}

- (BOOL)isSelected{
    return _rightIcon.isHighlighted;
}

@end
