//
//  MineAddressCell.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/11/19.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "MineAddressCell.h"
#import "MineAddressModel.h"
#import "CreatMineAddressViewController.h"

@interface MineAddressCell ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UILabel *addressLabel;

@property (nonatomic, strong) UIButton *editBtn;
@property (nonatomic, strong) UILabel *defaultLabel;

@end

@implementation MineAddressCell

- (void)initUI{
    
    self.backgroundColor = LZWhiteColor;
    
    UILabel *nameLabel = [UILabel labelWithFont:Font_PingFang_SC_Bold(14) text:@"" textColor:rgb(53,53,53)];
    [self.contentView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(13);
    }];
    
    UILabel *phoneLabel = [UILabel labelWithFont:Font_PingFang_SC_Medium(12) text:@"" textColor:rgb(152,152,152)];
    [self.contentView addSubview:phoneLabel];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameLabel.mas_right).offset(10);
        make.centerY.mas_equalTo(nameLabel);
    }];
     
    UIButton *editBtn = [UIButton buttonWithFontSize:12 text:@"编辑" textColor:rgb(152,152,152)];
    [self.contentView addSubview:editBtn];
    [editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(54, 30));
        make.top.mas_equalTo(nameLabel.mas_bottom).offset(5);
    }];
    
    UIView *line = [UIView new];
    line.backgroundColor = rgb(226,226,226);
    [editBtn addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(1, 24));
        make.centerY.mas_equalTo(0);
    }];
    
    UILabel *addressLabel = [UILabel labelWithFont:Font_PingFang_SC_Medium(13) text:@"" textColor:rgb(53,53,53)];
   addressLabel.numberOfLines = 2;
   [self.contentView addSubview:addressLabel];
   [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.mas_equalTo(nameLabel);
       make.right.mas_equalTo(-65);
       make.centerY.mas_equalTo(editBtn);
   }];
    
    UILabel *defaultLabel = [UILabel labelWithFont:Font_PingFang_SC_Medium(12) text:@"默认" textColor:rgb(255,81,0) textAlignment:NSTextAlignmentCenter];
    defaultLabel.backgroundColor = rgb(255,243,235);
    [self.contentView addSubview:defaultLabel];
    [defaultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameLabel);
        make.size.mas_equalTo(CGSizeMake(36, 18));
        make.top.mas_equalTo(addressLabel).offset(0);
    }];
    
    _nameLabel = nameLabel;
    _phoneLabel = phoneLabel;
    _editBtn = editBtn;
    _addressLabel = addressLabel;
    _defaultLabel = defaultLabel;
    
    @weakify(self);
    [editBtn addTouchAction:^(UIButton *sender) {
        @strongify(self);
        CreatMineAddressViewController *vc = [[CreatMineAddressViewController alloc] initWithModel:self.model];
        PushController(vc);
    }];
}

- (void)setModel:(MineAddressModel *)model{
    _model = model;
    
    _nameLabel.text = model.userName;
    _phoneLabel.text = model.mobile;
    _defaultLabel.hidden = !model.isDefault;
    
    NSMutableAttributedString *addressStr = [[NSMutableAttributedString alloc] initWithString:model.showAddress];
    
    if (model.isDefault) {
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.firstLineHeadIndent = 45;
        
        [addressStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, model.showAddress.length)];

    }
    
    _addressLabel.attributedText = addressStr;
}

@end
