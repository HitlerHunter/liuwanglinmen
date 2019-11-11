//
//  CouponDetailTableViewCell.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/31.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "CouponDetailTableViewCell.h"
#import "CouponVipModel.h"

@interface CouponDetailTableViewCell ()

@property (nonatomic, strong) UILabel *label_name;
@property (nonatomic, strong) UILabel *label_phone;
@property (nonatomic, strong) UIImageView *avatar;

@property (nonatomic, strong) UILabel *label_date1;
@property (nonatomic, strong) UILabel *label_date2;
@end

@implementation CouponDetailTableViewCell

- (void)initUI{
    
    self.backgroundColor = LZWhiteColor;
    
    UILabel *label_time1 = [UILabel labelWithFont:Font_PingFang_SC_Regular(12) text:@"" textColor:rgb(152,152,152) textAlignment:NSTextAlignmentCenter];
    label_time1.numberOfLines = 2;
    [self.contentView addSubview:label_time1];
    [label_time1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.centerX.mas_equalTo(self.contentView);
        make.height.mas_greaterThanOrEqualTo(29);
        make.width.mas_equalTo(71);
    }];
    
    UIImageView *imageView = [UIImageView new];
    [self.contentView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    
    UILabel *label_name = [UILabel labelWithFont:Font_PingFang_SC_Bold(14) text:@"" textColor:rgb(53,53,53)];
    [self.contentView addSubview:label_name];
    [label_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(64);
        make.height.mas_equalTo(18);
        make.right.mas_equalTo(label_time1.mas_left).offset(15);
    }];
    
    UILabel *label_phone = [UILabel labelWithFont:Font_PingFang_SC_Medium(12) text:@"" textColor:rgb(152,152,152)];
    [self.contentView addSubview:label_phone];
    [label_phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label_name);
        make.top.mas_equalTo(label_name.mas_bottom);
        make.width.mas_equalTo(label_name);
    }];
    
    _label_name = label_name;
    _label_phone = label_phone;
    _avatar = imageView;
    
    imageView.lz_setView.lz_cornerRadius(22);
    
    
    UILabel *label_time2 = [UILabel labelWithFont:Font_PingFang_SC_Regular(12) text:@"" textColor:rgb(152,152,152) textAlignment:NSTextAlignmentCenter];
    label_time2.numberOfLines = 2;
    [self.contentView addSubview:label_time2];
    [label_time2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.centerX.mas_equalTo(kScreenWidth/6*5-kScreenWidth*0.5);
        make.height.mas_greaterThanOrEqualTo(29);
        make.width.mas_lessThanOrEqualTo(71);
    }];
    
    _label_date1 = label_time1;
    _label_date2 = label_time2;
}

- (void)setModel:(CouponVipModel *)model{
    _model = model;
    
    if (!IsNull(model.avatar)) {
        [_avatar sd_setImageWithURL:TLURL(model.avatar) placeholderImage:UIImageName(@"touxiang")];
    }else{
        _avatar.image = UIImageName(@"touxiang");
    }
    
    _label_name.text = IsNull(model.nickName)?@"会员昵称":model.nickName;
//    _label_phone.text = [NSString stringWithFormat:@"会员ID:%@",model.userId];
    _label_phone.text = IsNull(model.phone)?@"":model.phone;
    
    if (IsNull(model.verifyTime)) {
        _label_date2.text = @"未核销";
    }else {
        _label_date2.text = model.verifyTime;
    }
    
    _label_date1.text = model.createTime;
}
@end
