//
//  RewardCityCell.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/8.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "RewardCityCell.h"
#import "RewardCityModel.h"

@interface RewardCityCell ()

@property (nonatomic, strong) UILabel *shopNameLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *distanceLabel;//距离
@property (nonatomic, strong) UILabel *infoLabel1;
@property (nonatomic, strong) UILabel *infoLabel2;

@property (nonatomic, strong) UIImageView *logo;
@end

@implementation RewardCityCell

- (void)initUI{
    UIImageView *logo = [UIImageView new];
    [self.contentView addSubview:logo];
    [logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(67, 67));
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    UILabel *label1 = [UILabel labelWithFont:Font_PingFang_SC_Bold(15) text:@"云水肴·云之南(德思勤店)" textColor:rgb(53,53,53)];
    [self.contentView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(logo.mas_right).offset(10);
        make.top.mas_equalTo(logo);
        make.right.mas_equalTo(-50);
    }];
    
    UIImageView *locationLogo = [UIImageView viewWithImage:UIImageName(@"location_gray")];
    [self.contentView addSubview:locationLogo];
    [locationLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(13, 13));
        make.left.mas_equalTo(label1);
//        make.centerY.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(logo.mas_bottom).offset(-5);
    }];
    
    UILabel *label2 = [UILabel labelWithFont:Font_PingFang_SC_Medium(12) text:@"雨花区德思勤城市广场一期" textColor:rgb(152,152,152)];
    [self.contentView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(locationLogo.mas_right).offset(3);
        make.centerY.mas_equalTo(locationLogo);
        make.right.mas_equalTo(-65);
    }];
    
    
    UILabel *label3 = [UILabel labelWithFont:Font_PingFang_SC_Medium(12)
                                        text:@"<1.5公里"
                                   textColor:rgb(152,152,152)
                               textAlignment:NSTextAlignmentRight];
    [self.contentView addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(self.contentView);
        make.width.mas_greaterThanOrEqualTo(65);
    }];
    
    /*
    UILabel *label4 = [UILabel labelWithFont:Font_PingFang_SC_Medium(10)
                                        text:@"再买返21%"
                                   textColor:rgb(101,101,101)
                               textAlignment:NSTextAlignmentCenter];
    [self.contentView addSubview:label4];
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label1);
        make.bottom.mas_equalTo(logo.mas_bottom).offset(-3);
    }];
    label4.lz_setView.lz_cornerRadius(2).lz_border(1, rgb(202,202,202));
    
    UILabel *label5 = [UILabel labelWithFont:Font_PingFang_SC_Medium(10)
                                        text:@"分享好友奖励24%"
                                   textColor:rgb(101,101,101)
                               textAlignment:NSTextAlignmentCenter];
    [self.contentView addSubview:label5];
    [label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label4.mas_right).offset(5);
        make.centerY.mas_equalTo(label4);
    }];
    label5.lz_setView.lz_cornerRadius(2).lz_border(1, rgb(202,202,202));
    
     _infoLabel1 = label4;
     _infoLabel2 = label5;
     
     _infoLabel1.hidden = YES;
     _infoLabel2.hidden = YES;
     _distanceLabel.hidden = YES;
     */
    
    _distanceLabel = label3;
    _shopNameLabel = label1;
    _addressLabel = label2;
    _logo = logo;
    
    [self addBottomLine];
    
}

- (void)setModel:(RewardCityModel *)model{
    _model = model;
    
    _shopNameLabel.text = model.shopName;
    _distanceLabel.text = model.showDistance;
    _addressLabel.text = model.showAddress;
    
    [_logo sd_setImageWithURL:TLURL(model.shopLog) placeholderImage:nil];
}



@end
