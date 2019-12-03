//
//  MerchantManagerCell.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/11/22.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "MerchantManagerCell.h"
#import "MerchantManagerModel.h"

@interface MerchantManagerCell ()

@property (nonatomic, strong) UIImageView *logo;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UILabel *statuLabel;
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) UIImageView *icon;
@end

@implementation MerchantManagerCell

- (void)initUI{
    
    UIImageView *logo = [UIImageView new];
    [self.contentView addSubview:logo];
    [logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    logo.lz_setView.lz_cornerRadius(20).lz_border(1, rgb(210,210,210));
    
    UILabel *lab1 = [UILabel labelWithFontSize:12 text:@"" textColor:rgb(18,18,18)];
    [self.contentView addSubview:lab1];
    [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(logo.mas_right).offset(8);
        make.bottom.mas_equalTo(logo.mas_centerY).offset(-1);
    }];
    
    UILabel *lab2 = [UILabel labelWithFontSize:11 text:@"" textColor:rgb(101,101,101)];
    [self.contentView addSubview:lab2];
    [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lab1);
        make.top.mas_equalTo(logo.mas_centerY).offset(1);
    }];
    
    UIButton *btn = [UIButton buttonWithFontSize:12 text:@"拒绝理由" textColor:rgb(253,28,44)];
    [self.contentView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(52, 16));
    }];
    
    UILabel *lab_status = [UILabel labelWithFontSize:12 text:@"审核拒绝" textColor:rgb(152,152,152)];
    [self.contentView addSubview:lab_status];
    [lab_status mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(btn.mas_left).offset(-8);
        make.centerY.mas_equalTo(0);
    }];
    
    UIImageView *icon = [UIImageView new];
    [self.contentView addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(lab_status.mas_left).offset(-4);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(17, 17));
    }];
 
    _logo = logo;
    _titleLab = lab1;
    _phoneLabel = lab2;
    _statuLabel = lab_status;
    _icon = icon;
    _btn = btn;
    
    [self addBottomLine];
    
    [btn addTarget:self action:@selector(showReason) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setModel:(MerchantManagerModel *)model{
    _model = model;
    
    _titleLab.text = model.pmsMerchantInfo.shortMerchantName;
    _phoneLabel.text = model.pmsMerchantInfo.linkmanMobile.phoneTakeSecure;
    
    _btn.hidden = YES;
    if (model.pmsMerchantInfo.status_lz == AuthenMerchantStatusReviewing) {
        _statuLabel.text = @"审核中";
        _icon.image = UIImageName(@"merchant_review");
        [_statuLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(0);
        }];
    }else if (model.pmsMerchantInfo.status_lz == AuthenMerchantStatusSuccess) {
        _statuLabel.text = @"审核通过";
        _icon.image = UIImageName(@"board_selected");
        [_statuLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(0);
        }];
        
    }else if (model.pmsMerchantInfo.status_lz == AuthenMerchantStatusRefund) {
        _statuLabel.text = @"审核拒绝";
        _btn.hidden = NO;
        _icon.image = UIImageName(@"messageReview_NoPass_status");
        [_statuLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.btn.mas_left).offset(-8);
            make.centerY.mas_equalTo(0);
        }];
    }
    
    [_logo sd_setImageWithURL:TLURL(model.pmsMerchantPicture.shopPhoto) placeholderImage:[AppCenter defaultAppAvatar]];
}

- (void)showReason{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"拒绝理由" message:_model.pmsMerchantInfo.checkRemark preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:cancel];
    [self.viewController presentViewController:alert animated:YES completion:nil];
}

@end
