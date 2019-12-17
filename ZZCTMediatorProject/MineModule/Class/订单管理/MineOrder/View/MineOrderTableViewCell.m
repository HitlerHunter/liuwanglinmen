//
//  MineOrderTableViewCell.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/12/18.
//  Copyright © 2018 zenglizhi. All rights reserved.
//

#import "MineOrderTableViewCell.h"
#import "MineOrderModel.h"
#import "GoodsInfoView.h"
#import "GoodsDetailViewController.h"

@interface MineOrderTableViewCell ()
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *statusLabel;

@property (nonatomic, strong) GoodsInfoView *infoView;

@property (nonatomic, strong) UILabel *countLab;
@property (nonatomic, strong) UILabel *titleLab2;
@property (nonatomic, strong) UILabel *moneyLabel;

@property (nonatomic, strong) UIButton *btn_toPay;
@property (nonatomic, strong) UIButton *btn_tx;

@property (nonatomic, strong) UIView *kdView;
@property (nonatomic, strong) UILabel *kdNumberLabel;
@end

@implementation MineOrderTableViewCell

- (void)initUI{
    
    self.backgroundColor = LZBackgroundColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIView *bgView = [UIView new];
    bgView.backgroundColor = LZWhiteColor;
    [self.contentView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(10, 15, 0, 15));
    }];
    bgView.lz_setView.lz_cornerRadius(6);
    
    
    UIImageView *icon = [UIImageView viewWithImage:UIImageName(@"order_shopLogo")];
    UILabel *titleLab = [UILabel labelWithFont:Font_PingFang_SC_Medium(15) text:@"六旺临门" textColor:rgb(53,53,53)];
  
    [bgView addSubview:icon];
    [bgView addSubview:titleLab];
    
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];

    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(icon);
        make.left.mas_equalTo(icon.mas_right).offset(6);
        make.right.mas_equalTo(-110);
    }];
    
    UILabel *statusLabel = [UILabel labelWithFont:Font_PingFang_SC_Medium(13) text:nil textColor:rgb(255,81,0)];
    [bgView addSubview:statusLabel];
    [statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(icon);
        make.right.mas_equalTo(-15);
    }];
    
    _statusLabel = statusLabel;
    
    GoodsInfoView *infoView = [GoodsInfoView new];
    _infoView.priceLabel.textColor = rgb(53,53,53);
    [bgView addSubview:infoView];
    [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(43);
        make.height.mas_equalTo(85);
    }];
    _infoView = infoView;
    
    _countLab = [UILabel labelWithFont:Font_PingFang_SC_Regular(12) text:@"共1件商品" textColor:rgb(53,53,53)];
    _titleLab2 = [UILabel labelWithFont:Font_PingFang_SC_Regular(12) text:@"合计：" textColor:rgb(53,53,53)];
    _moneyLabel = [UILabel labelWithFont:Font_PingFang_SC_Regular(14) text:nil textColor:rgb(53,53,53)];
    
    [bgView addSubview:_countLab];
    [bgView addSubview:_titleLab2];
    [bgView addSubview:_moneyLabel];
    
    [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(infoView.mas_bottom).offset(5);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(21);
    }];
    
    [_titleLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.moneyLabel);
        make.right.mas_equalTo(self.moneyLabel.mas_left).offset(-5);
    }];
    
    [_countLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.moneyLabel);
        make.right.mas_equalTo(self.titleLab2.mas_left).offset(-5);
    }];
    

    UIView *line = [UIView new];
    line.backgroundColor = rgb(242,242,242);
    [bgView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.moneyLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(1);
    }];
    
    UIButton *btn_toPay = [UIButton buttonWithFontSize:12 text:@"立即付款" textColor:rgb(255,255,255)];
    btn_toPay.backgroundColor = rgb(255,81,0);
    [bgView addSubview:btn_toPay];
    [btn_toPay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-10);
        make.right.mas_equalTo(-15);
        make.size.mas_equalTo(CGSizeMake(80, 26));
    }];
    btn_toPay.lz_setView.lz_cornerRadius(13);
    
    UIButton *btn_tx = [UIButton buttonWithFontSize:12 text:@"提醒发货" textColor:rgb(101,101,101)];
    [bgView addSubview:btn_tx];
    [btn_tx mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(btn_toPay);
        make.right.mas_equalTo(btn_toPay);
        make.size.mas_equalTo(btn_toPay);
    }];
    btn_tx.lz_setView.lz_cornerRadius(13).lz_border(1, rgb(152,152,152));

    _btn_toPay = btn_toPay;
    _btn_tx = btn_tx;
    
    [_btn_toPay addTarget:self action:@selector(toolBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_btn_tx addTarget:self action:@selector(toolBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *kdView = [UIView new];
    [bgView addSubview:kdView];
    [kdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.top.mas_equalTo(line.mas_bottom);
        make.left.right.mas_equalTo(0);
    }];
    UIButton *btn_fuzhi = [UIButton buttonWithFontSize:11 text:@"复制单号" textColor:rgb(53,53,53)];
    [kdView addSubview:btn_fuzhi];
    [btn_fuzhi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-15);
        make.size.mas_equalTo(CGSizeMake(52, 17));
    }];
    btn_fuzhi.lz_setView.lz_cornerRadius(2).lz_border(1, rgb(152,152,152));
    
    UILabel *kdLabel = [UILabel labelWithFontSize:13 textColor:rgb(101,101,101) textAlignment:NSTextAlignmentRight];
    [kdView addSubview:kdLabel];
    [kdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(btn_fuzhi.mas_left).offset(-10);
    }];
    _kdNumberLabel = kdLabel;
    _kdView = kdView;
    
    [btn_fuzhi addTarget:self action:@selector(toolBtnClick) forControlEvents:UIControlEventTouchUpInside];
}


- (void)setModel:(MineOrderModel *)model{
    _model = model;
    
    _titleLab.text = @"六旺临门";
    _statusLabel.text = getOrdStatusTitleWithStatus(model.status);
    
    [_infoView.imageView sd_setImageWithURL:TLURL(model.picture)];
    _infoView.nameLabel.text = model.goodsName;
    _infoView.phoneLabel.text = model.goodsSpecs;
    _infoView.priceLabel.text = [NSString stringWithFormat:@"￥%@",[NSString formatFloatValue:model.orderAmt.floatValue/model.goodsCount.intValue]];
    _infoView.count = model.goodsCount.integerValue;
    
    _countLab.text = [NSString stringWithFormat:@"共 %@ 件商品 ",model.goodsCount];
    _moneyLabel.text = [NSString stringWithFormat:@"￥%@",model.orderAmt];
    
    _kdView.hidden = YES;
    _btn_toPay.enabled = YES;
    if (model.status == MineOrderStatusWaitingPay) {
        _btn_tx.hidden = YES;
        _btn_toPay.hidden = NO;
        _btn_toPay.enabled = NO;
    }else if (model.status == MineOrderStatusCancel) {
        _btn_tx.hidden = NO;
        _btn_toPay.hidden = YES;
        
        [_btn_tx setTitle:@"再来一单" forState:UIControlStateNormal];
    }else if (model.status == MineOrderStatusWaitingTake) {
        _btn_tx.hidden = YES;
        _btn_toPay.hidden = YES;
        _kdView.hidden = NO;
        _kdNumberLabel.text = [NSString stringWithFormat:@"%@ %@",model.expressCompany,model.expressNo];
    }else if (model.status == MineOrderStatusWaitingSend) {
        _btn_tx.hidden = NO;
        _btn_toPay.hidden = YES;
        
        [_btn_tx setTitle:@"提醒发货" forState:UIControlStateNormal];
    }
}


- (void)toolBtnClick{
    
    if (_model.status == MineOrderStatusWaitingPay) {
        //立即付款
        
    }else if (_model.status == MineOrderStatusCancel) {
        //再来一单
        GoodsDetailViewController *vc = [GoodsDetailViewController new];
        PushController(vc);
    }else if (_model.status == MineOrderStatusWaitingTake) {
        
        [[UIPasteboard generalPasteboard] setString:_model.expressNo];
        [SVProgressHUD showSuccessWithStatus:@"已复制快递单号！"];
    }else if (_model.status == MineOrderStatusWaitingSend) {
        //提醒发货
        [SVProgressHUD showSuccessWithStatus:@"提醒卖家发货发送消息成功"];
    }
}

@end
