//
//  BookTableViewCell.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/9/15.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "BookTableViewCell.h"
#import "BookSectionModel.h"

@implementation BookTableViewCell

- (void)initUI{
    self.backgroundColor = LZWhiteColor;
    
    UIImageView *imageView = [UIImageView new];
    UILabel *label_name = [UILabel labelWithFont:Font_PingFang_SC_Medium(14) text:@"" textColor:rgb(53,53,53)];
    UILabel *label_phone = [UILabel labelWithFont:Font_PingFang_SC_Medium(12) text:@"" textColor:rgb(152,152,152)];
    
    UILabel *label_money1 = [UILabel labelWithFont:Font_PingFang_SC_Medium(15) text:@"" textColor:rgb(53,53,53) textAlignment:NSTextAlignmentRight];
    
    _iconView = imageView;
    _label_status = label_name;
    _label_info = label_phone;
    _label_money = label_money1;
    
    [self.contentView addSubview:imageView];
    [self.contentView addSubview:label_name];
    [self.contentView addSubview:label_phone];
    [self.contentView addSubview:label_money1];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(42, 42));
    }];
    
    [label_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(17);
        make.left.mas_equalTo(imageView.mas_right).offset(10);
    }];
    
    [label_phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label_name);
        make.top.mas_equalTo(label_name.mas_bottom).offset(5);
    }];
    
    [label_money1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_equalTo(-15);
    }];
    
    [self addBottomLine];
    [self setBottomlineSpacingX:15];
    [self setBottomlineSpacingRightX:15];
}

- (void)setModel:(BookListModel *)model{
    _model = model;

    if ([model.payType hasPrefix:@"20"]) {
        self.iconView.image = UIImageName(@"zhifubao");
    }else{
        self.iconView.image = UIImageName(@"wechat");
    }

    //money
    NSString *money = [NSString stringWithFormat:@"%@元",[NSString formatFloatString:model.orderAmount]];
    self.label_money.text = money;
    //title
    self.label_status.text = model.statuStr;
    //money textColor
    self.label_money.textColor = getTextColorWithStatu(model.status);
    
    NSString *timeStr = model.createTime;
    if (model.createTime.length>=11) {
        timeStr = [model.createTime substringFromIndex:11];
    }
    
    NSString *transOrderNo = model.transOrderNo;
    if (model.transOrderNo.length>4) {
        transOrderNo = [NSString stringWithFormat:@"订单号****%@",[model.transOrderNo substringFromIndex:model.transOrderNo.length-4]];
    }else{
        transOrderNo = [NSString stringWithFormat:@"订单号%@",model.transOrderNo];
    }
    
    self.label_info.text = [NSString stringWithFormat:@"%@  %@",timeStr,transOrderNo];
}

@end
