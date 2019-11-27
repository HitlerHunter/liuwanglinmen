//
//  SureOrderInfoView.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/11/21.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "SureOrderInfoView.h"
#import "GoodsInfoView.h"
#import "GoodsCountSelectView.h"
#import "GoodsModel.h"

@interface SureOrderInfoView ()

@property (nonatomic, strong) GoodsInfoView *infoView;
@end

@implementation SureOrderInfoView

- (void)initUI{
    
    self.backgroundColor = LZWhiteColor;
    
    UILabel *nameLabel = [UILabel labelWithFont:Font_PingFang_SC_Bold(14) text:@"订单信息" textColor:rgb(53,53,53)];
    [self addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(15);
    }];
    
    GoodsInfoView *infoView = [GoodsInfoView new];
    [self addSubview:infoView];
    [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(35);
        make.height.mas_equalTo(85);
    }];
    _infoView = infoView;
    
    UILabel *titleLabel = [UILabel labelWithFont:Font_PingFang_SC_Bold(13) text:@"购买数量" textColor:rgb(53,53,53)];
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameLabel);
        make.top.mas_equalTo(infoView.mas_bottom).offset(10);
    }];
    
    _countView = [[GoodsCountSelectView alloc] init];
    [self addSubview:_countView];
    [_countView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(titleLabel);
        make.width.mas_equalTo(70);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(30);
    }];
    
    @weakify(self);
    _countView.countDidChangeBlock = ^(NSUInteger count) {
        @strongify(self);
        self.count = count;
    };
    
    UILabel *titleLabel2 = [UILabel labelWithFont:Font_PingFang_SC_Bold(13) text:@"配送方式" textColor:rgb(53,53,53)];
    [self addSubview:titleLabel2];
    [titleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameLabel);
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(10);
    }];
    
    UILabel *titleLabel3 = [UILabel labelWithFont:Font_PingFang_SC_Bold(13) text:@"平台免邮" textColor:rgb(53,53,53)];
    [self addSubview:titleLabel3];
    [titleLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(titleLabel2);
    }];
}

- (void)setModel:(GoodsModel *)model{
    _model = model;
    
    [_infoView.imageView sd_setImageWithURL:TLURL(model.logo)];
    _infoView.nameLabel.text = model.goodsName;
    _infoView.phoneLabel.text = model.goodsSpecs;
    _infoView.priceLabel.text = model.orderAmt;
    _infoView.count = 1;
}

@end
