//
//  MerchantManagerCardView.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/11/22.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "MerchantManagerCardView.h"

@interface MerchantManagerCardView ()



@end

@implementation MerchantManagerCardView

- (void)initUI{
    
    self.backgroundColor = LZWhiteColor;
    
    UILabel *lab1 = [UILabel labelWithFontSize:13 text:@"今日新增" textColor:rgb(53,53,53)];
    UILabel *lab2 = [UILabel labelWithFontSize:13 text:@"商户总数" textColor:rgb(53,53,53)];
    
    UILabel *lab_today = [UILabel labelWithFontSize:20 text:@"141" textColor:rgb(255,81,0)];
    UILabel *lab_all = [UILabel labelWithFontSize:20 text:@"2222" textColor:rgb(255,81,0)];
    
    [self addSubview:lab1];
    [self addSubview:lab2];
    [self addSubview:lab_today];
    [self addSubview:lab_all];
    
    [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(40*LZScale);
        make.top.mas_equalTo(26);
    }];
    [lab_today mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lab1.mas_right).offset(10);
        make.centerY.mas_equalTo(lab1);
    }];
    [lab_all mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-30);
        make.centerY.mas_equalTo(lab1);
    }];
    [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(lab_all.mas_left).offset(-10);
        make.centerY.mas_equalTo(lab1);
    }];
    
    UILabel *lab_left = [UILabel labelWithFontSize:16 text:@"141" textColor:rgb(255,81,0) textAlignment:NSTextAlignmentCenter];
    UILabel *lab_right = [UILabel labelWithFontSize:16 text:@"2222" textColor:rgb(255,81,0) textAlignment:NSTextAlignmentCenter];
    UILabel *lab_center = [UILabel labelWithFontSize:16 text:@"2222" textColor:rgb(255,81,0) textAlignment:NSTextAlignmentCenter];
    
    [self addSubview:lab_left];
    [self addSubview:lab_right];
    [self addSubview:lab_center];
    
    [lab_left mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.centerY.mas_equalTo(5);
    }];
    [lab_center mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lab_left.mas_right);
        make.centerY.mas_equalTo(lab_left);
        make.width.mas_equalTo(lab_left);
    }];
    [lab_right mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lab_center.mas_right);
        make.centerY.mas_equalTo(lab_left);
        make.width.mas_equalTo(lab_center);
        make.right.mas_equalTo(0);
    }];
    
    UILabel *title1 = [UILabel labelWithFontSize:13 text:@"待审核" textColor:rgb(53,53,53)];
    UILabel *title2 = [UILabel labelWithFontSize:13 text:@"审核通过" textColor:rgb(53,53,53)];
    UILabel *title3 = [UILabel labelWithFontSize:13 text:@"审核拒绝" textColor:rgb(53,53,53)];
    
    [self addSubview:title1];
    [self addSubview:title2];
    [self addSubview:title3];
    
    [title1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lab_left.mas_bottom).offset(8);
        make.centerX.mas_equalTo(lab_left);
    }];
    [title2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(title1);
        make.centerX.mas_equalTo(lab_center);
    }];
    [title3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(title1);
        make.centerX.mas_equalTo(lab_right);
    }];
    
    _lab_today = lab_today;
    _lab_all = lab_all;
    _lab_left = lab_left;
    _lab_right = lab_right;
    _lab_center = lab_center;
}

@end
