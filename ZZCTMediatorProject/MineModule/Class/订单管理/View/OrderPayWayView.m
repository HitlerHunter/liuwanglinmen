//
//  OrderPayWayView.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/11/21.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "OrderPayWayView.h"

@interface OrderPayWayCell ()

@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UIImageView *icon;

@end

@implementation OrderPayWayCell

- (void)initUI{
    self.backgroundColor = LZWhiteColor;
    
    UIImageView *imageV = [UIImageView viewWithImage:UIImageName(@"skm_weixinzhifu")];
    [self addSubview:imageV];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];
    
    UILabel *addressLabel = [UILabel labelWithFont:Font_PingFang_SC_Medium(13) text:@"微信支付" textColor:rgb(53,53,53)];
    [self addSubview:addressLabel];
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(31);
        make.centerY.mas_equalTo(imageV);
    }];
    
    UIImageView *moreIcon = [UIImageView viewWithImage:UIImageName(@"board_unSelected")];
    moreIcon.highlightedImage = UIImageName(@"board_selected");
    [self addSubview:moreIcon];
    [moreIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];
    
    _imageV = imageV;
    _addressLabel = addressLabel;
    _icon = moreIcon;
}

- (void)setIsSelected:(BOOL)isSelected{
    _isSelected = isSelected;
    _icon.highlighted = isSelected;
}

@end

@implementation OrderPayWayView

- (void)initUI{
    self.backgroundColor = LZWhiteColor;
    
    UILabel *nameLabel = [UILabel labelWithFont:Font_PingFang_SC_Bold(14) text:@"支付方式" textColor:rgb(53,53,53)];
    [self addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(15);
    }];
    
    OrderPayWayCell *cell1 = [OrderPayWayCell new];
    cell1.isSelected = YES;
    cell1.addressLabel.text = @"微信支付";
    [self addSubview:cell1];
    [cell1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(35);
        make.height.mas_equalTo(44);
        make.bottom.mas_equalTo(0);
    }];
}

@end
