//
//  VipPersonCell.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/24.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "VipPersonCell.h"
#import "VipPersonModel.h"

@interface VipPersonCell ()

@end

@implementation VipPersonCell

- (void)initUI{
    
    self.backgroundColor = LZBackgroundColor;
    
    UIView *bgView = [UIView new];
    bgView.backgroundColor = LZWhiteColor;
    [self.contentView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(5, 15, 5, 15));
    }];
    bgView.lz_setView.lz_cornerRadius(6);
    
    UIImageView *imageView = [UIImageView new];
    UILabel *label_name = [UILabel labelWithFont:Font_PingFang_SC_Bold(16) text:@"" textColor:rgb(53,53,53)];
    label_name.adjustsFontSizeToFitWidth = YES;
    
    UILabel *label_phone = [UILabel labelWithFont:Font_PingFang_SC_Medium(13) text:@"" textColor:rgb(152,152,152)];

    UILabel *label_money1 = [UILabel labelWithFont:Font_PingFang_SC_Medium(12) text:@"" textColor:rgb(53,53,53) textAlignment:NSTextAlignmentCenter];
    UILabel *label_money2 = [UILabel labelWithFont:Font_PingFang_SC_Medium(12) text:@"" textColor:rgb(53,53,53) textAlignment:NSTextAlignmentCenter];

    UIImageView *moreIcon = [UIImageView viewWithImage:UIImageName(@"more_gray")];
    
    _headImage = imageView;
    _label_name = label_name;
    _label_phone = label_phone;
    
    _label_money1 = label_money1;
    _label_money2 = label_money2;
    
    [bgView addSubview:imageView];
    [bgView addSubview:label_name];
    [bgView addSubview:label_phone];
    
    [bgView addSubview:label_money1];
    [bgView addSubview:label_money2];
    [bgView addSubview:moreIcon];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(bgView);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [label_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(19);
        make.left.mas_equalTo(imageView.mas_right).offset(11);
        make.height.mas_equalTo(18);
        make.width.mas_lessThanOrEqualTo(150);
    }];
    
    [label_phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label_name.mas_right).offset(10);
        make.centerY.mas_equalTo(label_name);
        make.width.mas_lessThanOrEqualTo(90);
    }];
    
    imageView.lz_setView.lz_cornerRadius(25).lz_border(0.5, LZLineColor);
    
    [label_money1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label_name.mas_bottom).offset(6);
        make.height.mas_equalTo(16);
        make.left.mas_equalTo(label_name);
    }];
    
    [label_money2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(label_money1);
        make.left.mas_equalTo(label_money1.mas_right).offset(5);
    }];
 
    [moreIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bgView);
        make.right.mas_equalTo(-20);
    }];
}

- (void)setModel:(VipPersonModel *)model{
    _model = model;
    
    [self.headImage sd_setImageWithURL:TLURL(model.txnUserHeader) placeholderImage:[AppCenter appIcon]];
    
    if (model.txnUserName.length) {
        self.label_name.text = model.txnUserName;
    }else{
        self.label_name.text = [NSString stringWithFormat:@"会员ID:%@",model.txnUsrNo];
    }
    
    self.label_phone.text = IsNull(model.txnUserMobile)?@"":model.txnUserMobile.phoneTakeSecure;
    
    NSDictionary *defaultAtt = @{NSFontAttributeName:Font_PingFang_SC_Medium(12),
                                 NSForegroundColorAttributeName:rgb(152,152,152),
                                 };
    NSDictionary *numberAtt = @{NSFontAttributeName:Font_PingFang_SC_Medium(12),
                                 NSForegroundColorAttributeName:rgb(255,81,0),
                                 };
    
    //money
    NSMutableAttributedString *attTitle = [[NSMutableAttributedString alloc] initWithString:@"总支付金额：元" attributes:defaultAtt];
    
    if (model.consumerAmt.length) {
        NSMutableAttributedString *attMoney = [[NSMutableAttributedString alloc] initWithString:[NSString formatMoneyCentToYuanString:model.consumerAmt] attributes:numberAtt];
        [attTitle insertAttributedString:attMoney atIndex:attTitle.length-1];
    }
    
    self.label_money1.attributedText = attTitle;
    
    //number
    NSMutableAttributedString *attTitle2 = [[NSMutableAttributedString alloc] initWithString:@"消费次数：次" attributes:defaultAtt];
    
    if (model.consumerTimes.length) {
        NSMutableAttributedString *attNumber = [[NSMutableAttributedString alloc] initWithString:model.consumerTimes attributes:numberAtt];
        [attTitle2 insertAttributedString:attNumber atIndex:attTitle2.length-1];
    }
    
    self.label_money2.attributedText = attTitle2;
}

@end
