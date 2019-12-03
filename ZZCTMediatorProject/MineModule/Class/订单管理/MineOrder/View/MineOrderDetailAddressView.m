//
//  MineOrderDetailAddressView.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/11/22.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "MineOrderDetailAddressView.h"
#import "MineAddressModel.h"

@interface MineOrderDetailAddressView ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UILabel *addressLabel;

@end

@implementation MineOrderDetailAddressView

- (void)initUI{
    
    self.backgroundColor = LZWhiteColor;
    
    UIImageView *imageV = [UIImageView viewWithImage:UIImageName(@"address_location")];
    [self addSubview:imageV];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(0);
//        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];
     
     UILabel *nameLabel = [UILabel labelWithFont:Font_PingFang_SC_Bold(14) text:@"" textColor:rgb(53,53,53)];
     [self addSubview:nameLabel];
     [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(32);
         make.top.mas_equalTo(16);
     }];
     
     UILabel *phoneLabel = [UILabel labelWithFont:Font_PingFang_SC_Medium(12) text:@"" textColor:rgb(152,152,152)];
     [self addSubview:phoneLabel];
     [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(nameLabel.mas_right).offset(10);
         make.centerY.mas_equalTo(nameLabel);
     }];

     UILabel *addressLabel = [UILabel labelWithFont:Font_PingFang_SC_Medium(13) text:@"" textColor:rgb(53,53,53)];
    addressLabel.numberOfLines = 2;
    [self addSubview:addressLabel];
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameLabel);
        make.right.mas_equalTo(-20);
        make.bottom.mas_equalTo(-17);
        make.top.mas_equalTo(nameLabel.mas_bottom).offset(5);
    }];
    
    _nameLabel = nameLabel;
    _phoneLabel = phoneLabel;
    _addressLabel = addressLabel;
}

- (void)setModel:(MineAddressModel *)model{
    _model = model;
    
    _nameLabel.text = model.userName;
    _phoneLabel.text = model.mobile;
    
    NSMutableAttributedString *addressStr = [[NSMutableAttributedString alloc] initWithString:model.showAddress];
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 5;
    [addressStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, model.showAddress.length)];
    
    _addressLabel.attributedText = addressStr;
}


@end
