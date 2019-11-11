//
//  CouponVipCell.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/30.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "CouponVipCell.h"
#import "CouponVipModel.h"

@interface CouponVipCell ()

@property (nonatomic, strong) UIButton *chioceBtn;

@property (nonatomic, strong) UILabel *label_name;
@property (nonatomic, strong) UILabel *label_phone;

@property (nonatomic, strong) UIImageView *avatar;
@end

@implementation CouponVipCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initUI{
    
    self.backgroundColor = LZBackgroundColor;
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.userInteractionEnabled = NO;
    [rightBtn setImage:UIImageName(@"coupon_unSelected") forState:UIControlStateNormal];
    [rightBtn setImage:UIImageName(@"coupon_selected") forState:UIControlStateSelected];
    
    [self.contentView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-5);
        make.top.bottom.mas_equalTo(self.contentView);
        make.width.mas_equalTo(32);
    }];
    
    _chioceBtn = rightBtn;
    
    UIImageView *imageView = [UIImageView new];
    
    UILabel *label_name = [UILabel labelWithFont:Font_PingFang_SC_Bold(16) text:@"" textColor:rgb(53,53,53)];
    label_name.adjustsFontSizeToFitWidth = YES;
    
    UILabel *label_phone = [UILabel labelWithFont:Font_PingFang_SC_Medium(13) text:@"" textColor:rgb(152,152,152)];
    
    [self.contentView addSubview:imageView];
    [self.contentView addSubview:label_name];
    [self.contentView addSubview:label_phone];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [label_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(imageView.mas_right).offset(11);
//        make.height.mas_equalTo(18);
        make.right.mas_equalTo(-50);
        
    }];
    
    [label_phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label_name);
        make.top.mas_equalTo(label_name.mas_bottom);
        make.right.mas_equalTo(-50);
    }];
    
    _label_name = label_name;
    _label_phone = label_phone;
    _avatar = imageView;
    
    imageView.lz_setView.lz_cornerRadius(25);
}

- (void)setModel:(CouponVipModel *)model{
    _model = model;
    
    if (!IsNull(model.avatar)) {
        [_avatar sd_setImageWithURL:TLURL(model.avatar) placeholderImage:UIImageName(@"touxiang")];
    }else{
        _avatar.image = UIImageName(@"touxiang");
    }
    
    NSMutableString *nickName = [[NSMutableString alloc] init];
    if (!IsNull(model.nickName)) {
        [nickName appendString:model.nickName];
        
    }
    if (!IsNull(model.phone)) {
        NSString *phone = [model.phone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        [nickName appendString:phone];
    }
    
    if (nickName.length) {
        _label_name.text = nickName;
        _label_phone.text = [NSString stringWithFormat:@"会员ID:%@",model.userId];
        
        [_label_name mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(15);
        }];
    }else{
        _label_name.text = [NSString stringWithFormat:@"会员ID:%@",model.userId];
        _label_phone.text = @"";
        
        [_label_name mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(23);
        }];
    }
    
    
    
    @weakify(self);
    [[RACObserve(model, isSelected) takeUntil:self.rac_prepareForReuseSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.chioceBtn.selected = model.isSelected;
    }];
}

@end
