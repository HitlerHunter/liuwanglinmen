//
//  MineOrderDetailInfoView.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/11/22.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "MineOrderDetailInfoView.h"
#import "GoodsInfoView.h"
#import "MineOrderModel.h"

@interface MineOrderDetailInfoView ()

@property (nonatomic, strong) GoodsInfoView *infoView;
@property (nonatomic, strong) UILabel *orderAmtLabel;
@end

@implementation MineOrderDetailInfoView

- (void)initUI{
    
    self.backgroundColor = LZWhiteColor;
    
    UIImageView *icon = [UIImageView view];
      UILabel *titleLab = [UILabel labelWithFont:Font_PingFang_SC_Medium(15) text:@"六旺临门" textColor:rgb(53,53,53)];
    
      [self addSubview:icon];
      [self addSubview:titleLab];
      
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
    
    GoodsInfoView *infoView = [GoodsInfoView new];
    _infoView.priceLabel.textColor = rgb(53,53,53);
    [self addSubview:infoView];
    [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(43);
        make.height.mas_equalTo(85);
    }];
    _infoView = infoView;
    
    UILabel *titleLabel = [UILabel labelWithFont:Font_PingFang_SC_Bold(13) text:@"商品总价" textColor:rgb(53,53,53)];
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(icon);
        make.top.mas_equalTo(infoView.mas_bottom).offset(10);
    }];
    
    UILabel *orderAmtLabel = [UILabel labelWithFont:Font_PingFang_SC_Bold(13) text:@"" textColor:rgb(255,81,0)];
    [self addSubview:orderAmtLabel];
    [orderAmtLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(titleLabel);
    }];
    _orderAmtLabel = orderAmtLabel;
    
    
    UILabel *titleLabel2 = [UILabel labelWithFont:Font_PingFang_SC_Bold(13) text:@"配送方式" textColor:rgb(53,53,53)];
    [self addSubview:titleLabel2];
    [titleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(icon);
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(10);
    }];
    
    UILabel *titleLabel3 = [UILabel labelWithFont:Font_PingFang_SC_Bold(13) text:@"平台免邮" textColor:rgb(53,53,53)];
    [self addSubview:titleLabel3];
    [titleLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(titleLabel2);
    }];
}

- (void)setModel:(MineOrderModel *)model{
    _model = model;
    
    [_infoView.imageView sd_setImageWithURL:TLURL(model.picture)];
    _infoView.nameLabel.text = model.goodsName;
    _infoView.phoneLabel.text = model.goodsSpecs;
    _infoView.priceLabel.text = [NSString stringWithFormat:@"%@",model.goodsPrice];
    _infoView.count = 1;
    
    _orderAmtLabel.text = [NSString formatFloatString:model.orderAmt];
}

@end
