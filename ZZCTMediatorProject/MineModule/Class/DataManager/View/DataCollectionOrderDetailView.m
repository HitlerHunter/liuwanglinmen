//
//  DataCollectionOrderDetailView.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/29.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "DataCollectionOrderDetailView.h"
#import "DataCollectionCircleChatView.h"

@interface DataCollectionOrderDetailView ()

@property (nonatomic, strong) DataCollectionCircleChatView *circleChatView;
@end

@implementation DataCollectionOrderDetailView

- (void)initUI{
    
    self.lz_setView.lz_shadow(6, rgba(0, 0, 0, 0.09), CGSizeMake(0, 0), 1, 5);
    self.backgroundColor = LZWhiteColor;
    
#pragma 支付宝
    UIView *point = [UIView new];
    point.backgroundColor = rgb(0,159,232);
    
    [self addSubview:point];
    [point mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(125);
        make.top.mas_equalTo(35);
        make.size.mas_equalTo(CGSizeMake(6, 6));
    }];
    
    point.lz_setView.lz_cornerRadius(3);
    
        //支付宝
    UILabel *label_alipay = [UILabel labelWithFontSize:16 text:@"支付宝" textColor:rgb(53,53,53)];
    label_alipay.font = Font_PingFang_SC_Bold(16);
    [self addSubview:label_alipay];
    [label_alipay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(point.mas_right).offset(5);
        make.centerY.mas_equalTo(point);
    }];
    
        //金额 笔数
    UILabel *label_info = [UILabel labelWithFontSize:12 text:@"金额：--元   笔数：--笔" textColor:rgb(152,152,152)];
    [self addSubview:label_info];
    [label_info mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(point);
        make.top.mas_equalTo(label_alipay.mas_bottom).offset(10);
        make.right.mas_equalTo(-15);
    }];
    _label_alipay = label_info;
    
    
    
#pragma 微信
    UIView *point1 = [UIView new];
    point1.backgroundColor = rgb(64,186,73);
    
    [self addSubview:point1];
    [point1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(point);
        make.top.mas_equalTo(87);
        make.size.mas_equalTo(CGSizeMake(6, 6));
    }];
    
    point1.lz_setView.lz_cornerRadius(3);
    
        //日期
    UILabel *label_wechat = [UILabel labelWithFontSize:16 text:@"微信" textColor:rgb(53,53,53)];
    label_wechat.font = Font_PingFang_SC_Bold(16);
    [self addSubview:label_wechat];
    [label_wechat mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(point1.mas_right).offset(5);
        make.centerY.mas_equalTo(point1);
    }];
    
        //金额 笔数
    UILabel *label_info2 = [UILabel labelWithFontSize:12 text:@"金额：--元   笔数：--笔" textColor:rgb(152,152,152)];
    [self addSubview:label_info2];
    [label_info2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label_info);
        make.top.mas_equalTo(label_wechat.mas_bottom).offset(10);
        make.right.mas_equalTo(-15);
    }];
    
    _label_wechat = label_info2;
    
    _circleChatView = [DataCollectionCircleChatView new];
    [self addSubview:_circleChatView];
    [_circleChatView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.centerY.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(81, 81));
    }];
    
    _circleChatView.alipayProgress = 0.5;
}

- (void)refreshAlipayProgress:(CGFloat)progress{
    [_circleChatView refreshAlipayProgress:progress];
}

- (void)refreshChatAnimation{
    [_circleChatView refreshProgress];
}
@end
