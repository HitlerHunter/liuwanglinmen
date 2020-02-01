//
//  MineTeamCell.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/24.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "MineTeamCell.h"
#import "ManManagerModel.h"

@interface MineTeamCell ()

@property (nonatomic, strong) UIImageView *avatar;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UILabel *dateLabel;

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *label_vip;
@end

@implementation MineTeamCell

- (void)initUI{
    
    UIImageView *avatar = [UIImageView new];
    [self.contentView addSubview:avatar];
    [avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(7);
        make.size.mas_equalTo(CGSizeMake(38, 38));
    }];
    avatar.lz_setView.lz_cornerRadius(19).lz_border(0.5, LZLineColor);
    
    UILabel *lab1 = [UILabel labelWithFont:Font_PingFang_SC_Bold(13) text:@"11" textColor:rgb(53,53,53)];
    [self.contentView addSubview:lab1];
    [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(16);
        make.left.mas_equalTo(avatar.mas_right).offset(7);
    }];
    
    //皇冠
    UIImageView *icon = [UIImageView new];
    [self.contentView addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(lab1);
        make.left.mas_equalTo(lab1.mas_right).offset(4);
        make.size.mas_equalTo(CGSizeMake(14, 14));
    }];
    //vip
    UILabel *lab_vip = [UILabel labelWithFont:Font_PingFang_SC_Medium(13) text:@"11" textColor:rgb(53,53,53)];
    [self.contentView addSubview:lab_vip];
    [lab_vip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(lab1);
        make.left.mas_equalTo(icon.mas_right).offset(5);
    }];
    
    UILabel *lab2 = [UILabel labelWithFont:Font_PingFang_SC_Medium(11) text:@"11" textColor:rgb(101,101,101)];
    [self.contentView addSubview:lab2];
    [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(avatar.mas_centerY);
        make.left.mas_equalTo(lab1);
    }];
    
    UILabel *lab3 = [UILabel labelWithFont:Font_PingFang_SC_Medium(11) text:@"11" textColor:rgb(101,101,101)];
    [self.contentView addSubview:lab3];
    [lab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(lab2);
        make.right.mas_equalTo(-15);
    }];
    
    _avatar = avatar;
    _nameLabel = lab1;
    _phoneLabel = lab2;
    _dateLabel = lab3;
    _icon = icon;
    _label_vip = lab_vip;
    
    [self addBottomLine];
}

- (void)setModel:(ManManagerModel *)model{
    _model = model;
    
    _nameLabel.text = model.usrName;
    _phoneLabel.text = model.mobile.phoneTakeSecure;
    _dateLabel.text = [model.createTime substringToIndex:10];
    
    _avatar.image = [AppCenter appIcon];
    if (!IsNull(model.nickUrl)) {
        [_avatar sd_setImageWithURL:TLURL(model.nickUrl) placeholderImage:[AppCenter appIcon]];
    }
    
    NSString *icon = getRoleIconWithLevel(model.userLvl);
    _icon.image = UIImageName(icon);
    
    NSString *type = getRoleNameWithLZUserTypeAndLevel(getLZUserTypeWithType(model.usrType),model.userLvl);
    _label_vip.text = type;
}

@end
