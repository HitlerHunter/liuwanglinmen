//
//  VipConsumeRecordTopView.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/24.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "VipConsumeRecordTopView.h"

@implementation VipConsumeRecordTopView

- (void)initUI{
    
    self.lz_setView.lz_shadow(10, rgba(255,142,1,0.4), CGSizeMake(0, 1), 1, 10);
    self.backgroundColor = LZWhiteColor;
    
    
    UIImageView *imageView = [UIImageView new];
    UILabel *label_name = [UILabel labelWithFont:Font_PingFang_SC_Bold(16) text:@"" textColor:rgb(53,53,53)];
    UILabel *label_phone = [UILabel labelWithFont:Font_PingFang_SC_Medium(13) text:@"" textColor:rgb(152,152,152)];
    
    UILabel *label_money1 = [UILabel labelWithFont:Font_PingFang_SC_Bold(18) text:@"" textColor:rgb(53,53,53) textAlignment:NSTextAlignmentCenter];
    UILabel *label_money2 = [UILabel labelWithFont:Font_PingFang_SC_Bold(18) text:@"" textColor:rgb(53,53,53) textAlignment:NSTextAlignmentCenter];
    UILabel *label_title1 = [UILabel labelWithFont:Font_PingFang_SC_Medium(13) text:@"消费总额" textColor:rgb(152,152,152) textAlignment:NSTextAlignmentCenter];
    UILabel *label_title2 = [UILabel labelWithFont:Font_PingFang_SC_Medium(13) text:@"消费次数" textColor:rgb(152,152,152) textAlignment:NSTextAlignmentCenter];
    
    _headImage = imageView;
    _label_name = label_name;
    _label_phone = label_phone;
    
    _label_money1 = label_money1;
    _label_money2 = label_money2;
    
    [self addSubview:imageView];
    [self addSubview:label_name];
    [self addSubview:label_phone];
    
    [self addSubview:label_money1];
    [self addSubview:label_money2];
    [self addSubview:label_title1];
    [self addSubview:label_title2];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [label_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(imageView.mas_right).offset(11);
        make.height.mas_equalTo(18);
    }];
    
    [label_phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label_name);
        make.top.mas_equalTo(label_name.mas_bottom).offset(5);
    }];
    
    imageView.lz_setView.lz_cornerRadius(25);
    
    [label_money1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageView.mas_bottom).offset(25);
        make.height.mas_equalTo(16);
        make.left.mas_equalTo(0);
    }];
    
    [label_money2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label_money1);
        make.height.mas_equalTo(label_money1);
        make.left.mas_equalTo(label_money1.mas_right);
        make.right.mas_equalTo(self);
        make.width.mas_equalTo(label_money1);
    }];
    
    [label_title1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label_money1.mas_bottom).offset(5);
        make.left.right.mas_equalTo(label_money1);
    }];
    
    [label_title2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label_title1);
        make.left.right.mas_equalTo(label_money2);
    }];
}

@end
