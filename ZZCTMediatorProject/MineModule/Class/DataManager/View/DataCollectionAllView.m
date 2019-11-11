//
//  DataCollectionAllView.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/29.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "DataCollectionAllView.h"

@implementation DataCollectionAllView

- (void)initUI{
    self.lz_setView.lz_shadow(6, rgba(0, 0, 0, 0.09), CGSizeMake(0, 0), 1, 5);
    self.backgroundColor = rgb(252,252,252);
    
    UIView *topView = [UIView new];
    topView.backgroundColor = LZWhiteColor;
    [self addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.bottom.mas_equalTo(-38);
    }];
    
    UIView *point = [UIView new];
    point.backgroundColor = rgb(255,81,0);
    
    [topView addSubview:point];
    [point mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(23);
        make.size.mas_equalTo(CGSizeMake(6, 6));
    }];
    
    point.lz_setView.lz_cornerRadius(3);
    
    //日期
    UILabel *label_date = [UILabel labelWithFontSize:16 text:@"-----" textColor:rgb(53,53,53)];
    label_date.font = Font_PingFang_SC_Bold(16);
    [topView addSubview:label_date];
    [label_date mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(point.mas_right).offset(5);
        make.centerY.mas_equalTo(point);
    }];
    _label_date = label_date;
    
#pragma 订单
    //订单金额
    UILabel *label_orderMoney = [UILabel labelWithFontSize:14 text:@"--元" textColor:rgb(53,53,53) textAlignment:NSTextAlignmentRight];
    [topView addSubview:label_orderMoney];
    [label_orderMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(topView);
        make.top.mas_equalTo(50);
        make.height.mas_equalTo(16);
        make.width.mas_greaterThanOrEqualTo(50);
    }];
    
    _label_orderMoney = label_orderMoney;
    
    //订单
    UILabel *label_orderTitle = [UILabel labelWithFontSize:14 text:@"订   单" textColor:rgb(152,152,152)];
    [topView addSubview:label_orderTitle];
    [label_orderTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(label_orderMoney.mas_left).offset(-30);
        make.centerY.mas_equalTo(label_orderMoney);
        make.size.mas_equalTo(CGSizeMake(44, 16));
    }];
    
    //订单笔数
    UILabel *label_orderCount = [UILabel labelWithFontSize:14 text:@"--笔" textColor:rgb(53,53,53) textAlignment:NSTextAlignmentRight];
    [topView addSubview:label_orderCount];
    [label_orderCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label_orderMoney.mas_right).offset(30);
        make.centerY.mas_equalTo(label_orderMoney);
        make.width.mas_greaterThanOrEqualTo(40);
    }];
    _label_orderCount = label_orderCount;
    
#pragma 退款
        //退款金额
    UILabel *label_refundMoney = [UILabel labelWithFontSize:14 text:@"--元" textColor:rgb(53,53,53) textAlignment:NSTextAlignmentRight];
    [topView addSubview:label_refundMoney];
    [label_refundMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(label_orderMoney);
        make.top.mas_equalTo(label_orderMoney.mas_bottom).offset(15);
        make.height.mas_equalTo(label_orderMoney);
        make.width.mas_equalTo(label_orderMoney);
    }];
    _label_refundMoney = label_refundMoney;
    
        //退款
    UILabel *label_refundTitle = [UILabel labelWithFontSize:14 text:@"退   款" textColor:rgb(152,152,152)];
    [topView addSubview:label_refundTitle];
    [label_refundTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(label_orderTitle);
        make.centerY.mas_equalTo(label_refundMoney);
        make.size.mas_equalTo(label_orderTitle);
    }];
    
        //退款笔数
    UILabel *label_refundCount = [UILabel labelWithFontSize:14 text:@"--笔" textColor:rgb(53,53,53) textAlignment:NSTextAlignmentRight];
    [topView addSubview:label_refundCount];
    [label_refundCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label_orderCount);
        make.centerY.mas_equalTo(label_refundMoney);
        make.width.mas_equalTo(label_orderCount);
    }];
    _label_refundCount = label_refundCount;
    
#pragma 手续费
        //手续费金额
    UILabel *label_axtMoney = [UILabel labelWithFontSize:14 text:@"--元" textColor:rgb(53,53,53) textAlignment:NSTextAlignmentRight];
    [topView addSubview:label_axtMoney];
    [label_axtMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(label_orderMoney);
        make.top.mas_equalTo(label_refundMoney.mas_bottom).offset(15);
        make.height.mas_equalTo(label_orderMoney);
        make.width.mas_equalTo(label_orderMoney);
    }];
    _label_axtMoney = label_axtMoney;
    
        //手续费
    UILabel *label_axtTitle = [UILabel labelWithFontSize:14 text:@"手续费" textColor:rgb(152,152,152)];
    [topView addSubview:label_axtTitle];
    [label_axtTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(label_orderTitle);
        make.centerY.mas_equalTo(label_axtMoney);
        make.size.mas_equalTo(label_orderTitle);
    }];
    
    
#pragma 可结算金额
        //可结算金额
    UILabel *label_kjsMoney = [UILabel labelWithFontSize:14 text:@"可结算金额 --元" textColor:rgb(53,53,53) textAlignment:NSTextAlignmentRight];
    [self addSubview:label_kjsMoney];
    [label_kjsMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(topView.mas_bottom);
        make.bottom.mas_equalTo(0);
    }];
    
    _label_kjsMoney = label_kjsMoney;
}

- (void)setCanEndMoney:(NSString *)canEndMoney{
    
    NSMutableAttributedString *attTitle = [[NSMutableAttributedString alloc] initWithString:@"可结算金额" attributes:@{NSFontAttributeName:Font_PingFang_SC_Regular(14),NSForegroundColorAttributeName:rgb(53,53,53)}];
    
    NSAttributedString *attMoney = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@元",canEndMoney] attributes:@{NSFontAttributeName:Font_PingFang_SC_Regular(14),NSForegroundColorAttributeName:rgb(255,81,0)}];
    
    [attTitle appendAttributedString:attMoney];
    
    _label_kjsMoney.attributedText = attTitle;
}

@end
