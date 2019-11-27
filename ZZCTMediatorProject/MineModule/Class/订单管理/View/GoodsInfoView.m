//
//  GoodsInfoView.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/11/21.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "GoodsInfoView.h"

@interface GoodsInfoView ()



@end

@implementation GoodsInfoView

- (void)initUI{
    
    self.backgroundColor = LZWhiteColor;
    
    UIImageView *imageV = [UIImageView new];
    [self addSubview:imageV];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
     
     UILabel *nameLabel = [UILabel labelWithFont:Font_PingFang_SC_Bold(14) text:@"" textColor:rgb(53,53,53)];
     nameLabel.numberOfLines = 2;
     [self addSubview:nameLabel];
     [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(imageV.mas_right).offset(10);
         make.top.mas_equalTo(imageV);
         make.height.mas_equalTo(38);
         make.right.mas_equalTo(-10);
     }];
     
     UILabel *phoneLabel = [UILabel labelWithFont:Font_PingFang_SC_Medium(12) text:@"" textColor:rgb(152,152,152)];
     [self addSubview:phoneLabel];
     [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.right.mas_equalTo(nameLabel);
         make.top.mas_equalTo(nameLabel.mas_bottom).offset(8);
     }];

     UILabel *priceLabel = [UILabel labelWithFont:Font_PingFang_SC_Medium(12) text:@"" textColor:rgb(255,81,0)];
    [self addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameLabel);
        make.bottom.mas_equalTo(imageV);
    }];
    
    UILabel *countLabel = [UILabel labelWithFont:Font_PingFang_SC_Medium(12) text:@"" textColor:rgb(152,152,152)];
    [self addSubview:countLabel];
    [countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(nameLabel);
        make.centerY.mas_equalTo(priceLabel);
    }];
    
    _imageView = imageV;
    _nameLabel = nameLabel;
    _phoneLabel = phoneLabel;
    _priceLabel = priceLabel;
    _countLabel = countLabel;
    
}

- (void)setCount:(NSInteger)count{
    _countLabel.text = [NSString stringWithFormat:@"x%ld",count];
}

@end
