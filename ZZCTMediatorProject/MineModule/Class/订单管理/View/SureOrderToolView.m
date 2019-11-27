//
//  SureOrderToolView.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/11/21.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "SureOrderToolView.h"

@interface SureOrderToolView ()

@property (nonatomic, strong) UILabel *countLab;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UIButton *rightBtn;

@end

@implementation SureOrderToolView

- (void)initUI{
    
    self.backgroundColor = LZWhiteColor;
    
    _countLab = [UILabel labelWithFont:Font_PingFang_SC_Regular(12) text:@"共1件" textColor:rgb(0,0,0)];
    _titleLab = [UILabel labelWithFont:Font_PingFang_SC_Regular(12) text:@"合计：" textColor:rgb(0,0,0)];
    _moneyLabel = [UILabel labelWithFont:Font_PingFang_SC_Regular(16) text:nil textColor:rgb(255,81,0)];
    
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightBtn setTitle:@"提交订单" forState:UIControlStateNormal];
    [_rightBtn setTitleColor:LZWhiteColor forState:UIControlStateNormal];
    _rightBtn.titleLabel.font = Font_PingFang_SC_Regular(16);
    
    [self addSubview:_countLab];
    [self addSubview:_titleLab];
    [self addSubview:_moneyLabel];
    [self addSubview:_rightBtn];
    
    [_countLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(40);
        make.height.mas_equalTo(21);
    }];
    
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(self.countLab.mas_right);
        make.height.mas_equalTo(21);
    }];
    
    [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleLab);
        make.left.mas_equalTo(self.titleLab.mas_right);
        make.height.mas_equalTo(21);
        make.width.mas_greaterThanOrEqualTo(60);
    }];
    
    [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(-15);
        make.width.mas_equalTo(160);
        make.height.mas_equalTo(40);
    }];
    
    [_rightBtn setDefaultGradientWithCornerRadius:20];
    
    [_rightBtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    
    [self addTopLine];
}

- (void)setMoney:(NSString *)money{
    _moneyLabel.text = [NSString stringWithFormat:@"%@元",money];
}

-  (void)setCount:(NSUInteger)count{
    _countLab.text = [NSString stringWithFormat:@"共 %lu 件，",(unsigned long)count];
}

- (void)submit{
    if(_submitBlock){
        _submitBlock();
    }
}
@end
