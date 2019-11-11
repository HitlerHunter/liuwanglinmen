//
//  CouponInputTextCell.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/28.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "CouponInputTextCell.h"

@implementation CouponInputTextCell

- (void)initUI{
    
    self.backgroundColor = LZWhiteColor;
    
    UILabel *title_label = [UILabel labelWithFontSize:16 textColor:rgb(53,53,53)];
    UILabel *right_label = [UILabel labelWithFontSize:16 textColor:rgb(53,53,53)];
    UITextField *textField = [UITextField new];
    textField.maxLength = 8;
    textField.textColor = rgb(53,53,53);
    textField.textAlignment = NSTextAlignmentRight;
    
    [self addSubview:title_label];
    [self addSubview:textField];
    [self addSubview:right_label];
    
    
    [title_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self);
        make.width.mas_equalTo(100);
    }];
    
    [right_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(self);
        make.width.mas_lessThanOrEqualTo(50);
    }];
    
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(right_label.mas_left).offset(-10);
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(title_label.mas_right).offset(10);
    }];
    
    _title_label = title_label;
    _textField = textField;
    _right_label = right_label;
    
        //content hugging 为1000
    [right_label setContentHuggingPriority:UILayoutPriorityRequired
                            forAxis:UILayoutConstraintAxisHorizontal];
    
        //content compression 为250
    [textField setContentCompressionResistancePriority:UILayoutPriorityDefaultLow
                                          forAxis:UILayoutConstraintAxisHorizontal];
}

- (void)setTitle:(NSString *)title{
    _title_label.text = title;
}

- (void)setText:(NSString *)text{
    self.textField.text = text;
}

- (NSString *)text{
    return self.textField.text;
}

- (void)setRightText:(NSString *)rightText{
    _right_label.text = rightText;
}

- (void)setTextPlaceholder:(NSString *)textPlaceholder{
    self.textField.placeholder = textPlaceholder;
}
@end
