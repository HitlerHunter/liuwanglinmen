//
//  CashTitleInfoCell.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/15.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "CashTitleInfoCell.h"

@implementation CashTitleInfoCell

+ (CashTitleInfoCell *)cellWithTitle:(NSString *)title
                                    vaule:(NSString *)vaule{
    
    CashTitleInfoCell *cell = [CashTitleInfoCell new];
    cell.titleLabel.text = title;
    cell.valueLabel.text = vaule;
    return cell;
}

- (void)initUI{
    
        //title
    UILabel *label1 = [UILabel labelWithFont:Font_PingFang_SC_Bold(12) text:@"" textColor:rgb(152,152,152)];
    [self addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(0);
    }];
    
        //value
    UILabel *label2 = [UILabel labelWithFont:Font_PingFang_SC_Bold(12) text:@"" textColor:rgb(53,53,53)];
    [self addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(92);
        make.right.mas_equalTo(-20);
        make.centerY.mas_equalTo(0);
    }];
    
    _titleLabel = label1;
    _valueLabel = label2;
    
}

@end
