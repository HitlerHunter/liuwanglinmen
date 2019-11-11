//
//  CouponSelectTextCell.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/28.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "CouponSelectTextCell.h"

@implementation CouponSelectTextCell

- (void)initUI{
    
    self.backgroundColor = LZWhiteColor;
    
    UILabel *title_label = [UILabel labelWithFontSize:16 textColor:rgb(53,53,53)];
    UILabel *text_label = [UILabel labelWithFontSize:16 textColor:rgb(53,53,53)];
    text_label.textAlignment = NSTextAlignmentRight;
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
    
    if ([text isEqualToString:@"未设置"]) {
        self.text_label.textColor = UIColor.grayColor;
    }else{
        self.text_label.textColor = rgb(53,53,53);
    }
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
