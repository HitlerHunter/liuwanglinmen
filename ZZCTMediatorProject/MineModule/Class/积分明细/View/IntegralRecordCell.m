//
//  IntegralRecordCell.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/7/18.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "IntegralRecordCell.h"

@implementation IntegralRecordCell

- (void)initUI{
    self.backgroundColor = LZWhiteColor;
    
    UIImageView *imageView = [UIImageView new];
    UILabel *label_name = [UILabel labelWithFont:Font_PingFang_SC_Medium(14) text:@"" textColor:rgb(53,53,53)];
    UILabel *label_phone = [UILabel labelWithFont:Font_PingFang_SC_Medium(12) text:@"" textColor:rgb(152,152,152)];
    
    UILabel *label_money1 = [UILabel labelWithFont:Font_PingFang_SC_Medium(15) text:@"" textColor:rgb(53,53,53) textAlignment:NSTextAlignmentRight];
    UILabel *label_type = [UILabel labelWithFont:Font_PingFang_SC_Medium(12) text:@"" textColor:rgb(152,152,152)];
    
    _iconView = imageView;
    _label_status = label_name;
    _label_info = label_phone;
    _label_money = label_money1;
    _label_type = label_type;
    
    [self.contentView addSubview:imageView];
    [self.contentView addSubview:label_name];
    [self.contentView addSubview:label_phone];
    [self.contentView addSubview:label_money1];
    [self.contentView addSubview:label_type];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(42, 42));
    }];
    
    [label_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(17);
        make.left.mas_equalTo(imageView.mas_right).offset(10);
    }];
    
    [label_phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label_name);
        make.top.mas_equalTo(label_name.mas_bottom).offset(5);
    }];
    
    [label_money1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(label_name);
        make.right.mas_equalTo(-15);
    }];
    
    [label_type mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(label_phone);
        make.right.mas_equalTo(-15);
    }];
    
    [self addBottomLine];
    [self setBottomlineSpacingX:15];
    [self setBottomlineSpacingRightX:15];
}

@end
