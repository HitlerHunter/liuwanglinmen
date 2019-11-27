//
//  MineOrderDetailOrderView.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/11/22.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "MineOrderDetailOrderView.h"
#import "MineOrderModel.h"

@interface MineOrderDetailOrderView ()

@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UILabel *label2;
@property (nonatomic, strong) UILabel *label3;
@property (nonatomic, strong) UILabel *label4;

@property (nonatomic, strong) UIButton *btn_toPay;
@end

@implementation MineOrderDetailOrderView

- (void)initUI{
    
    self.backgroundColor = LZWhiteColor;
    
    UILabel *titleLabel = [UILabel labelWithFont:Font_PingFang_SC_Bold(14) text:@"订单信息" textColor:rgb(53,53,53)];
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(15);
    }];
    
    UILabel *label1 = [UILabel labelWithFont:Font_PingFang_SC_Regular(12) text:@"订单编号：" textColor:rgb(53,53,53)];
    [self addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleLabel);
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(5);
    }];
    
    UILabel *label2 = [UILabel labelWithFont:Font_PingFang_SC_Regular(12) text:@"" textColor:rgb(53,53,53)];
    [self addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleLabel);
        make.top.mas_equalTo(label1.mas_bottom).offset(5);
    }];
    
    UILabel *label3 = [UILabel labelWithFont:Font_PingFang_SC_Regular(12) text:@"" textColor:rgb(53,53,53)];
    [self addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleLabel);
        make.top.mas_equalTo(label2.mas_bottom).offset(5);
    }];
    
    UILabel *label4 = [UILabel labelWithFont:Font_PingFang_SC_Regular(12) text:@"支付方式：微信支付" textColor:rgb(53,53,53)];
    [self addSubview:label4];
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleLabel);
        make.top.mas_equalTo(label3.mas_bottom).offset(5);
    }];
    
    UIButton *btn_tx = [UIButton buttonWithFontSize:12 text:@"复制" textColor:rgb(255,81,0)];
    [self addSubview:btn_tx];
    [btn_tx mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(label1);
        make.right.mas_equalTo(-10);
        make.size.mas_equalTo(CGSizeMake(40, 20));
    }];
    [btn_tx addTarget:self action:@selector(toolBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _label1 = label1;
    _label2 = label2;
    _label3 = label3;
    _label4 = label4;
    
    UIButton *btn_toPay = [UIButton buttonWithFontSize:12 text:@"付款" textColor:rgb(101,101,101)];
    [self addSubview:btn_toPay];
    [btn_toPay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-15);
        make.right.mas_equalTo(-15);
        make.size.mas_equalTo(CGSizeMake(64, 24));
    }];
    _btn_toPay = btn_toPay;
    btn_toPay.lz_setView.lz_cornerRadius(3).lz_border(1, rgb(152,152,152));
    [btn_toPay addTarget:self action:@selector(toPay) forControlEvents:UIControlEventTouchUpInside];
}

- (void)toolBtnClick{
    
    [[UIPasteboard generalPasteboard] setString:_model.Id];
    [SVProgressHUD showSuccessWithStatus:@"已复制订单编号！"];
}

- (void)toPay{
    
    if (!IsNull(_model.preOrderParams)) {
        [AppPayManager shareInstance].currentPayType = AppPayTypeBoomGoodsPay;
        [[AppPayManager shareInstance] WXPayWithDic:_model.preOrderParams];
    }
    
}

- (void)setModel:(MineOrderModel *)model{
    _model = model;
    
    _label1.text = [NSString stringWithFormat:@"订单编号：%@",_model.Id];
    _label2.text = [NSString stringWithFormat:@"创建时间：%@",_model.createTime];
    
    if (model.status == MineOrderStatusWaitingPay) {
        _label4.hidden = YES;
        _label3.text = @"支付方式：微信支付";
        _btn_toPay.hidden = NO;
    }else{
        _btn_toPay.hidden = YES;
        _label3.text = [NSString stringWithFormat:@"付款时间：%@",_model.updateTime];
    }
    
    
}

@end
